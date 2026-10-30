#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Validate off-loop peakamp interval updates against the original DSP."""
import ctypes as C,importlib.util,json,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
sys.path.insert(0,str(HERE))
from fixtures import Graph
spec=importlib.util.spec_from_file_location('peak_api',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)
def main():
    out=APP/'build/peak-interval-comparison';out.mkdir(exist_ok=True)
    g=Graph();src=g.box('cycle~ 137');param=g.box('param interval 10 @min 1 @max 100');obj=g.box('peakamp~ 10');gain=g.box('*~ 0.05')
    g.wire(src,obj);g.wire(param,obj,inlet=1);g.wire(obj,gain);g.output(gain)
    patch=out/'peak.rnbopat';patch.write_text(json.dumps(g.document()));module=out/'module';module.mkdir(exist_ok=True)
    (module/'module.json').write_text(json.dumps({'fast_phase':False,'float32_delays':True}))
    r=subprocess.run([sys.executable,str(APP/'tools/build.py'),'--host','--patch',str(patch),'--module-dir',str(module)],text=True,capture_output=True)
    (out/'build.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
    export=module/'export';objfile=out/'original.o';original=out/'original.dylib'
    flags=['-std=c++11','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-fvisibility=hidden','-DPLAT_HOST','-O2','-ffp-contract=off','-DRNBO_FM1_POOL_BYTES=98304','-I'+str(export/'common'),f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{export}/rnbo_source.sample-interval.h"']
    subprocess.run(['clang++',*flags,'-c',str(APP/'modules/entry.cpp'),'-o',str(objfile)],check=True)
    subprocess.run(['clang','-dynamiclib',str(objfile),'-lm','-o',str(original)],check=True)
    handles=[];apis=[]
    for path in [original,module/'build/peak.dylib']:
        lib=C.CDLL(str(path));handles.append(lib);api=probe.Api.in_dll(lib,'rnbo_module');apis.append(api);assert C.CFUNCTYPE(C.c_int)(api.init)()==1
    renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(a.render) for a in apis]
    setters=[C.CFUNCTYPE(None,C.c_uint,C.c_float)(a.set) for a in apis];buffers=[(C.c_int*512)(),(C.c_int*512)()];peak=0
    for block in range(2048):
        if block%128==0:
            for setter in setters:setter(0,[0,.1,.5,1][(block//128)%4])
        for render,buffer in zip(renders,buffers):render(buffer,256,4096)
        assert list(buffers[0])==list(buffers[1]),block
        peak=max(peak,max(map(abs,buffers[0])))
    assert peak>16
    for api in apis:
        s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));assert not(s.errors or s.late or s.bad_samples)
    result=dict(identical_audio_words=2048*512,fast_phase=False,interval_ms=[1,100],hardware_test=False)
    (out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
