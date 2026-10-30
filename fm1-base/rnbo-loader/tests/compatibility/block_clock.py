#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Compare real RNBO audio before/after block-clock hoisting."""
import ctypes as C,importlib.util,json,subprocess
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
spec=importlib.util.spec_from_file_location('clock_probe',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)
def main():
    results=[]
    for folder,name in [('compatibility-clock-fix','scheduled line~'),('compatibility-snapshot-fix','snapshot~ 10')]:
        root=APP/'build'/folder;row=next(c for c in json.loads((root/'report.json').read_text())['cases'] if c['name']==name)
        export=root/'runs'/row['id']/'production/module/export';source=export/'rnbo_source.h';code=source.read_text()
        expression='this->sampsToMs((SampleIndex)(256)) + this->_currentTime'
        declaration='    const MillisecondTime fm1_block_end_time = '+expression+';'
        assert declaration in code
        original=code.replace(declaration,'').replace('fm1_block_end_time',expression)
        reference=export/'clock-reference.h';reference.write_text(original)
        handles=[];apis=[]
        for mode,header in [('reference',reference),('hoisted',source)]:
            out=export.parent/'build';obj=out/('clock-'+mode+'.o');lib=out/('clock-'+mode+'.dylib')
            flags=['-std=c++11','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-fvisibility=hidden','-DPLAT_HOST','-O2','-ffp-contract=off','-I'+str(export/'common'),f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{header}"']
            subprocess.run(['clang++',*flags,'-c',str(APP/'modules/entry.cpp'),'-o',str(obj)],check=True)
            subprocess.run(['clang','-dynamiclib',str(obj),'-lm','-o',str(lib)],check=True)
            handle=C.CDLL(str(lib));handles.append(handle);api=probe.Api.in_dll(handle,'rnbo_module');apis.append(api);assert C.CFUNCTYPE(C.c_int)(api.init)()==1
        renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(api.render) for api in apis];buffers=[(C.c_int*512)(),(C.c_int*512)()]
        for _ in range(2048):
            for render,buffer in zip(renders,buffers):render(buffer,256,4096)
            assert list(buffers[0])==list(buffers[1]),name
        results.append(dict(case=name,identical_audio_words=2048*512))
    (APP/'build/block-clock-comparison.json').write_text(json.dumps(results,indent=2)+'\n');print(json.dumps(results,indent=2))
if __name__=='__main__':main()
