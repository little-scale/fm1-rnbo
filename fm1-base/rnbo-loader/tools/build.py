#!/usr/bin/env python3
"""Build the permanent player and/or standalone patches. Never installs."""
import argparse
import hashlib
import importlib.util
import json
import os
import re
import struct
import subprocess
import sys
import traceback
from pathlib import Path
from elf import read
from package import create,parse,TEXT,STATE,STATE_MAX,IMAGE_MAX
from layout import write_layout,append_layout
APP=Path(__file__).resolve().parents[1];BASE=APP.parent;WORKSPACE=BASE.parent
sys.path.insert(0,str(BASE/'tools'))
sys.path.insert(0,str(BASE/'rnbo/tools'))
from build import CPP_FLAGS  # sibling RNBO adapter, not this __main__ module

def upstream():
    os.environ.setdefault('AC79_SDK',str(WORKSPACE/'dependencies/ac79-sdk'))
    os.environ.setdefault('JIELI_TOOLCHAIN',str(WORKSPACE/'dependencies/jieli/jieli-linux-toolchains-20260730.1'))
    os.environ.setdefault('JIELI_DOCKER_IMAGE',(WORKSPACE/'setup/docker-image.txt').read_text().strip())
    spec=importlib.util.spec_from_file_location('upstream_player',BASE/'tools/build.py');u=importlib.util.module_from_spec(spec);spec.loader.exec_module(u)
    return u

def build_player(host=False):
    u=upstream();original=u.tc
    def tc(tool,*args):
        args=list(args)
        if tool=='pi32v2/bin/ld' and '--gc-sections' in args and '-T' in args and any(str(p).endswith('unity.o') for p in args):
            at=args.index('-T')+1;source=Path(args[at]).read_text()
            old='POOL   (rw)  : ORIGIN = 0x01C20000, LENGTH = 0x54000'
            if source.count(old)!=1:raise SystemExit('Review changed upstream pool map')
            source=source.replace(old,'POOL   (rw)  : ORIGIN = 0x01C20000, LENGTH = 0x14000\n    MODULE_IMAGE (rwx) : ORIGIN = 0x01C34000, LENGTH = 64K\n    MODULE_STATE (rw) : ORIGIN = 0x01C44000, LENGTH = 176K')
            marker='    /DISCARD/ :'
            source=source.replace(marker,'    .module_image (NOLOAD) : { _module_image = .; . += 64K; } > MODULE_IMAGE\n    .module_state (NOLOAD) : { _module_state = .; . += 176K; } > MODULE_STATE\n'+marker)
            target=APP/'build/player.ld';target.write_text(source);args[at]=target
        return original(tool,*args)
    u.tc=tc
    sys.argv=[str(BASE/'tools/build.py'),str(APP),'--no-ble']+(['--host'] if host else [])
    u.main()
    if not host:
        e=read(APP/'build/rnbo-player.elf');s=e['symbols']
        assert s['_module_image']==TEXT and s['_module_state']==STATE
        assert s['_pool_end']<=TEXT and s['_module_state']+STATE_MAX<=s['_guard0']
        assert 'loader_raw_midi' in s,'Raw MIDI policy hook was not linked'
        assert 'loader_receive_slot' in s and 'loader_cycle' in s,'Three-slot bank was not linked'
        assert 'loader_allow_code' in s,'Module execution-guard hook was not linked'
        import fm1_install as installer
        p=APP/'build/rnbo-player.fwsc';identity,image,digest=installer.load_package(p,False)
        assert identity=='FM-1_9400'
        (APP/'build/player-review.json').write_text(json.dumps({'font_family':os.environ.get('RNBO_PLAYER_FONT','arial'),'identity':identity,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'reserved_image_bytes':IMAGE_MAX,'reserved_state_bytes':STATE_MAX,'module_pc_guard_extension':True,'raw_midi_abi2':True,'patch_slots':3,'presets_patch_selection':True,'visual_overview':True,'battery_indicator':True,'parameter_overlay_ms':1500,'installed':False,'RAM_module_execution_verified':False},indent=2)+'\n')

