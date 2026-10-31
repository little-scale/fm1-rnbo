#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Build a local Studio release candidate. Never installs or publishes anything."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile

APP = Path(__file__).resolve().parents[1]
BASE = APP.parent
REPO = BASE.parent
STUDIO_FILES = ['docs/STUDIO.md', 'QUICKSTART.md'] + ['fm1-base/rnbo-loader/' + name for name in (
    'Build-Studio-Release.command', 'Build-Local-Studio.command', 'Open-Studio.command', 'tools/release.py', 'tools/offline.py',
    'tools/launch.py', 'tools/source-inventory.json', 'web/studio.js', 'tests/studio.cjs', 'tests/studio-ui.cjs',
    'tests/studio-release.py', 'tests/offline.py')]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def require(condition, message):
    if not condition:
        raise ValueError(message)


def git_output(*arguments):
    # Working source folders need neither Git metadata nor the Git executable.
    if not (REPO / '.git').exists() or not shutil.which('git'):
        return None
    result = subprocess.run(['git', *arguments], cwd=REPO, capture_output=True)
    return result.stdout if result.returncode == 0 else None


def source_files():
    # Use an explicit public source inventory in plain folders. Never recursively
    # collect personal/untracked files, dependency downloads or build outputs.
    raw = git_output('ls-files', '-z')
    if raw is not None:
        names = [p.decode() for p in raw.split(b'\0') if p]
    else:
        inventory = read(APP / 'tools/source-inventory.json')
        require(inventory.get('format') == 1 and isinstance(inventory.get('files'), list),
                'Invalid Studio source inventory')
        names = inventory['files']
    names = list(names) + [p for p in STUDIO_FILES if (REPO / p).is_file()]
    paths = set()
    for name in names:
        require(isinstance(name, str), 'Invalid source inventory entry')
        path = Path(name)
        require(not path.is_absolute() and '..' not in path.parts and '.git' not in path.parts,
                'Source inventory path must stay inside the project')
        absolute = REPO / path
        if not absolute.exists():
            continue  # A plain working folder can omit unused examples/documentation.
        require(absolute.is_file() and not absolute.is_symlink() and
                absolute.resolve().is_relative_to(REPO.resolve()),
                'Nonregular or outside source inventory file: ' + name)
        paths.add(path)
    require(paths, 'No project source files found')
    return sorted(paths)


def source_commit():
    raw = git_output('rev-parse', 'HEAD')
    return raw.decode().strip() if raw else None


def fingerprint(paths):
    h = hashlib.sha256()
    for path in sorted(paths):
        h.update(str(path).encode() + b'\0')
        h.update((REPO / path).read_bytes())
        h.update(b'\0')
    return h.hexdigest()


def catalogue():
    return {'format': 1, 'patches': [{k: case[k] for k in
            ('id', 'title', 'bank', 'slot', 'kind', 'listen', 'parameters')}
            for case in read(APP / 'hardware-tests/manifest.json')['patches']]}


def collect():
    """Reuse the upload group's native/audition/source/config/package checks."""
    sys.path.insert(0, str(APP / 'hardware-tests'))
    from prepare import collect as collect_group
    groups = [collect_group(bank) for bank in range(1, 6)]
    review = read(APP / 'build/player-review.json')
    require(review.get('font_family') == 'barlow',
            'Rebuild the player with RNBO_PLAYER_FONT=barlow before making a release.')
    sys.path.insert(0, str(BASE / 'tools'))
    from fm1_install import load_package
    product, _, _ = load_package(APP / 'build/rnbo-player.fwsc', False)
    require(product == 'FM-1_9400', 'Unexpected player firmware identity')
    cases = read(APP / 'hardware-tests/manifest.json')['patches']
    require(len(cases) == 15 and len({c['id'] for c in cases}) == 15,
            'Expected the complete 15-patch collection')
    for case in cases:
        folder = APP / 'build/hardware-tests' / case['id']
        provenance = read(folder / 'export/provenance.json')
        require(provenance.get('rnbo_version') == '1.4.4', 'Expected RNBO 1.4.4 exports')
        require(provenance.get('input_sha256') == digest(APP / 'hardware-tests' / case['source']),
                case['id'] + ': generated source is stale')
        config = read(folder / 'module.json')
        require(all(provenance.get(k) == config.get(k, False) for k in
                    ('voices', 'fast_phase', 'shared_fx')), case['id'] + ': export settings mismatch')
        if 'filter_delay_max_ms' in provenance:
            require(provenance['filter_delay_max_ms'] == config.get('filter_delay_max_ms'),
                    case['id'] + ': export filter delay maximum mismatch')
        require((folder / 'export/common').is_dir() and
                (folder / 'export/rnbo_source.h').is_file(),
                case['id'] + ': corresponding generated sources are missing')
        require(provenance.get('adapted_sha256') == digest(folder / 'export/rnbo_source.h'),
                case['id'] + ': generated C++ changed after export')
        hashes = provenance.get('common_sha256')
        require(isinstance(hashes, dict) and hashes and
                all(Path(name).name == name and (folder / 'export/common' / name).is_file() and
                    digest(folder / 'export/common' / name) == sha for name, sha in hashes.items()),
                case['id'] + ': generated runtime sources changed after export')
        native = read(folder / 'build/review.json')
        require(native.get('constructors') and
                (not config.get('fast_phase') or
                 (native.get('fast_phase') and native.get('float_to_int64_helpers_rejected'))),
                case['id'] + ': native constructor/portability review is missing')
    return groups


