#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Compare real bounded averaging kernels, including resets, bit for bit."""
import ctypes as C,importlib.util,json,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
sys.path.insert(0,str(HERE))
from fixtures import Graph
spec=importlib.util.spec_from_file_location('avg_api',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)
def main():
    results=[]
    for kind,text in [('mean','average~ 32'),('rms','average_rms~ 32'),('both','average~ 32')]:
        out=APP/'build/bounded-average-comparison'/kind;out.mkdir(parents=True,exist_ok=True)
        g=Graph();src=g.box('cycle~ 137');reset=g.box('param reset 0 @min 0 @max 1');avg=g.box(text);gain=g.box('*~ 0.05')
        g.wire(src,avg);g.wire(reset,avg,inlet=2);g.wire(avg,gain)
        second=None
        if kind=='both':
            rms=g.box('average_rms~ 64');second=g.box('*~ 0.05');g.wire(src,rms);g.wire(reset,rms,inlet=2);g.wire(rms,second)
        g.output(gain,second)
        patch=out/(kind+'.rnbopat');patch.write_text(json.dumps(g.document()))
        module=out/'module';module.mkdir(exist_ok=True);(module/'module.json').write_text(json.dumps({'fast_phase':True,'float32_delays':True}))
        r=subprocess.run([sys.executable,str(APP/'tools/build.py'),'--host','--patch',str(patch),'--module-dir',str(module)],text=True,capture_output=True)
        (out/'build.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
        export=module/'export';obj=out/'original.o';original=out/'original.dylib'
        flags=['-std=c++11','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-fvisibility=hidden','-DPLAT_HOST','-O2','-ffp-contract=off','-DRNBO_FM1_POOL_BYTES=2097152','-I'+str(export/'common'),f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{export}/rnbo_source.unbounded-average.h"']
        subprocess.run(['clang++',*flags,'-c',str(APP/'modules/entry.cpp'),'-o',str(obj)],check=True)
        subprocess.run(['clang','-dynamiclib',str(obj),'-lm','-o',str(original)],check=True)
        handles=[];apis=[];used=[]
        for path in [original,module/'build'/(kind+'.dylib')]:
            lib=C.CDLL(str(path));handles.append(lib);api=probe.Api.in_dll(lib,'rnbo_module');apis.append(api);assert C.CFUNCTYPE(C.c_int)(api.init)()==1
            s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));used.append(s.pool_used)
        renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(a.render) for a in apis]
        setters=[C.CFUNCTYPE(None,C.c_uint,C.c_float)(a.set) for a in apis];buffers=[(C.c_int*512)(),(C.c_int*512)()];peak=0
        for block in range(2048):
            if block%128==0:
                for setter in setters:setter(0,float((block//128)%2))
            for render,buffer in zip(renders,buffers):render(buffer,256,4096)
            assert list(buffers[0])==list(buffers[1]),(kind,block)
            peak=max(peak,max(map(abs,buffers[0])))
        assert peak>16 and used[1]<98304
        for api in apis:
            s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));assert not(s.errors or s.late or s.bad_samples)
        result=dict(case=text,identical_audio_words=2048*512,original_arena=used[0],bounded_arena=used[1],history=json.loads((export/'provenance.json').read_text())['bounded_average_buffers'],hardware_test=False)
        results.append(result);print(json.dumps(result),flush=True)
    (APP/'build/bounded-average-comparison/result.json').write_text(json.dumps(results,indent=2)+'\n')
if __name__=='__main__':main()
