#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Prepare/open a local Studio kit using installed Mac tools and cached assets only."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tarfile
import tempfile

APP = Path(__file__).resolve().parents[1]
REPO = APP.parent.parent
TC_FILES = ('pi32v2/bin/clang', 'pi32v2/bin/ld', 'common/bin/objdump',
            'pi32v2/lib/r3/libm.a', 'pi32v2/lib/r3/libcompiler-rt.a')


def digest(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def run(command, timeout=30):
    result = subprocess.run(list(map(str, command)), capture_output=True, text=True, timeout=timeout)
    if result.returncode:
        raise ValueError((result.stderr.strip() or result.stdout.strip() or 'Command failed')[-1200:])
    return result.stdout.strip()


def image_info(reference, platform=False):
    args = ['docker', 'image', 'inspect']
    if platform:
        args += ['--platform', 'linux/amd64']
    entries = json.loads(run([*args, reference]))
    if not isinstance(entries, list) or len(entries) != 1 or not isinstance(entries[0], dict):
        raise ValueError('Cannot identify the cached compiler image')
    info = entries[0]
    if info.get('Os') != 'linux' or info.get('Architecture') != 'amd64' or not re.fullmatch(r'sha256:[0-9a-f]{64}', info.get('Id', '')):
        raise ValueError('The cached compiler image must be Linux amd64. Prepare it with the pinned image and --platform linux/amd64.')
    return info


def cached_image(reference):
    # Inspect never downloads. Older Docker versions can omit --platform when
    # their single cached variant is already amd64; the architecture is checked.
    try:
        return image_info(reference, platform=True)
    except ValueError:
        return image_info(reference)


def cached_inputs(repo):
    """Validate existing inputs before spending time rebuilding the release."""
    dependencies = json.loads((repo / 'setup/dependencies.json').read_text())
    compiler = dependencies['toolchain']
    archive = repo / compiler['archive']
    if not archive.is_file() or digest(archive) != compiler['sha256']:
        raise ValueError('Local release needs the pinned compiler archive. Run Setup.command once online, then retry.')
    try:
        info = cached_image(dependencies['docker_image'])
    except (ValueError, OSError, subprocess.TimeoutExpired) as error:
        raise ValueError('Start Docker Desktop and cache the pinned Linux amd64 image before packaging. '
                         'See QUICKSTART.md, Preparing the release. ' + str(error)) from error
    return dependencies, compiler, archive, info


def package(stage, repo, paths, inputs=None):
    """Add a converter and compiler caches to an already reviewed release stage."""
    dependencies, compiler, archive, info = inputs or cached_inputs(repo)
    converter = stage / 'converter'
    for relative in paths:
        target = converter / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(repo / relative, target)
    for relative in ('fm1-base/rnbo-loader/tools/build_service.py', 'fm1-base/rnbo-loader/tools/launch.py',
                     'fm1-base/rnbo/tools/export.cjs', 'fm1-base/tools/build.py', 'setup/dependencies.json'):
        if not (converter / relative).is_file():
            raise ValueError('Local converter source is missing: ' + relative)
    cache = stage / 'cache'
    cache.mkdir()
    print('Copying the cached compiler…', flush=True)
    shutil.copy2(archive, cache / 'toolchain.tar.xz')
    if digest(cache / 'toolchain.tar.xz') != compiler['sha256']:
        raise ValueError('Compiler archive changed while preparing the release')
    image = cache / 'compiler-image.tar'
    print('Saving the cached compiler image for offline use…', flush=True)
    run(['docker', 'image', 'save', '--output', image, info['Id']], timeout=300)
    manifest = {'format': 1, 'version': 1, 'toolchain': {
        'file': 'cache/toolchain.tar.xz', 'sha256': compiler['sha256'], 'directory': compiler['distribution']},
        'image': {'file': 'cache/compiler-image.tar', 'sha256': digest(image),
                  'id': info['Id'], 'origin': dependencies['docker_image']}}
    (stage / 'offline.json').write_text(json.dumps(manifest, indent=2) + '\n')
    shutil.copy2(APP / 'tools/offline.py', stage / 'tools/offline.py')
    for name, option in [('Open-Studio.command', ''), ('Check-Setup.command', ' --check')]:
        launcher = stage / name
        launcher.write_text('#!/bin/bash\nset -euo pipefail\n'
                            'studio_dir="$(cd "$(dirname "$0")" && pwd -P)"\n'
                            '# Finder does not inherit the usual Homebrew or Docker PATH.\n'
                            'export PATH="/opt/homebrew/bin:/usr/local/bin:/Applications/Docker.app/Contents/Resources/bin:$PATH"\n'
                            'if ! command -v python3 >/dev/null; then\n'
                            '  echo "Install Python 3.12 or newer. See QUICKSTART.md."; exit 1\nfi\n'
                            'if python3 "$studio_dir/tools/offline.py"'+option+' "$@"; then exit 0; fi\n'
                            'if [ -t 0 ]; then read -r -p "Press Return to close. " studio_answer || true; fi\n'
                            'exit 1\n')
        launcher.chmod(0o755)
    shutil.copy2(repo / 'QUICKSTART.md', stage / 'QUICKSTART.md')
    (stage / 'START-HERE.txt').write_text(
        'FM1 Studio — local/offline\n\n'
        '1. Keep this whole folder together in a writable location, such as Documents.\n'
        '2. Start Docker Desktop. Open Open-Studio.command.\n'
        '3. In Chrome/Edge, allow MIDI + SysEx and connect the FM1.\n'
        '4. Install the included player once if needed.\n'
        '5. Choose a library patch, or your .rnbopat and its voice count.\n'
        '6. Choose a slot, then Build & Upload (source) or Upload Patch (compiled).\n\n'
        'PRESETS switches patches. SAVE stores this slot’s controls and startup selection.\n'
        'Build Only works without an FM1 connected. Stop Local Service when finished.\n\n'
        'Read QUICKSTART.md for the installed Mac requirements and troubleshooting.\n'
        'No Setup.command, Git, pip or network downloads are used by this release.\n'
        'A Max 9 license AND a separate RNBO license are required.\n'
        'Install and authorize Max 9 and RNBO 1.4.4 before offline use.\n'
        'Neither license nor the installed RNBO package is bundled.\n'
        'Check-Setup.command reports readiness without importing/extracting caches.\n')


def load_manifest(root):
    data = json.loads((root / 'offline.json').read_text())
    if data.get('format') != 1 or data.get('version') != 1:
        raise ValueError('Unsupported local release. Keep all files from the same release together.')
    for key, filename in [('toolchain', 'cache/toolchain.tar.xz'), ('image', 'cache/compiler-image.tar')]:
        item = data.get(key, {})
        if item.get('file') != filename or not re.fullmatch('[0-9a-f]{64}', item.get('sha256', '')):
            raise ValueError('Invalid local release cache metadata')
        path = root / filename
        if not path.is_file() or path.is_symlink():
            raise ValueError('Missing local release cache: ' + filename)
    if not re.fullmatch(r'jieli-linux-toolchains-[0-9.]+', data['toolchain'].get('directory', '')) or not re.fullmatch(r'sha256:[0-9a-f]{64}', data['image'].get('id', '')):
        raise ValueError('Invalid compiler identity')
    pinned = json.loads((root / 'converter/setup/dependencies.json').read_text())
    if (data['toolchain']['sha256'] != pinned['toolchain']['sha256'] or
        data['toolchain']['directory'] != pinned['toolchain']['distribution'] or
        data['image'].get('origin') != pinned['docker_image']):
        raise ValueError('Compiler caches do not match the pinned release dependencies')
    return data


def find_rnbo(candidates=None):
    if candidates is None:
        candidates = [os.environ.get('RNBO_DIR'),
                  Path.home() / 'Documents/Max 9/Packages/RNBO',
                  Path('/Applications/Max.app/Contents/Resources/C74/packages/RNBO')]
    for candidate in candidates:
        if not candidate:
            continue
        path = Path(candidate).expanduser()
        try:
            version = json.loads((path / 'package-info.json').read_text()).get('version')
        except (OSError, ValueError):
            continue
        if version == '1.4.4' and all((path / p).exists() for p in
            ('server/node_modules/@rnbo/xam', 'server/node_modules/@rnbo/xam-runner', 'source/rnbo/common')):
            return path.resolve()
    raise ValueError('A Max 9 license and a separate RNBO license are required. Install/authorize Max 9 and RNBO 1.4.4 before offline use. For a custom RNBO package location, set RNBO_DIR.')


def find_browser():
    for parent in (Path('/Applications'), Path.home() / 'Applications'):
        for name in ('Google Chrome.app', 'Microsoft Edge.app'):
            if (parent / name).is_dir():
                return name.removesuffix('.app')
    raise ValueError('Install Chrome or Edge, then reopen Studio.')


def extract_compiler(root, manifest):
    item = manifest['toolchain']
    destination = root / 'cache' / item['directory']
    if destination.is_dir() and not destination.is_symlink() and all((destination / p).is_file() for p in TC_FILES):
        return destination
    if destination.exists():
        raise ValueError('Incomplete extracted compiler. Remove only cache/' + item['directory'] + ' and reopen Studio.')
    archive = root / item['file']
    if digest(archive) != item['sha256']:
        raise ValueError('Compiler archive checksum failed. Restore a fresh copy of this release.')
    print('Preparing the bundled compiler for first use…', flush=True)
    with tempfile.TemporaryDirectory(prefix='.compiler-', dir=root / 'cache') as temporary:
        with tarfile.open(archive, 'r:xz') as source:
            source.extractall(temporary, filter='data')
        extracted = Path(temporary) / item['directory']
        if not all((extracted / p).is_file() for p in TC_FILES):
            raise ValueError('Compiler archive is incomplete')
        extracted.rename(destination)
    return destination


def ensure_image(root, manifest, prepare=False):
    item = manifest['image']
    try:
        info = image_info(item['id'])
    except ValueError:
        archive = root / item['file']
        if digest(archive) != item['sha256']:
            raise ValueError('Compiler image checksum failed. Restore a fresh copy of this release.')
        if not prepare:
            return 'ready to import offline on first open'
        print('Importing the bundled compiler image for first use…', flush=True)
        run(['docker', 'image', 'load', '--input', archive], timeout=300)
        info = image_info(item['id'])
    if info['Id'] != item['id']:
        raise ValueError('Unexpected cached compiler image identity')
    return 'ready'


def check(root, manifest, prepare=False):
    print('Requires a Max 9 license and a separate RNBO license, authorized in Max before offline use.', flush=True)
    rows, env = [], dict(os.environ)
    def probe(name, action):
        try:
            detail = action()
            rows.append((True, name, str(detail or 'ready')))
            return detail
        except (ValueError, OSError, subprocess.SubprocessError) as error:
            rows.append((False, name, str(error)))
            return None
    def host():
        if sys.platform != 'darwin':
            raise ValueError('This converter release targets macOS.')
        return 'ready'
    def python():
        if sys.version_info < (3, 12):
            raise ValueError('Install Python 3.12 or newer.')
        return sys.version.split()[0]
    probe('macOS', host)
    probe('Python', python)
    def node():
        value = run(['node', '--version'])
        if int(value.lstrip('v').split('.')[0]) < 20:
            raise ValueError('Install Node.js 20 or newer.')
        return value
    probe('Node.js', node)
    rnbo = probe('RNBO 1.4.4 package', find_rnbo)
    if rnbo:
        env['RNBO_DIR'] = str(rnbo)
    def clang():
        for executable in ('clang', 'clang++'):
            run([executable, '--version'])
        return 'ready'
    probe('Apple command-line tools', clang)
    probe('Browser', find_browser)
    docker = probe('Docker Desktop', lambda: run(['docker', 'info', '--format', '{{.ServerVersion}}']))
    if docker:
        probe('Compiler image', lambda: ensure_image(root, manifest, prepare=prepare and all(ok for ok, _, _ in rows)))
    def archive():
        if digest(root / manifest['toolchain']['file']) != manifest['toolchain']['sha256']:
            raise ValueError('Compiler checksum failed. Restore this release.')
        return 'ready'
    probe('Compiler archive', archive)
    if prepare and all(ok for ok, _, _ in rows):
        toolchain = probe('Compiler', lambda: extract_compiler(root, manifest))
        if toolchain:
            probe('Compiler execution', lambda: run(['docker', 'run', '--rm', '--pull=never', '--network=none',
                '--platform', 'linux/amd64', '-v', str(toolchain)+':/opt/jieli:ro', manifest['image']['id'],
                '/opt/jieli/pi32v2/bin/clang', '--version']))
            env.update(JIELI_TOOLCHAIN=str(toolchain), JIELI_DOCKER='1', JIELI_DOCKER_IMAGE=manifest['image']['id'], FM1_OFFLINE='1')
    for ok, name, detail in rows:
        print(('OK   ' if ok else 'FIX  ') + name + ': ' + detail, flush=True)
    return all(ok for ok, _, _ in rows), env


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--check', action='store_true', help='Report readiness without extracting/importing caches or opening Studio')
    parser.add_argument('--no-open', action='store_true')
    args = parser.parse_args()
    root = args.root.expanduser().resolve()
    manifest = load_manifest(root)
    ready, env = check(root, manifest, prepare=not args.check)
    if args.check:
        return 0 if ready else 1
    if not ready:
        print('Resolve the FIX lines above, then open Open-Studio.command again. See QUICKSTART.md.', flush=True)
        return 1
    launcher = root / 'converter/fm1-base/rnbo-loader/tools/launch.py'
    command = [sys.executable, str(launcher), '--release', str(root / 'web')]
    if args.no_open:
        command.append('--no-open')
    subprocess.run(command, env=env, cwd=root / 'converter', check=True)
    return 0


if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except (ValueError, OSError, subprocess.SubprocessError, tarfile.TarError) as error:
        print('Studio could not open: ' + str(error), file=sys.stderr)
        raise SystemExit(1)