def assemble(destination, version, groups, paths, source_digest, local_inputs=None):
    """Assemble only after validation; rename the complete directory atomically."""
    require(not destination.exists(), 'Output already exists; choose a fresh --output directory.')
    destination.parent.mkdir(parents=True, exist_ok=True)
    stage = Path(tempfile.mkdtemp(prefix='.studio-', dir=destination.parent))
    try:
        web = stage / 'web'
        for folder in ('firmware', 'patches'):
            (web / folder).mkdir(parents=True, exist_ok=True)
        for name in ('module-loader.html', 'module-loader.js', 'studio.js'):
            shutil.copy2(APP / 'web' / name, web / name)
        shutil.copy2(web / 'module-loader.html', web / 'index.html')
        for name in ('fm1ota.js', 'fm1pkg.js'):
            shutil.copy2(BASE / 'web' / name, web / name)
        shutil.copy2(APP / 'build/rnbo-player.fwsc', web / 'firmware/rnbo-player.fwsc')
        manifest = {'format': 1, 'version': version, 'identity': 'FM-1_9400',
                    'created_utc': datetime.now(timezone.utc).isoformat(),
                    'source_commit': source_commit(),
                    'source_tree_sha256': source_digest, 'font_family': 'barlow',
                    'hardware_upload_verified': False, 'patches': []}
        def asset(path):
            return {'file': str(path.relative_to(web)), 'bytes': path.stat().st_size,
                    'sha256': digest(path)}
        manifest['firmware'] = asset(web / 'firmware/rnbo-player.fwsc')
        for case in catalogue()['patches']:
            name = case['id'] + '.rnbom'
            shutil.copy2(groups[case['bank'] - 1] / name, web / 'patches' / name)
            review = read(groups[case['bank'] - 1] / (case['id'] + '-review.json'))
            manifest['patches'].append(case | asset(web / 'patches' / name) |
                                       {k: review[k] for k in ('image_bytes', 'state_bytes', 'abi')})
        with zipfile.ZipFile(web / 'sources.zip', 'w', zipfile.ZIP_DEFLATED) as source:
            for path in paths:
                source.write(REPO / path, str(path))
            for case in catalogue()['patches']:
                folder = APP / 'build/hardware-tests' / case['id']
                for path in sorted((folder / 'export').rglob('*')):
                    if path.is_file():
                        source.write(path, str(path.relative_to(REPO)))
                for rel in ('module.json', 'build/review.json', 'build/device-build-status.json', 'result.json'):
                    source.write(folder / rel, str((folder / rel).relative_to(REPO)))
            source.write(APP / 'build/player-review.json', 'fm1-base/rnbo-loader/build/player-review.json')
        manifest['sources'] = asset(web / 'sources.zip')
        (web / 'release.json').write_text(json.dumps(manifest, indent=2) + '\n')
        (web / 'catalogue.json').write_text(json.dumps(catalogue(), indent=2) + '\n')
        shutil.copytree(REPO / 'LICENSES', web / 'LICENSES')
        for name in ('LICENSE', 'LICENSING.md', 'UPSTREAM.md'):
            shutil.copy2(REPO / name, web / name)
        shutil.copy2(BASE / 'assets/fonts/Barlow-OFL.txt', web / 'Barlow-OFL.txt')
        (stage / 'tools').mkdir()
        for name in ('serve.py', 'launch.py'):
            shutil.copy2(APP / 'tools' / name, stage / 'tools' / name)
        launcher = stage / 'Open-Studio.command'
        launcher.write_text('#!/bin/bash\nset -euo pipefail\n'
                            'studio_dir="$(cd "$(dirname "$0")" && pwd -P)"\n'
                            'exec python3 "$studio_dir/tools/launch.py" --static --release "$studio_dir/web"\n')
        launcher.chmod(0o755)
        (stage / 'START-HERE.txt').write_text(
            'FM1 RNBO Studio ' + version + '\n\n'
            'Open Open-Studio.command (Python 3 required), or host the web folder over HTTPS.\n'
            'Use Chrome or Edge and allow MIDI/SysEx. Install Player once, then choose one of\n'
            'the 15 patches and a slot. The FM1 stores three patches and plays one at a time.\n'
            'PRESETS changes patches. SAVE remembers per-slot controls and startup selection.\n\n'
            'This portable bundle installs firmware and uploads precompiled patches without\n'
            'RNBO, Node or Docker. To convert a new .rnbopat, use Open-Studio.command from\n'
            'the source checkout after Setup.command, with RNBO 1.4.4 and Docker available.\n\n'
            'Local release candidate: browser hardware transfer still needs device testing.\n'
            'sources.zip includes this working source snapshot and generated RNBO exports.\n'
            'Third-party SDK/compiler dependencies are retrieved by the pinned setup scripts.\n'
            'See LICENSING.md and the component notices before distributing binaries.\n')
        if local_inputs is not None:
            from offline import package
            package(stage, REPO, paths, inputs=local_inputs)
        stage.rename(destination)
    except BaseException:
        shutil.rmtree(stage)
        raise


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--version', default='0.1.0')
    parser.add_argument('--reuse', action='store_true', help='Package already reviewed native builds')
    parser.add_argument('--local', action='store_true', help='Include the local converter and cached compiler for offline use on macOS')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    require(re.fullmatch(r'\d+\.\d+\.\d+(?:-[A-Za-z0-9.-]+)?', args.version), 'Use a version such as 0.1.0')
    destination = (args.output or APP / ('build/studio-local' if args.local else 'build/studio-release')).resolve()
    require(not destination.exists(), 'Output already exists; choose a fresh --output directory.')
    require(not Path(str(destination)+'.zip').exists(), 'Output ZIP already exists; choose a fresh --output directory.')
    local_inputs = None
    if args.local:
        from offline import cached_inputs
        local_inputs = cached_inputs(REPO)
    paths = source_files()
    before = fingerprint(paths)
    if not args.reuse:
        env = dict(os.environ, RNBO_PLAYER_FONT='barlow', X0X_FONTSET='barlow')
        if local_inputs is not None:
            env.update(FM1_OFFLINE='1', JIELI_DOCKER='1', JIELI_DOCKER_IMAGE=local_inputs[3]['Id'])
        subprocess.run([sys.executable, str(APP / 'tools/build.py'), '--player-only'], env=env, check=True)
        subprocess.run([sys.executable, str(APP / 'hardware-tests/run.py'), '--native', '--jobs', '1'], env=env, check=True)
    groups = collect()
    require(before == fingerprint(paths), 'Source changed during the build; rebuild before packaging.')
    assemble(destination, args.version, groups, paths, before, local_inputs=local_inputs)
    print('Creating the release ZIP…', flush=True)
    archive = Path(shutil.make_archive(str(destination), 'zip', destination.parent, destination.name))
    pointer = APP / 'build/studio-latest.json'
    pointer.parent.mkdir(parents=True, exist_ok=True)
    pointer.write_text(json.dumps({'web_root': str(destination / 'web')}) + '\n')
    print('READY: ' + str(destination), flush=True)
    print('Portable browser bundle: ' + str(archive), flush=True)
    if args.local:
        print('Local converter included. Read QUICKSTART.md; open Open-Studio.command from this folder.', flush=True)
    print('No firmware or patches were uploaded. Run Open-Studio.command to test the release.', flush=True)


if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        print('Studio release stopped: ' + str(error), file=sys.stderr)
        raise SystemExit(1)
