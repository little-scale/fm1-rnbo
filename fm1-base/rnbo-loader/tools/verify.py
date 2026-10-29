#!/usr/bin/env python3
"""Host/proxy checks for the permanent player, modules, storage and wire code."""
import json
import os
from pathlib import Path
import subprocess
import sys
APP=Path(__file__).resolve().parents[1];BASE=APP.parent;OUT=APP/'build';LOGS=OUT/'verification';LOGS.mkdir(parents=True,exist_ok=True)
for d in ['panel','empty','banks','meter','poly-player','fast-player','echo-player','patch-bank','visual-panel']:(OUT/d).mkdir(exist_ok=True)
env=dict(os.environ,PYTHON='python3',RNBO_HOST_MODULES=str(APP/'modules'),RNBO_HOST_PATCH='mono')
cc=os.environ.get('CC','clang');cpp=os.environ.get('CXX','clang++')
steps=[('host-and-module-build',[sys.executable,APP/'tools/build.py','--host']),
       ('visual-module-build',[sys.executable,APP/'tools/build.py','--host','--patch','saw_cutoff_delay']),
       ('visual-layout',[sys.executable,APP/'tests/layout.py']),
       ('player-install',[sys.executable,APP/'tests/install.py']),
       ('visual-format-build',[cc,'-std=c11','-O1','-fsanitize=undefined','-fno-sanitize-recover=all','-I'+str(BASE/'include'),'-I'+str(APP),APP/'format.c',APP/'tests/visual-format.c','-o',OUT/'visual-format-test']),
       ('visual-format',[OUT/'visual-format-test']),
       ('battery-build',[cc,'-std=c11','-O1','-fsanitize=undefined','-fno-sanitize-recover=all',APP/'tests/battery.c','-o',OUT/'battery-test']),
       ('battery',[OUT/'battery-test']),
       ('visual-panel',[OUT/'host/rnbo-player_host',APP/'tests/visual.txt',OUT/'visual-panel']),
       ('poly2-module-build',[sys.executable,APP/'tools/build.py','--host','--patch','fm8poly2']),
       ('fast-module-build',[sys.executable,APP/'tools/build.py','--host','--patch','fm8poly2fast']),
       ('echo-module-build',[sys.executable,APP/'tools/build.py','--host','--patch','fm4echo']),
       ('float32-delay-adaptation',['node',APP/'tests/float32-delays.cjs']),
       ('phase-conversion-build',[cc,'-std=c11','-O2','-fsanitize=undefined','-fno-sanitize-recover=all',APP/'tests/phase.c','-o',OUT/'phase-test']),
       ('phase-conversion',[OUT/'phase-test']),
       ('player-device-syntax',[cc,'-target','armv7-none-eabi','-mcpu=cortex-m4','-mfloat-abi=softfp','-mfpu=fpv4-sp-d16','-std=gnu11','-fsyntax-only','-Wno-implicit-function-declaration',*['-I'+str(p) for p in [APP,OUT/'gen',BASE/'device',BASE/'include',BASE/'lib',BASE/'bsp/chip',BASE/'bsp/boards/fm1']],BASE/'device/unity.c']),
       ('module-guard-build',[cc,'-x','c','-std=c11','-O1','-fsanitize=undefined','-fno-sanitize-recover=all','-I'+str(APP/'tests'),'-I'+str(BASE/'bsp/chip'),APP/'tests/guard-test.inc','-o',OUT/'guard-test']),
       ('module-guard',[OUT/'guard-test']),
       ('storage-ubsan-build',[cc,'-std=c11','-O1','-g','-fsanitize=undefined','-fno-sanitize-recover=all','-DRM_TEST','-DPLAT_HOST','-I'+str(BASE/'include'),'-I'+str(APP),APP/'engine.c',APP/'format.c',APP/'tests/storage.c','-o',OUT/'storage-test']),
       ('storage-ubsan',[OUT/'storage-test']),('protocol',[sys.executable,APP/'tests/protocol.py']),
       ('browser-helpers',['node',APP/'tests/web.cjs']),('audio-modules',[sys.executable,APP/'tests/audio.py']),
       ('browser-build-flow',['node',APP/'tests/browser-flow.cjs']),
       ('browser-build-service',[sys.executable,APP/'tests/build-service.py']),
       ('player-panel',[OUT/'host/rnbo-player_host',APP/'tests/panel.txt',OUT/'panel']),
       ('empty-player',[OUT/'host/rnbo-player_host',APP/'tests/empty.txt',OUT/'empty']),
       ('knob-banks',[OUT/'host/rnbo-player_host',APP/'tests/banks.txt',OUT/'banks']),
       ('output-meter',[OUT/'host/rnbo-player_host',APP/'tests/meter.txt',OUT/'meter']),
       ('poly-player',[OUT/'host/rnbo-player_host',APP/'tests/poly-player.txt',OUT/'poly-player']),
       ('polyphony-audio',[sys.executable,APP/'tests/polyphony.py']),
       ('fast-player',[OUT/'host/rnbo-player_host',APP/'tests/fast-player.txt',OUT/'fast-player']),
       ('fast-polyphony',[sys.executable,APP/'tests/polyphony.py']),
       ('fast-audio-comparison',[sys.executable,APP/'tests/fast-audio.py']),
       ('voice-sleep',[sys.executable,APP/'tests/voice-sleep.py']),
       ('echo-player',[OUT/'host/rnbo-player_host',APP/'tests/echo-player.txt',OUT/'echo-player']),
       ('echo-four-audio',[sys.executable,APP/'tests/echo-four.py'])]