def build_module(name,host=False,source=None,module_dir=None):
    module_dir=Path(module_dir).resolve() if module_dir else APP/'modules'/name
    if not module_dir.is_relative_to(BASE):raise ValueError('Module output must be inside fm1-base for the target compiler')
    export=module_dir/'export';out=module_dir/'build';out.mkdir(parents=True,exist_ok=True)
    settings=export.parent/'module.json'
    config=json.loads(settings.read_text()) if settings.exists() else {}
    voices=config.get('voices',1)
    phase_flags=['--fast-phase'] if config.get('fast_phase',False) else []
    if voices not in (1,2,4):raise SystemExit('Supported voice counts: 1, 2 or 4')
    pool_bytes=config.get('pool_bytes',98304)
    if not isinstance(pool_bytes,int) or pool_bytes<98304 or pool_bytes>131072 or pool_bytes%16:raise SystemExit('Patch arena must be 96..128 KiB and aligned to 16 bytes')
    topology_flags=['--shared-fx'] if config.get('shared_fx',False) else []
    delay_flags=['--float32-delays'] if config.get('float32_delays',False) else []
    cap=config.get('filter_delay_max_ms')
    if cap is not None:
        if type(cap) not in (int,float) or not 0<cap<=1000:raise SystemExit('filter_delay_max_ms must be > 0 and <= 1000')
        delay_flags=['--float32-delays','--filter-delay-max-ms',str(cap)]
    for key,low,high in [('gen_buffer_max_bytes',16,131072),('gen_delay_max_samples',1,44100)]:
        if key in config:
            value=config[key]
            if type(value) is not int or not low<=value<=high:raise ValueError(f'{key} must be an integer in {low}..{high}')
            delay_flags.extend(['--'+key.replace('_','-'),str(value)])
    print('FM1_STAGE exporting',flush=True)
    subprocess.run(['node',str(BASE/'rnbo/tools/export.cjs'),str(source or APP/'patches'/(name+'.rnbopat')),'--out',str(export),'--voices',str(voices),*phase_flags,*topology_flags,*delay_flags],check=True)
    visual=write_layout(source or APP/'patches'/(name+'.rnbopat'),json.loads((export/'description.json').read_text()),export)
    print('FM1_STAGE checking',flush=True)
    for profile in [[],['--abi32'],['--size32-long']]:
        subprocess.run([sys.executable,str(BASE/'rnbo/tools/audit.py'),'--export',str(export),'--pool-bytes',str(pool_bytes),*profile],check=True)
    relative=export.relative_to(BASE).as_posix()
    defs=[f'-DRNBO_FM1_PATCH_CONFIG="{relative}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{relative}/rnbo_source.h"',f'-DRNBO_FM1_POOL_BYTES={pool_bytes}',f'-DRNBO_MODULE_TITLE="{name.upper()}"']
    defs.append(f'-DRNBO_FM1_VISUAL_SOURCE="{relative}/visual.h"')
    print('FM1_STAGE compiling',flush=True)
    args=['clang++',*CPP_FLAGS,'-O2','-ffp-contract=off','-DPLAT_HOST',*defs,'-I'+str(BASE),'-I'+str(export/'common'),'-c',str(APP/'modules/entry.cpp'),'-o',str(out/'host.o')]
    subprocess.run(args,check=True)
    subprocess.run(['clang','-dynamiclib',str(out/'host.o'),'-lm','-o',str(out/(name+'.dylib'))],check=True)
    probe=subprocess.run([sys.executable,str(APP/'tools/probe.py'),str(out/(name+'.dylib'))],text=True,capture_output=True,timeout=30)
    (out/'probe.log').write_text(probe.stdout+probe.stderr)
    if probe.returncode:raise SystemExit('Patch host probe failed: '+probe.stdout+probe.stderr)
    print(probe.stdout)
    if host:return
    print('FM1_STAGE target',flush=True)
    u=upstream();u.ROOT=BASE;u.CONF={}
    obj=out/'module.o';support=out/'support.o';elf=out/(name+'.elf')
    flags=[*u.CFLAGS,*u.FPU,'-O2','-I.','-I'+str(export.relative_to(BASE)/'common')]
    u.tc('cc',*CPP_FLAGS,'-x','c++',*flags,*defs,'-c',APP/'modules/entry.cpp','-o',obj)
    u.tc('cc',*flags,'-c',APP/'modules/support.c','-o',support)
    libs=Path('/opt/jieli/pi32v2/lib/r3') if u.use_docker() else u.toolchain()/'pi32v2/lib/r3'
    u.tc('pi32v2/bin/ld','--gc-sections','--undefined=rnbo_fm1_param_actual','-e','rnbo_module','-T',APP/'modules/module.ld',obj,support,'--start-group',str(libs/'libm.a'),str(libs/'libcompiler-rt.a'),'--end-group','-o',elf)
    print('FM1_STAGE validating',flush=True)
    e=read(elf);s=e['symbols'];sections=e['sections']
    if e['undefined']:raise SystemExit('Module unresolved symbols: '+str(e['undefined']))
    assert e['machine']==241 and e['entry']==s['rnbo_module']==TEXT
    assert set(n for n,v in sections.items() if v['bytes'] and v['address'])=={'.image','.state'}
    image=sections['.image']['data'];state=s['_module_state_end']-STATE
    # Require the actual old-Clang constructor; keeping .init_array alone is insufficient.
    constructors=[]
    for kind in ['ctors','init_array']:
        start,end=s['_rnbo_'+kind+'_start'],s['_rnbo_'+kind+'_end']
        assert TEXT<=start<=end<=TEXT+len(image) and (end-start)%4==0
        constructors+=list(struct.unpack_from('<'+'I'*((end-start)//4),image,start-TEXT))
    assert any('GLOBAL__sub_I' in n and p in constructors for n,p in s.items())
    assert all(p in (0,0xffffffff) or TEXT<=p<TEXT+len(image) for p in constructors)
    dis=u.tc('common/bin/objdump','-d',elf);(out/(name+'.dis')).write_text(dis)
    if phase_flags and re.search(r'\bcall[^\n]*<__(?:fixsfdi|fixunssfdi)\b',dis):raise SystemExit('Optimized module still calls a float-to-int64 helper; inspect target DSP')
    if u.mul64_near_loads(dis):raise SystemExit('Module multiply/load hazard: '+str(u.mul64_near_loads(dis)))
    patch_id=struct.unpack_from('<I',image,12)[0]
    image=append_layout(image,(export/'visual.bin').read_bytes(),s['rnbo_fm1_param_actual'])
    data=create(image,state,patch_id)
    package=out/(name+'.rnbom');package.write_bytes(data)
    report={**parse(data),'sha256':hashlib.sha256(data).hexdigest(),'constructors':[hex(p) for p in constructors],'undefined_symbols':e['undefined'],'fast_phase':bool(phase_flags),'float_to_int64_helpers_rejected':bool(phase_flags),'visual_overview':visual['available'],'visual_bytes':visual.get('bytes',0),'target_timing_verified':False,'RAM_execution_verified':False}
    (out/'review.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
    print('FM1_LAYOUT '+json.dumps({k:v for k,v in visual.items() if k not in ('nodes','segments','parameters')}),flush=True)

if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--host',action='store_true');ap.add_argument('--player-only',action='store_true');ap.add_argument('--patch',help='bundled name or self-contained .rnbopat path');ap.add_argument('--module-dir',type=Path,help='isolated module output directory inside fm1-base');ap.add_argument('--poly2',action='store_true',help='build the player and two-voice FM8 module only');a=ap.parse_args()
    if a.module_dir and (not a.patch or a.player_only):ap.error('--module-dir requires --patch')
    if a.poly2 and (a.patch or a.player_only):ap.error('--poly2 cannot be combined with --patch or --player-only')
    jobs=[]
    if not a.patch:jobs.append(('player',lambda:build_player(a.host)))
    if not a.player_only:
        for value in ([a.patch] if a.patch else (['fm8poly2'] if a.poly2 else ['mono','fm','fm8'])):
            source=Path(value).resolve() if value.endswith('.rnbopat') else None
            name=source.stem if source else value
            if not re.fullmatch('[a-zA-Z][a-zA-Z0-9_-]{0,23}',name):raise SystemExit('Patch filename must use 1..24 letters/digits/_/- and start with a letter')
            jobs.append((name,lambda name=name,source=source:build_module(name,a.host,source,a.module_dir)))
    report={'success':False,'host':a.host,'stages':{},'installed':False,'target_RAM_execution_verified':False}
    status=(a.module_dir/'build' if a.module_dir else APP/'build')/('host-build-status.json' if a.host else 'device-build-status.json')
    status.parent.mkdir(parents=True,exist_ok=True)
    for name,job in jobs:
        print('\nBuilding '+name+'...',flush=True)
        try:job()
        except (Exception,SystemExit) as error:
            report['stages'][name]={'passed':False,'error':str(error)}
            traceback.print_exc()
        else:report['stages'][name]={'passed':True}
        status.write_text(json.dumps(report,indent=2)+'\n')
    report['success']=bool(jobs) and all(s['passed'] for s in report['stages'].values())
    status.write_text(json.dumps(report,indent=2)+'\n')
    print('\n'+json.dumps(report,indent=2),flush=True)
    raise SystemExit(0 if report['success'] else 1)
