#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Compile visual Gen and independent GenExpr references; compare actual audio."""
import ctypes as C,importlib.util,json,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
sys.path.insert(0,str(HERE))
from fixtures import Graph
spec=importlib.util.spec_from_file_location('gen_probe',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)
def graphs():
    g=Graph();a=g.box('in 1');b=g.box('* 0.5');o=g.box('out 1');g.wire(a,b);g.wire(b,o)
    yield 'arithmetic',g,'out1 = in1 * 0.5;',1,1
    g=Graph();a=g.box('in 1');h=g.box('history previous 0.25');s=g.box('+');m=g.box('* 0.98');o=g.box('out 1')
    g.wire(a,s);g.wire(h,s,inlet=1);g.wire(s,m);g.wire(m,h);g.wire(h,o)
    yield 'feedback',g,'History previous(0.25); out1 = previous; previous = (in1 + previous) * 0.98;',1,1
    g=Graph();a=g.box('history left 0.25');b=g.box('history right -0.125');o=g.box('out 1');p=g.box('out 2')
    g.wire(a,b);g.wire(b,a);g.wire(a,o);g.wire(b,p)
    yield 'coupled',g,'History left(0.25); History right(-0.125); oldleft = left; oldright = right; out1 = oldleft; out2 = oldright; left = oldright; right = oldleft;',0,2
    g=Graph();a=g.box('in 1');h=g.box('history');s=g.box('-');o=g.box('out 1')
    g.wire(a,s);g.wire(h,s,inlet=1);g.wire(a,h);g.wire(s,o)
    yield 'difference',g,'History previous(0); out1 = in1 - previous; previous = in1;',1,1
    g=Graph();a=g.box('history fm1g0 0.25');o=g.box('out 1');g.wire(a,o)
    yield 'initial_hold',g,'History previous(0.25); out1 = previous;',0,1

def patch(graph,expr,nin,nout,visual):
    g=Graph();kwargs={}
    if visual:
        p=graph.document()['patcher'];p['classnamespace']='dsp.gen';kwargs['patcher']=p
    else:kwargs['rnbo_extra_attributes']=dict(expr=expr,geninlets=nin,genoutlets=nout)
    obj=g.box('gen~',**kwargs)
    if nin:
        a=g.box('cycle~ 137');gain=g.box('*~ 0.01');g.wire(a,gain);g.wire(gain,obj)
    for channel in range(2):
        gain=g.box('*~ 0.05');out=g.box('out~ '+str(channel+1));g.wire(obj,gain,outlet=min(channel,nout-1));g.wire(gain,out)
    return g.document()

def main():
    root=APP/'build/gen-feedback-comparison';root.mkdir(exist_ok=True);results=[]
    for name,graph,expr,nin,nout in graphs():
        apis=[];libs=[]
        for visual in [False,True]:
            folder=root/name/('visual' if visual else 'reference');folder.mkdir(parents=True,exist_ok=True)
            source=folder/'patch.rnbopat';source.write_text(json.dumps(patch(graph,expr,nin,nout,visual)))
            (folder/'module.json').write_text(json.dumps(dict(fast_phase=True,float32_delays=True)))
            r=subprocess.run([sys.executable,str(APP/'tools/build.py'),'--host','--patch',str(source),'--module-dir',str(folder)],capture_output=True,text=True)
            (folder/'build.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
            lib=C.CDLL(str(folder/'build/patch.dylib'));libs.append(lib);api=probe.Api.in_dll(lib,'rnbo_module');apis.append(api)
        renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(a.render) for a in apis]
        buffers=[(C.c_int*512)(),(C.c_int*512)()];peak=0
        for restart in range(2):
            for api in apis:assert C.CFUNCTYPE(C.c_int)(api.init)()==1
            for block in range(1024):
                for render,buffer in zip(renders,buffers):render(buffer,256,4096)
                assert list(buffers[0])==list(buffers[1]),(name,restart,block)
                peak=max(peak,max(map(abs,buffers[0])))
            for api in apis:
                stats=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(stats));assert not(stats.errors or stats.late or stats.bad_samples)
        assert peak>16,name
        results.append(dict(case=name,identical_audio_words=1048576,reinitializations=2,peak=peak,hardware_test=False));print(json.dumps(results[-1]),flush=True)
    (root/'result.json').write_text(json.dumps(results,indent=2)+'\n')
if __name__=='__main__':main()