steps.append(('patch-bank',[OUT/'host/rnbo-player_host',APP/'tests/patch-bank.txt',OUT/'patch-bank']))
report={'stages':{},'pi32v2_build_verified':False,'target_RAM_execution_verified':False,'hardware_upload_verified':False,'web_midi_UI_verified':False}
for name,command in steps:
    useenv=dict(env)
    if name=='visual-panel':useenv.update(RNBO_HOST_PATCH='saw_cutoff_delay',FMS_BATTERY_RAW='628',FMS_BATTERY_USB='1')
    if name=='fast-polyphony':useenv['RNBO_POLY_TEST_MODULE']='fm8poly2fast'
    if name=='empty-player':useenv.pop('RNBO_HOST_PATCH',None)
    result=subprocess.run(list(map(str,command)),env=useenv,text=True,capture_output=True,timeout=90)
    (LOGS/(name+'.log')).write_text(result.stdout+result.stderr)
    report['stages'][name]={'passed':result.returncode==0,'log':name+'.log'}
    print(name+': '+('PASS' if result.returncode==0 else 'FAIL'),flush=True)
    if result.returncode:
        print(result.stdout+result.stderr);(LOGS/'summary.json').write_text(json.dumps(report,indent=2)+'\n');raise SystemExit(result.returncode)
for name in ['mono','fm','fm8','fm8poly2','fm8poly2fast','fm4echo']:
    export=APP/'modules'/name/'export'
    defs=[f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{export}/rnbo_source.h"',f'-DRNBO_FM1_POOL_BYTES={114688 if name=="fm4echo" else 98304}']
    command=[cpp,'-target','armv7-none-eabi','-mcpu=cortex-m4','-mfloat-abi=softfp','-mfpu=fpv4-sp-d16','-std=c++11','-O2','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-ffreestanding','-fno-builtin','-ffp-contract=off',*defs,'-I'+str(export/'common'),'-c',str(APP/'modules/entry.cpp'),'-o',str(OUT/(name+'-abi32.o'))]
    result=subprocess.run(command,text=True,capture_output=True,timeout=60)
    (LOGS/(name+'-abi32.log')).write_text(result.stdout+result.stderr);report['stages'][name+'-abi32']={'passed':result.returncode==0}
    if result.returncode:print(result.stderr);raise SystemExit(result.returncode)
    print(name+'-abi32: PASS',flush=True)
(LOGS/'summary.json').write_text(json.dumps(report,indent=2)+'\n')
print('Host and proxy checks complete. Device builds, RAM execution and actual uploads still need hardware verification.')
