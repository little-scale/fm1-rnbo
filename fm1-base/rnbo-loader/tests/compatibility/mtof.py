#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Compare actual generated mtof audio with/without its unused desktop table."""
import ctypes as C,importlib.util,json,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1];BASE=APP.parent
sys.path.insert(0,str(HERE))
from fixtures import Graph
spec=importlib.util.spec_from_file_location('compat_probe',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)

def main():
    out=APP/'build/compatibility-mtof-comparison';out.mkdir(exist_ok=True)
    results=[]
    for operator in ['mtof','mtof~']:
        g=Graph();note=g.box('param note 69 @min -127 @max 255');tuning=g.box('param tuning 440 @min 220 @max 880');obj=g.box(operator)
        gain=g.box('*~ 0.00000001');g.wire(note,obj);g.wire(tuning,obj,inlet=1);g.wire(obj,gain);g.output(gain)
        directory=out/operator.replace('~','_signal');directory.mkdir(exist_ok=True)
        patch=directory/'comparison.rnbopat';patch.write_text(json.dumps(g.document()))
        export=directory/'export'
        subprocess.run(['node',str(BASE/'rnbo/tools/export.cjs'),str(patch),'--out',str(export),'--fast-phase'],check=True,capture_output=True)
        code=export/'rnbo_source.h'
        # Test both allocation sizes using the same generated arithmetic.
        subprocess.run(['node','-e',"const fs=require('fs'),p=process.argv[1];let s=fs.readFileSync(p,'utf8');s=s.replace(/(innerMtoF_buffer->requestSize\\()2(, 1\\);)/g,'$165536$2');const r=require(process.argv[2]).compactMtofTables(s);if(r.count!==1)throw Error('Expected one proven unread mtof table');fs.writeFileSync(p+'.reference',s);fs.writeFileSync(p+'.compact',r.code);",str(code),str(BASE/'rnbo/tools/mtof-table.cjs')],check=True)
        modules=[];stats=[]
        for mode in ['reference','compact']:
            lib=directory/(mode+'.dylib');objfile=directory/(mode+'.o')
            flags=['-std=c++11','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-fvisibility=hidden','-DPLAT_HOST','-O2','-ffp-contract=off',
                   '-I'+str(export/'common'),f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{code}.{mode}"','-DRNBO_FM1_POOL_BYTES=524288']
            subprocess.run(['clang++',*flags,'-c',str(APP/'modules/entry.cpp'),'-o',str(objfile)],check=True,capture_output=True)
            subprocess.run(['clang','-dynamiclib',str(objfile),'-lm','-o',str(lib)],check=True,capture_output=True)
            handle=C.CDLL(str(lib));api=probe.Api.in_dll(handle,'rnbo_module')
            init=C.CFUNCTYPE(C.c_int)(api.init);assert init()==1
            modules.append((handle,api));s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));stats.append(s.pool_used)
        renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(api.render) for _,api in modules]
        setters=[C.CFUNCTYPE(None,C.c_uint,C.c_float)(api.set) for _,api in modules]
        words=0;peak=0
        for note in [0,.01,.1,.25,.4,.5,.75,.99,1]:
            for tuning in [0,.1,.5,.9,1]:
                for setter in setters:setter(0,note);setter(1,tuning)
                for _ in range(4):
                    buffers=[(C.c_int*512)() for _ in renders]
                    for render,buffer in zip(renders,buffers):render(buffer,256,4096)
                    assert list(buffers[0])==list(buffers[1]),'mtof audio changed'
                    peak=max(peak,max(map(abs,buffers[0])));words+=512
        expected_saving=((65536*4+31)&~15)-((2*4+31)&~15)
        assert peak>16 and stats[0]-stats[1]==expected_saving,(peak,stats)
        for _,api in modules:
            s=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(s));assert not(s.late or s.errors or s.bad_samples)
        results.append(dict(operator=operator,identical_audio_words=words,reference_arena_bytes=stats[0],compact_arena_bytes=stats[1],saved_bytes=stats[0]-stats[1]))
    (out/'result.json').write_text(json.dumps(results,indent=2)+'\n');print(json.dumps(results,indent=2))

if __name__=='__main__':main()
