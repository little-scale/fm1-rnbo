#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Compare bounded filters against the original large buffers (host only)."""
import ctypes as C,importlib.util,json,math,re,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1];BASE=APP.parent
sys.path.insert(0,str(HERE))
from fixtures import Graph
spec=importlib.util.spec_from_file_location('bound_api',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)

def compare(kind,driver,dynamic=False,explicit=False,signal=False,high=False):
    name=kind+('_feedback' if high else '_signal' if signal else '_cap' if explicit else '_mod' if dynamic else '_'+driver);out=APP/'build/bounded-filter-comparison'/name;out.mkdir(parents=True,exist_ok=True)
    g=Graph();src=g.box('cycle~ 125' if high else 'cycle~ 137' if driver=='sine' else 'phasor~ 1')
    if driver=='impulse':
        pulse=g.box('expr~ in1 < 0.00002267573696');g.wire(src,pulse);src=pulse
    obj=g.box(('allpass~ 16 0.98' if high else 'allpass~ 16 0.5') if kind=='allpass' else ('comb~ 16 0.5 0.5 0.98' if high else 'comb~ 16 0.5 0.5 0.5'));g.wire(src,obj)
    if dynamic:
        if signal:
            phase=g.box('phasor~ 0.5');param=g.box('*~ 32');g.wire(phase,param)
        else:param=g.box('param time 16 @min 0 @max 32')
        g.wire(param,obj,inlet=1)
    gain=g.box('*~ 0.005' if high else '*~ 0.05');g.wire(obj,gain);g.output(gain)
    patch=out/(name+'.rnbopat');patch.write_text(json.dumps(g.document()))
    module=out/'module';module.mkdir(exist_ok=True);config={'fast_phase':True,'float32_delays':True}
    if explicit:config['filter_delay_max_ms']=16
    (module/'module.json').write_text(json.dumps(config))
    log=subprocess.run([sys.executable,str(APP/'tools/build.py'),'--host','--patch',str(patch),'--module-dir',str(module)],text=True,capture_output=True)
    (out/'build.log').write_text(log.stdout+log.stderr);assert log.returncode==0,log.stdout+log.stderr
    export=module/'export';handles=[];apis=[];allocations=[]
    for mode,header in [('original',export/'rnbo_source.unbounded.h'),('bounded',export/'rnbo_source.h')]:
        if explicit and mode=='original':
            original=header.read_text()
            original,count=re.subn(r'this->mstosamps\((__delayTime|delayTime(?:\[\(Index\)i\])?)\)',lambda m:'this->mstosamps(('+m[1]+' > 16.0f ? 16.0f : '+m[1]+'))',original)
            assert count==1
            header=export/'rnbo_source.capped-reference.h';header.write_text(original)
        objfile=out/(mode+'.o');lib=out/(mode+'.dylib')
        pool=2097152 if mode=='original' else 98304
        flags=['-std=c++11','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-fvisibility=hidden','-DPLAT_HOST','-O2','-ffp-contract=off',f'-DRNBO_FM1_POOL_BYTES={pool}','-I'+str(export/'common'),f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{header}"']
        subprocess.run(['clang++',*flags,'-c',str(APP/'modules/entry.cpp'),'-o',str(objfile)],check=True)
        subprocess.run(['clang','-dynamiclib',str(objfile),'-lm','-o',str(lib)],check=True)
        handle=C.CDLL(str(lib));handles.append(handle);api=probe.Api.in_dll(handle,'rnbo_module');apis.append(api)
        assert C.CFUNCTYPE(C.c_int)(api.init)()==1
        s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));allocations.append(s.pool_used)
    renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(a.render) for a in apis]
    setters=[C.CFUNCTYPE(None,C.c_uint,C.c_float)(a.set) for a in apis]
    buffers=[(C.c_int*512)(),(C.c_int*512)()];energy=0;error=0;peak_error=0;words=0
    for block in range(2048):
        if dynamic and not signal and block%128==0:
            value=[0,.01,.25,.5,.75,.99,1][(block//128)%7]
            for setter in setters:setter(0,value)
        for render,buffer in zip(renders,buffers):render(buffer,256,4096)
        for a,b in zip(*buffers):
            energy+=a*a;error+=(a-b)**2;peak_error=max(peak_error,abs(a-b));words+=1
    relative=math.sqrt(error/max(1,energy))
    assert energy>0 and relative<.01 and peak_error<8389,(name,relative,peak_error)
    for api in apis:
        s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));assert not(s.errors or s.late or s.bad_samples)
    return dict(case=name,compared_audio_words=words,relative_rms_error=relative,peak_error_full_scale=peak_error/8388607,original_arena=allocations[0],bounded_arena=allocations[1],buffers=json.loads((export/'provenance.json').read_text())['bounded_filter_buffers'],hardware_test=False)

def main():
    results=[]
    for kind in ['allpass','comb']:
        for driver in (['sine'] if '--quick' in sys.argv else ['sine','impulse']):
            r=compare(kind,driver);results.append(r);print(json.dumps(r),flush=True)
        if '--quick' in sys.argv:continue
        r=compare(kind,'sine',True);results.append(r);print(json.dumps(r),flush=True)
        r=compare(kind,'sine',True,True);results.append(r);print(json.dumps(r),flush=True)
        r=compare(kind,'sine',True,True,True);results.append(r);print(json.dumps(r),flush=True)
        r=compare(kind,'sine',high=True);results.append(r);print(json.dumps(r),flush=True)
    (APP/('build/bounded-filter-comparison/quick-result.json' if '--quick' in sys.argv else 'build/bounded-filter-comparison/result.json')).write_text(json.dumps(results,indent=2)+'\n')
if __name__=='__main__':main()
