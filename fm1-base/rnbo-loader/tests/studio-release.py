"""Exercise release validation/packaging with synthetic native artifacts, never hardware."""
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import shutil
import struct
import subprocess
import sys
import tempfile
import tarfile
import threading
from unittest.mock import patch
from urllib.error import HTTPError
from urllib.request import Request, urlopen
import zipfile

APP = Path(__file__).resolve().parents[1]
sys.path[:0] = [str(APP / 'tools'), str(APP / 'hardware-tests'), str(APP.parent / 'tools')]
import release
import prepare
from package import create, parse, TEXT
from serve import make_server


def write(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value))


def fail(action, match):
    try:
        action()
    except ValueError as error:
        assert match in str(error), error
    else:
        raise AssertionError('Expected validation failure: ' + match)


with tempfile.TemporaryDirectory(prefix='fm1-studio-test-') as temporary:
    repo = Path(temporary) / 'source'
    app = repo / 'fm1-base/rnbo-loader'
    base = app.parent
    shutil.copytree(APP / 'hardware-tests', app / 'hardware-tests', ignore=shutil.ignore_patterns('__pycache__'))
    shutil.copytree(APP / 'web', app / 'web')
    for relative in ('web/fm1ota.js', 'web/fm1pkg.js', 'assets/fonts/Barlow-OFL.txt'):
        target = base / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(APP.parent / relative, target)
    (app / 'tools').mkdir()
    for name in ('serve.py', 'launch.py'):
        shutil.copy2(APP / 'tools' / name, app / 'tools' / name)
    for name in ('LICENSE', 'LICENSING.md', 'UPSTREAM.md', 'QUICKSTART.md'):
        shutil.copy2(APP.parent.parent / name, repo / name)
    for relative in ('setup/dependencies.json', 'fm1-base/rnbo-loader/tools/build_service.py',
                     'fm1-base/rnbo/tools/export.cjs', 'fm1-base/tools/build.py'):
        target=repo/relative;target.parent.mkdir(parents=True,exist_ok=True)
        shutil.copy2(APP.parent.parent/relative,target)
    shutil.copytree(APP.parent.parent / 'LICENSES', repo / 'LICENSES')
    inventory = app / 'tools/source-inventory.json'
    write(inventory, {'format': 1, 'files': sorted(
        [str(p.relative_to(repo)) for p in repo.rglob('*') if p.is_file()] +
        ['fm1-base/rnbo-loader/tools/source-inventory.json'])})
    if shutil.which('git'):
        subprocess.run(['git', 'init', '-q', str(repo)], check=True)
        subprocess.run(['git', 'add', '.'], cwd=repo, check=True)
        subprocess.run(['git', '-c', 'user.name=Fixture', '-c', 'user.email=fixture@example.invalid', 'commit', '-qm', 'Synthetic source fixture'], cwd=repo, check=True)
    cases = json.loads((app / 'hardware-tests/manifest.json').read_text())['patches']
    player = app / 'build/rnbo-player.fwsc'
    player.parent.mkdir()
    raw = bytearray(1200)
    identity = b'FM-1_9400'
    for i in range(20):
        raw[i * 48 + 47] = (identity[i] + i + 1) & 255 if i < len(identity) else 0x7d
    raw[1000:1016] = b'FELUCCA-LOADER-1'
    player.write_bytes(raw)
    review = {'font_family': 'barlow', 'sha256': release.digest(player), 'identity': 'FM-1_9400',
              'patch_slots': 3, 'module_pc_guard_extension': True, 'raw_midi_abi2': True,
              'presets_patch_selection': True, 'visual_overview': True}
    write(app / 'build/player-review.json', review)
    write(app / 'build/device-build-status.json', {'success': True, 'host': False, 'stages': {'player': {'passed': True}}})
    for case in cases:
        ident = case['id']
        folder = app / 'build/hardware-tests' / ident
        source = app / 'hardware-tests' / case['source']
        config = json.loads((source.parent / 'module.json').read_text())
        write(folder / 'module.json', config)
        write(folder / 'result.json', {'native_build': True, 'build': 'pass', 'audition': 'pass', 'source_sha256': release.digest(source)})
        image = bytearray(1024)
        struct.pack_into('<4I', image, 0, 0x31495041, 2, 84, 123)
        title = ident.upper().encode()
        image[16:16+len(title)] = title
        struct.pack_into('<9I', image, 48, *([TEXT+84]*9))
        data = create(image, 140000, 123)
        (folder / 'build').mkdir()
        (folder / 'build' / (ident+'.rnbom')).write_bytes(data)
        write(folder / 'build/review.json', {**parse(data), 'sha256': hashlib.sha256(data).hexdigest(),
              'undefined_symbols': [], 'constructors': [hex(TEXT+84)], 'fast_phase': True, 'float_to_int64_helpers_rejected': True})
        write(folder / 'build/device-build-status.json', {'success': True, 'host': False, 'stages': {ident: {'passed': True}}})
        write(folder / 'export/provenance.json', {'rnbo_version': '1.4.4', 'input_sha256': release.digest(source),
              **{key: config.get(key, False) for key in ('voices', 'fast_phase', 'shared_fx')}})
        (folder / 'export/common').mkdir()
        (folder / 'export/common/LICENSE').write_text('Synthetic runtime fixture, not distributable firmware')
        (folder / 'export/rnbo_source.h').write_text('// Synthetic generated source fixture\n')
        provenance = json.loads((folder / 'export/provenance.json').read_text())
        provenance.update(adapted_sha256=release.digest(folder / 'export/rnbo_source.h'),
                          common_sha256={'LICENSE': release.digest(folder / 'export/common/LICENSE')})
        write(folder / 'export/provenance.json', provenance)
    with patch.multiple(release, APP=app, BASE=base, REPO=repo), patch.multiple(prepare, APP=app, ROOT=app/'hardware-tests', OUT=app/'build/hardware-tests'):
        groups = release.collect()
        paths = release.source_files()
        before = release.fingerprint(paths)
        # An unrelated untracked file must never enter the corresponding-source archive.
        (repo / 'private.txt').write_text('Not part of the project')
        output = Path(temporary) / 'release'
        release.assemble(output, '0.1.0', groups, paths, before)
        manifest = json.loads((output / 'web/release.json').read_text())
        assert len(manifest['patches']) == 15 and manifest['font_family'] == 'barlow'
        for asset in [manifest['firmware'], manifest['sources'], *manifest['patches']]:
            target = output / 'web' / asset['file']
            assert target.stat().st_size == asset['bytes'] and release.digest(target) == asset['sha256']
        with zipfile.ZipFile(output / 'web/sources.zip') as archive:
            assert 'private.txt' not in archive.namelist()
            assert len([p for p in archive.namelist() if p.endswith('/export/rnbo_source.h')]) == 15
        fail(lambda: release.assemble(output, '0.1.0', groups, paths, before), 'already exists')
        # Assemble the complete local variant with synthetic cached compiler
        # bytes; the real package code includes all 15 checked instruments.
        import offline
        compiler=json.loads((repo/'setup/dependencies.json').read_text())['toolchain']
        compiler_archive=repo/compiler['archive'];compiler_archive.parent.mkdir(parents=True)
        with tarfile.open(compiler_archive,'w:xz') as archive:
            for name in offline.TC_FILES:
                member=tarfile.TarInfo(compiler['distribution']+'/'+name);member.size=7
                archive.addfile(member,io.BytesIO(b'fixture'))
        compiler['sha256']=offline.digest(compiler_archive)
        pins=json.loads((repo/'setup/dependencies.json').read_text());pins['toolchain']=compiler
        write(repo/'setup/dependencies.json',pins)
        image={'Id':'sha256:'+'a'*64,'Os':'linux','Architecture':'amd64'}
        local_output=Path(temporary)/'local-release'
        def save_image(command,timeout=30):
            assert command[:3]==['docker','image','save']
            Path(command[command.index('--output')+1]).write_bytes(b'synthetic compiler image')
            return ''
        with patch.object(offline,'run',side_effect=save_image):
            release.assemble(local_output,'0.1.0',groups,paths,release.fingerprint(paths),
                             local_inputs=(pins,compiler,compiler_archive,image))
        assert len(json.loads((local_output/'web/release.json').read_text())['patches'])==15
        assert offline.load_manifest(local_output)['image']['id']==image['Id']
        assert 'offline.py' in (local_output/'Open-Studio.command').read_text()
        assert (local_output/'Check-Setup.command').stat().st_mode&0o111
        assert not (local_output/'converter/dependencies').exists()
        assert (local_output/'converter/fm1-base/rnbo-loader/tools/build_service.py').is_file()
        # Run the complete release entry point from a plain source folder with
        # no Git checkout AND no Git executable. Artifact builds are synthetic.
        git_metadata = Path(temporary) / 'git-metadata'
        if (repo / '.git').exists():
            (repo / '.git').rename(git_metadata)
        plain_output = Path(temporary) / 'plain-release'
        try:
            with patch.dict('os.environ', {'PATH': str(Path(temporary)/'no-executables')}), \
                 patch.object(sys, 'argv', ['release.py', '--reuse', '--output', str(plain_output)]), \
                 patch.object(release.subprocess, 'run', side_effect=AssertionError('External command used for plain-folder packaging')):
                release.main()
            plain_manifest = json.loads((plain_output/'web/release.json').read_text())
            assert plain_manifest['source_commit'] is None
            assert len(plain_manifest['patches']) == 15
            with zipfile.ZipFile(plain_output/'web/sources.zip') as archive:
                assert 'private.txt' not in archive.namelist()
                assert 'fm1-base/rnbo-loader/web/studio.js' in archive.namelist()
                assert len([p for p in archive.namelist() if p.endswith('/export/rnbo_source.h')]) == 15
            assert plain_output.with_suffix('.zip').is_file()
            # macOS /var and /private/var can name the same temporary directory.
            recorded = Path(json.loads((app/'build/studio-latest.json').read_text())['web_root'])
            assert recorded.resolve() == (plain_output/'web').resolve()
            # Inventory traversal is rejected rather than reading outside sources.
            saved_inventory = inventory.read_bytes()
            write(inventory, {'format': 1, 'files': ['../private.txt']})
            fail(release.source_files, 'inside the project')
            inventory.write_bytes(saved_inventory)
        finally:
            if git_metadata.exists():
                git_metadata.rename(repo / '.git')
        review['font_family'] = 'arial'
        write(app / 'build/player-review.json', review)
        fail(release.collect, 'RNBO_PLAYER_FONT=barlow')
        review['font_family'] = 'barlow'
        write(app / 'build/player-review.json', review)
        source = app / 'hardware-tests' / cases[0]['source']
        source.write_text(source.read_text()+'\n')
        fail(release.collect, 'source changed')
    # The exact portable server can run with no RNBO or build-service module present.
    server = make_server(0, web_root=output/'web', builder=False)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    origin = f'http://127.0.0.1:{server.server_port}'
    def get(path, method=None, token=None, site=None):
        headers = {}
        if token:
            headers['X-FM1-Token'] = token
        if site:
            headers['Origin'] = site
        try:
            with urlopen(Request(origin+path, method=method, headers=headers), timeout=3) as response:
                return response.status, response.read()
        except HTTPError as error:
            return error.code, error.read()
    try:
        info = json.loads(get('/api/session')[1])
        assert info['studio_version'] == 1 and not info['builder']
        for path in ('/', '/studio.js', '/fm1ota.js', '/release.json', '/patches/t15_hybrid.rnbom'):
            assert get(path)[0] == 200
        assert get('/../../private.txt')[0] == 404
        assert get('/patches/')[0] == 404
        assert get('/api/build', method='POST', token=info['token'], site=origin)[0] == 404
        assert get('/api/quit', method='POST')[0] == 403
        assert get('/api/quit', method='POST', token=info['token'], site='https://other.invalid')[0] == 403
        assert get('/api/quit', method='POST', token=info['token'], site=origin)[0] == 200
        thread.join(3)
        assert not thread.is_alive()
    finally:
        if thread.is_alive():
            server.shutdown()
        server.server_close()
    # A background launcher returns, reuses only the matching service, and can stop.
    command = [sys.executable, str(output/'tools/launch.py'), '--static', '--release', str(output/'web'), '--no-open']
    url = subprocess.check_output(command, text=True, timeout=15).strip()
    try:
        assert subprocess.check_output(command, text=True, timeout=15).strip() == url
        for relative in ('release.json', 'fm1ota.js', 'firmware/rnbo-player.fwsc', 'patches/t01_keys.rnbom'):
            with urlopen(url.rsplit('/', 1)[0]+'/'+relative) as response:
                assert response.status == 200
        with urlopen(url.rsplit('/', 1)[0]+'/api/session') as response:
            info = json.load(response)
        req = Request(url.rsplit('/', 1)[0]+'/api/quit', method='POST',
                      headers={'Origin':url.rsplit('/',1)[0], 'X-FM1-Token':info['token']})
        with urlopen(req) as response:
            assert response.status == 200
    finally:
        pass
print('PASS Studio release: all 15 reviewed artifacts, source/config/font guards, checked source archives in Git and plain folders without Git installed, portable HTTP boundaries and background launcher reuse/shutdown')
