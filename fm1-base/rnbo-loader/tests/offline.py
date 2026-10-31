"""Local kit packaging, first launch and relocation; compiler/Docker fixtures only."""
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tarfile
import tempfile
from unittest.mock import patch
from urllib.request import Request, urlopen

APP = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(APP / 'tools'))
spec = importlib.util.spec_from_file_location('studio_offline', APP / 'tools/offline.py')
offline = importlib.util.module_from_spec(spec)
spec.loader.exec_module(offline)
import release


def write(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value))


def fail(action, text):
    try:
        action()
    except (ValueError, tarfile.TarError) as error:
        assert text in str(error), error
    else:
        raise AssertionError('Expected failure: ' + text)


with tempfile.TemporaryDirectory(prefix='fm1-offline-test-') as temporary:
    folder = Path(temporary)
    source = folder / 'source'
    paths = release.source_files()
    for relative in paths:
        target = source / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(release.REPO / relative, target)
    # Standalone fixture files keep the archive genuinely relocatable and small.
    distribution = 'jieli-linux-toolchains-20260730.1'
    archive = source / 'dependencies/jieli-linux-toolchain.tar.xz'
    archive.parent.mkdir()
    with tarfile.open(archive, 'w:xz') as tar:
        for relative in offline.TC_FILES:
            data = b'compiler fixture, not executable firmware\n'
            info = tarfile.TarInfo(distribution + '/' + relative)
            info.size = len(data);info.mode = 0o755
            tar.addfile(info, io.BytesIO(data))
    dependencies = json.loads((source / 'setup/dependencies.json').read_text())
    dependencies['toolchain']['sha256'] = offline.digest(archive)
    write(source / 'setup/dependencies.json', dependencies)
    image_id = 'sha256:' + 'a' * 64
    info = {'Id': image_id, 'Os': 'linux', 'Architecture': 'amd64'}
    calls = [];loaded = [False];wrong_arch = [False]
    def command(args, timeout=30):
        args = list(map(str, args));calls.append(args)
        assert not any(v in ('pull', 'fetch', 'pip', 'curl') for v in args)
        if args[:3] == ['docker', 'image', 'inspect']:
            if args[-1] == image_id and not loaded[0]:
                raise ValueError('No such local image')
            return json.dumps([{**info, 'Architecture': 'arm64' if wrong_arch[0] else 'amd64'}])
        if args[:3] == ['docker', 'image', 'save']:
            Path(args[args.index('--output')+1]).write_bytes(b'synthetic saved image')
            return ''
        if args[:3] == ['docker', 'image', 'load']:
            loaded[0] = True;return ''
        if args[:2] == ['docker', 'info']:
            return 'test-docker'
        if args[:2] == ['docker', 'run']:
            assert '--pull=never' in args and '--network=none' in args
            return 'clang 4.0.1 fixture'
        if args == ['node', '--version']:
            return 'v22.0.0'
        if args[0] in ('clang', 'clang++'):
            return 'Apple clang fixture'
        raise AssertionError(args)
    kit = folder / 'FM1 Studio'
    (kit / 'tools').mkdir(parents=True)
    (source / 'private.txt').write_text('must not ship')
    (source / '.venv').mkdir()
    with patch.object(offline, 'run', side_effect=command):
        wrong_arch[0] = True
        fail(lambda: offline.cached_inputs(source), 'Start Docker Desktop')
        wrong_arch[0] = False
        inputs = offline.cached_inputs(source)
        offline.package(kit, source, paths, inputs)
        manifest = offline.load_manifest(kit)
        assert not (kit / 'converter/private.txt').exists()
        assert not (kit / 'converter/.venv').exists()
        assert not (kit / 'converter/dependencies').exists()
        assert not (kit / 'converter/.git').exists()
        assert not (kit / 'converter/setup').is_symlink()
        assert (kit / 'QUICKSTART.md').is_file()
        # The installed RNBO stays on the receiving Mac, outside the release.
        rnbo = folder / 'installed RNBO'
        for relative in ('server/node_modules/@rnbo/xam', 'server/node_modules/@rnbo/xam-runner', 'source/rnbo/common'):
            (rnbo / relative).mkdir(parents=True)
        write(rnbo / 'package-info.json', {'version': '1.4.4'})
        with patch.dict(os.environ, {'RNBO_DIR': str(rnbo)}):
            assert offline.find_rnbo() == rnbo.resolve()
            write(rnbo / 'package-info.json', {'version': '1.4.3'})
            # Do not depend on which other RNBO packages the test Mac has installed.
            fail(lambda: offline.find_rnbo([rnbo]), 'RNBO 1.4.4')
            write(rnbo / 'package-info.json', {'version': '1.4.4'})
            with patch.object(offline.sys, 'platform', 'darwin'), patch.object(offline, 'find_browser', return_value='Google Chrome'):
                count = len(calls)
                ready, _ = offline.check(kit, manifest, prepare=False)
                assert ready and not loaded[0]
                assert not (kit / 'cache' / distribution).exists()
                assert not any('load' in c or 'run' in c for c in calls[count:])
                ready, env = offline.check(kit, manifest, prepare=True)
                assert ready and loaded[0]
                assert env['RNBO_DIR'] == str(rnbo.resolve())
                assert env['JIELI_DOCKER_IMAGE'] == image_id and env['FM1_OFFLINE'] == '1'
                assert env['JIELI_TOOLCHAIN'] == str(kit / 'cache' / distribution)
                # Move the complete folder; no absolute dependency paths are persisted.
                moved = folder / 'moved studio';kit.rename(moved);kit = moved
                ready, env = offline.check(kit, offline.load_manifest(kit), prepare=True)
                assert ready and env['JIELI_TOOLCHAIN'] == str(kit / 'cache' / distribution)
            def missing_node(args, timeout=30):
                if args[0] == 'node':raise FileNotFoundError('Install Node.js')
                return command(args, timeout)
            with patch.object(offline.sys, 'platform', 'darwin'), patch.object(offline, 'find_browser', return_value='Chrome'), patch.object(offline, 'run', side_effect=missing_node):
                count=len(calls)
                ready, _=offline.check(kit, manifest, prepare=True)
                assert not ready
                assert not any(c[:2]==['docker','run'] for c in calls[count:])
        # Corrupt caches and metadata fail before extraction or Docker import.
        saved=(kit / 'offline.json').read_bytes()
        malicious=json.loads(saved);malicious['toolchain']['directory']='../outside'
        write(kit / 'offline.json',malicious);fail(lambda:offline.load_manifest(kit),'Invalid compiler identity')
        (kit / 'offline.json').write_bytes(saved)
        compiler=kit / 'cache' / distribution;shutil.rmtree(compiler)
        compiler_archive=kit / manifest['toolchain']['file'];saved_archive=compiler_archive.read_bytes()
        compiler_archive.write_bytes(b'corrupt');fail(lambda:offline.extract_compiler(kit,manifest),'checksum failed')
        assert not compiler.exists();compiler_archive.write_bytes(saved_archive)
        loaded[0]=False
        image=kit / manifest['image']['file'];saved_image=image.read_bytes();image.write_bytes(b'corrupt')
        fail(lambda:offline.ensure_image(kit,manifest,prepare=True),'checksum failed')
        assert not loaded[0];image.write_bytes(saved_image)
    # The relocated converter starts a genuine build-capable HTTP service with
    # system Python alone. No original checkout, venv, SDK or RNBO import needed.
    tools=kit/'converter/fm1-base/rnbo-loader/tools'
    code='import runpy,sys;sys.path.insert(0,sys.argv[1]);driver=runpy.run_path(sys.argv[1]+"/build.py",run_name="offline_import");driver["upstream"]()'
    subprocess.run([sys.executable,'-S','-c',code,str(tools)],check=True,cwd=kit/'converter')
    web=kit/'web';web.mkdir()
    for name in ('module-loader.html','module-loader.js','studio.js'):
        shutil.copy2(APP/'web'/name,web/name)
    command=[sys.executable,str(kit/'converter/fm1-base/rnbo-loader/tools/launch.py'),
             '--release',str(web),'--no-open']
    url=subprocess.check_output(command,text=True,timeout=15).strip()
    origin=url.rsplit('/',1)[0]
    try:
        assert subprocess.check_output(command,text=True,timeout=15).strip()==url
        with urlopen(origin+'/api/session',timeout=3) as response:
            session=json.load(response)
        assert session['builder'] is True
        with urlopen(url,timeout=3) as response:
            assert response.status==200
    finally:
        request=Request(origin+'/api/quit',method='POST',headers={'Origin':origin,'X-FM1-Token':session['token']})
        with urlopen(request,timeout=3) as response:assert response.status==200
    # The actual target builder uses a different container identity for offline
    # mode and refuses pulls/network; a normal developer container is not reused.
    spec=importlib.util.spec_from_file_location('upstream_offline_fixture',APP.parent/'tools/build.py')
    upstream=importlib.util.module_from_spec(spec);spec.loader.exec_module(upstream)
    upstream.ROOT=folder/'build workspace';upstream.DOCKER_IMAGE=image_id
    containers=[]
    def docker(args,**kwargs):
        containers.append(args)
        if args[:2]==['docker','inspect']:return subprocess.CompletedProcess(args,0,stdout='false',stderr='')
        return subprocess.CompletedProcess(args,0,stdout='fixture',stderr='')
    with patch.dict(os.environ,{'FM1_OFFLINE':'1'}), patch.object(upstream,'toolchain',return_value=folder/'tc'),patch.object(upstream.subprocess,'run',side_effect=docker):
        offline_container=upstream._builder_start()
    run_cmd=next(c for c in containers if c[:2]==['docker','run'])
    assert '--pull=never' in run_cmd and '--network=none' in run_cmd
    assert offline_container!='jieli-'+hashlib.sha1(str(upstream.ROOT).encode()).hexdigest()[:10]
print('PASS local release: cached dependencies, offline import, no venv/SDK/Git, RNBO detection, readiness, relocation, live converter service, corrupt-cache refusal and network-disabled compiler containers')
