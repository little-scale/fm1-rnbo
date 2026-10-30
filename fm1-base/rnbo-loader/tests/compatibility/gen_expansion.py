#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Real RNBO 1.4.4 host builds, portability audits and GenExpr audio comparisons."""
import argparse,concurrent.futures,ctypes as C,hashlib,json,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1];sys.path.insert(0,str(HERE))
from fixtures import Graph
from gen_feedback import patch
from probe import Api,Stats

def constant_cases():
 names=['pi','PI','twopi','TWOPI','halfpi','HALFPI','invpi','e','phi','sqrt2','sqrt1_2','ln2','ln10','log2e','log10e','degtorad','radtodeg','samplerate','SAMPLERATE','vectorsize','VECTORSIZE']
 for name in names:
  # RNBO folds integer-valued globals differently across inline expressions.
  # A fractional scale checks the actual target values without integer division.
  if name.lower() in ('samplerate','vectorsize'):
   g=Graph();a=g.box(name);m=g.box('* 0.00001');o=g.box('out 1');g.wire(a,m);g.wire(m,o)
   yield ('constant_'+name,g,f'out1={name}*0.00001;',0,1)
   continue
  g=Graph();a=g.box(name);ab=g.box('abs');add=g.box('+ 1');div=g.box('/');o=g.box('out 1');g.wire(a,ab);g.wire(ab,add);g.wire(a,div);g.wire(add,div,inlet=1);g.wire(div,o)
  yield ('constant_'+name,g,f'out1={name}/(1.0+abs({name}));',0,1)
 for text,expr in [('constant 0.25','0.25'),('0.25','0.25'),('float 0.25','float(0.25)'),('f 0.25','float(0.25)'),('int 2.75','int(2.75)'),('i -2.75','int(-2.75)')]:
  g=Graph();a=g.box(text);o=g.box('out 1');g.wire(a,o)
  yield ('literal_'+text.replace(' ','_'),g,'out1='+expr+';',0,1)

def run_case(case,root,fast=True):
 name,graph,expr,nin,nout=case;folder=root/(name.replace('/','_')+'_'+hashlib.sha256(name.encode()).hexdigest()[:6]);folder.mkdir(parents=True,exist_ok=True)
 row=dict(case=name,fast_phase=fast,hardware_test=False)
 try:
  apis=[];handles=[];artifacts=[]
  for visual in [False,True]:
   module=folder/('visual' if visual else 'reference');module.mkdir(exist_ok=True);source=module/'patch.rnbopat';document=patch(graph,expr,nin,nout,visual)
   if name.startswith('param_'):
    next(b['box'] for b in document['patcher']['boxes'] if b['box']['text']=='gen~')['text']='gen~ @exposeparams 1'
   source.write_text(json.dumps(document))
   (module/'module.json').write_text(json.dumps(dict(fast_phase=fast,float32_delays=True)))
   r=subprocess.run([sys.executable,str(APP/'tools/build.py'),'--host','--patch',str(source),'--module-dir',str(module)],capture_output=True,text=True,timeout=150)
   (module/'build.log').write_text(r.stdout+r.stderr)
   if r.returncode:raise RuntimeError(str(module/'build.log'))
   libpath=module/'build/patch.dylib';lib=C.CDLL(str(libpath));handles.append(lib);api=Api.in_dll(lib,'rnbo_module');apis.append(api);artifacts.append(hashlib.sha256(libpath.read_bytes()).hexdigest())
  renders=[C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(a.render) for a in apis];bufs=[(C.c_int*512)(),(C.c_int*512)()];peak=0;noise_samples=[[],[]]
  for restart in range(2):
   for a in apis:assert C.CFUNCTYPE(C.c_int)(a.init)()==1
   for block in range(128):
    if name.startswith('param_') and block%16==0:
     for api in apis:
      assert C.CFUNCTYPE(C.c_uint)(api.count)()==1
      C.CFUNCTYPE(None,C.c_uint,C.c_float)(api.set)(0,[0,.25,.5,.75,1][(block//16)%5])
    for render,buf in zip(renders,bufs):render(buf,256,4096)
    if name=='extra_noise':
     for samples,buf in zip(noise_samples,bufs):samples.extend(buf[::2])
    else:assert list(bufs[0])==list(bufs[1]),('audio mismatch',block,list(bufs[0])[:4],list(bufs[1])[:4])
    peak=max(peak,max(map(abs,bufs[0])))
  stats=[]
  for a in apis:
   s=Stats();C.CFUNCTYPE(None,C.POINTER(Stats))(a.stats)(C.byref(s));assert not(s.errors or s.late or s.bad_samples);stats.append(s.pool_used)
  if name=='extra_noise':
   for samples in noise_samples:
    assert len(set(samples))>1000 and min(samples)<-200000 and max(samples)>200000
    assert max(map(abs,samples))<=419431 and abs(sum(samples)/len(samples))<15000
   row['comparison']='noise range, variation and mean; independent random seeds'
  row.update(status='pass',audio_words=None if name=='extra_noise' else 131072,peak=peak,pool_bytes=stats,artifact_sha256=artifacts)
 except Exception as e:row.update(status='fail',error=str(e))
 print(json.dumps(row),flush=True);return row

def other_cases():
 for name,initial,lo,hi in [('gain',0.25,0,1),('bipolar',0,-2,2)]:
  g=Graph();v=g.box(f'param {name} {initial} @min {lo} @max {hi}');o=g.box('out 1');g.wire(v,o)
  yield ('param_'+name,g,f'Param {name}({initial}, min={lo}, max={hi}); out1={name};',0,1)
 for text,expr,nin in [
  ('cycle','cycle(137)',0),('phasor 137','phasor(137,0)',0),('triangle','triangle(in1,0.5)',1),
  ('train 31 0.5','train(31,0.5,0)',0),('rate 2','rate(in1,2)',1),
  ('delta','delta(in1)',1),('change','change(in1)',1),('dcblock','dcblock(in1)',1),
  ('slide 5 10','slide(in1,5,10)',1),('sah 0','sah(in1,0,0)',1),('latch','latch(in1,1)',1),
  ('accum @min 0 @max 1','accum(in1,0,min=0,max=1)',1)]:
  g=Graph();o=g.box(text);out=g.box('out 1');g.wire(o,out)
  if text=='cycle':a=g.box('constant 137');g.wire(a,o)
  if nin:
   a=g.box('in 1');g.wire(a,o)
   if text=='latch':b=g.box('constant 1');g.wire(b,o,inlet=1)
  yield ('operator_'+text.replace(' ','_'),g,'out1='+expr+';',nin,1)

def math_cases():
 unary='abs neg sign floor ceil fract sin cos tan sinh cosh tanh asin acos atan asinh atanh sqrt exp exp2 log log2 log10 bool not pass float fixnan fixdenorm isnan isdenorm radians degrees fastsin fastcos fasttan fastexp'.split()
 for op in unary:
  g=Graph();a=g.box('in 1');offset=g.box('+ 0.5');b=g.box(op);o=g.box('out 1');g.wire(a,offset);g.wire(offset,b);g.wire(b,o)
  yield ('math_'+op,g,f'x=in1+0.5; out1={op}(x);',1,1)
 for op in 'add sub mul div min max absdiff pow fastpow hypot atan2 mod eq neq lt lte gt gte eqp neqp ltp ltep gtp gtep and or xor step'.split():
  g=Graph();a=g.box('in 1');b=g.box(op+' 0.005');o=g.box('out 1');g.wire(a,b);g.wire(b,o)
  yield ('math_'+op,g,(f'out1={op}(0.005,in1);' if op in ('atan2','hypot') else f'out1={op}(in1,0.005);'),1,1)
 for text,expr in [('clamp -0.005 0.005','clamp(in1,-0.005,0.005)'),('wrap -0.005 0.005','wrap(in1,-0.005,0.005)'),('fold -0.005 0.005','fold(in1,-0.005,0.005)'),('scale -0.01 0.01 -1 1','scale(in1,-0.01,0.01,-1,1)'),('mstosamps','mstosamps(in1)'),('sampstoms','sampstoms(in1)'),('mtof','mtof(in1)'),('ftom','ftom(abs(in1)+0.5)'),('dbtoa','dbtoa(in1)'),('atodb','atodb(abs(in1)+0.5)'),('t60','t60(abs(in1)+10)'),('t60time','t60time(abs(in1)+0.5)'),('round 0.005','round(in1,0.005)'),('phasewrap','phasewrap(in1)')]:
  g=Graph();a=g.box('in 1');b=g.box(text);o=g.box('out 1')
  if text in ['ftom','atodb','t60time','t60']:
   ab=g.box('abs');off=g.box('+ 10' if text=='t60' else '+ 0.5');g.wire(a,ab);g.wire(ab,off);g.wire(off,b)
  else:g.wire(a,b)
  g.wire(b,o)
  yield ('math_'+text.replace(' ','_'),g,'out1='+expr+';',1,1)

def structure_cases():
 for op in ['selector','gate']:
  g=Graph();a=g.box('in 1');c=g.box('counter 1 4');o=g.box(op+' 3');out=g.box('out 1');g.wire(c,o);g.wire(a,o,inlet=1);g.wire(o,out)
  if op=='selector':
   b=g.box('constant 0.25');d=g.box('constant -0.125');g.wire(b,o,inlet=2);g.wire(d,o,inlet=3);expr='c=counter(1,0,4);out1=selector(c,in1,0.25,-0.125);';nout=1
  else:
   out2=g.box('out 2');g.wire(o,out2,outlet=2);expr='c=counter(1,0,4);a,b,d=gate(c,in1,choices=3);out1=a;out2=d;';nout=2
  yield ('routing_'+op,g,expr,1,nout)
 g=Graph();a=g.box('in 1');s=g.box('send bus');r=g.box('receive bus');o=g.box('out 1');g.wire(a,s);g.wire(r,o)
 yield ('routing_send_receive',g,'out1=in1;',1,1)
 for text,expr in [('sah 0','sah(in1,in1,0)'),('latch','latch(in1,in1)'),('counter 1 17','counter(1,0,17)'),('mulequals 0.99 @init 1','mulequals(0.99,0,init=1)'),('cycle @index phase','cycle(in1,index="phase")')]:
  g=Graph();a=g.box('in 1');b=g.box(text);o=g.box('out 1');g.wire(b,o)
  if text.startswith(('sah','latch','cycle')):g.wire(a,b)
  if text.startswith(('sah','latch')):g.wire(a,b,inlet=1)
  yield ('state_'+text.replace(' ','_'),g,'out1='+expr+';',1,1)
 for interp in ['none','linear','cosine','cubic','spline']:
  g=Graph();a=g.box('in 1');d=g.box('delay 64 2 @interp '+interp);t=g.box('constant 5.25');t2=g.box('constant 17.75');o=g.box('out 1');o2=g.box('out 2')
  g.wire(a,d);g.wire(t,d,inlet=1);g.wire(t2,d,inlet=2);g.wire(d,o);g.wire(d,o2,outlet=1)
  yield ('delay_'+interp,g,f'Delay d(64); out1=d.read(5.25,interp="{interp}");out2=d.read(17.75,interp="{interp}");d.write(in1);',1,2)
 from gen_feedback import graphs
 _,child,expr,nin,nout=next(c for c in graphs() if c[0]=='feedback')
 p=child.document()['patcher'];p['classnamespace']='dsp.gen';g=Graph();a=g.box('in 1');n=g.box('gen',patcher=p);o=g.box('out 1');g.wire(a,n);g.wire(n,o)
 yield ('nested_history_feedback',g,expr,nin,nout)
 g=Graph();a=g.box('in 1');c=g.box('',maxclass='codebox',numinlets=1,numoutlets=2,code='History h(0.25); out1=h; out2=in1; h=fixdenorm(h*0.98+in1);');o=g.box('out 1');o2=g.box('out 2');g.wire(a,c);g.wire(c,o);g.wire(c,o2,outlet=1)
 yield ('codebox_history',g,'History h(0.25);out1=h;out2=in1;h=fixdenorm(h*0.98+in1);',1,2)

def buffer_cases():
 for op,pos in [('peek',0),('sample',0),('nearest',0),('lookup',-1),('wave',0)]:
  g=Graph();a=g.box('in 1');data=g.box('data table 64 2');r=g.box(op+' table 2');idx=g.box('constant '+str(pos));g.wire(idx,r)
  o=g.box('out 1');o2=g.box('out 2');g.wire(r,o);g.wire(r,o2,outlet=1)
  w=g.box('poke table');w2=g.box('poke table 1');neg=g.box('neg');g.wire(a,w);g.wire(a,neg);g.wire(neg,w2)
  args=f'table,{pos},0,64,0' if op=='wave' else f'table,{pos},0'
  if op=='wave':end=g.box('constant 64');g.wire(end,r,inlet=2)
  yield ('buffer_'+op,g,f'Data table(64,2);a,b,index={op}({args},channels=2);out1=a;out2=b;poke(table,in1,0,0);poke(table,-in1,0,1);',1,2)
 g=Graph();d=g.box('data table 64 2');dim=g.box('dim table');ch=g.box('channels table');o=g.box('out 1');o2=g.box('out 2');scale=g.box('* 0.01');g.wire(dim,scale);g.wire(scale,o);g.wire(ch,o2)
 yield ('buffer_dimensions',g,'Data table(64,2);out1=dim(table)*0.01;out2=channels(table);',0,2)

def extra_cases():
 # Exercise sample-rate conversion, rather than only compile-time integer casts.
 for op in ['int','trunc','noise','elapsed']:
  g=Graph();b=g.box(op);o=g.box('out 1');g.wire(b,o)
  if op in ('int','trunc'):
   a=g.box('in 1');m=g.box('* 500');g.wire(a,m);g.wire(m,b);expr=f'out1={op}(in1*500);';nin=1
  else:expr='out1='+('noise()' if op=='noise' else op)+';';nin=0
  yield ('extra_'+op,g,expr,nin,1)
 for interp in ['none','linear','cosine','cubic','spline']:
  g=Graph();a=g.box('in 1');d=g.box('data table 64');count=g.box('counter 1 64');w=g.box('poke table');g.wire(a,w);g.wire(count,w,inlet=1)
  offset=g.box('- 9.25');g.wire(count,offset);r=g.box('peek table @boundmode wrap @interp '+interp);g.wire(offset,r);o=g.box('out 1');g.wire(r,o)
  yield ('table_dynamic_'+interp,g,f'Data table(64);c=counter(1,0,64);out1=peek(table,c-9.25,0,boundmode="wrap",interp="{interp}");poke(table,in1,c,0);',1,1)

def remaining_cases():
 for text,expr in [('!- 0.25','0.25-in1'),('!/ 0.005','div(0.005,in1)'),('!% 0.005','mod(0.005,in1)'),('mix -0.5 0.5','mix(-0.5,0.5,in1)'),('smoothstep -0.005 0.005','smoothstep(-0.005,0.005,in1)'),('switch 0.5 -0.5','switch(in1,0.5,-0.5)')]:
  g=Graph();a=g.box('in 1');b=g.box(text);o=g.box('out 1');g.wire(a,b);g.wire(b,o)
  yield ('remaining_'+text.replace(' ','_'),g,'out1='+expr+';',1,1)
 g=Graph();a=g.box('in 1');off=g.box('+ 2');b=g.box('acosh');o=g.box('out 1');g.wire(a,off);g.wire(off,b);g.wire(b,o)
 yield ('remaining_acosh',g,'out1=acosh(in1+2);',1,1)
 for op in ['cartopol','poltocar']:
  g=Graph();a=g.box('in 1');b=g.box(op+' 0.5');o=g.box('out 1');p=g.box('out 2');g.wire(a,b);g.wire(b,o);g.wire(b,p,outlet=1)
  yield ('remaining_'+op,g,f'a,b={op}(0.5,in1);out1=a;out2=b;',1,2)
 for mode in ['none','linear','cosine','cubic','spline']:
  values='0.1 0.2 0.3 0.4' if mode in ['cubic','spline'] else '0.1 0.2'
  g=Graph();a=g.box('in 1');b=g.box('interp '+values+' @mode '+mode);o=g.box('out 1');g.wire(a,b);g.wire(b,o)
  yield ('remaining_interp_'+mode,g,f'out1=interp(in1,{values.replace(" ",",")},mode="{mode}");',1,1)
 g=Graph();a=g.box('in 1');d=g.box('data table 64');w=g.box('splat table');r=g.box('peek table');o=g.box('out 1');g.wire(a,w);g.wire(r,o)
 yield ('remaining_splat',g,'Data table(64);out1=peek(table,0);splat(table,in1,0,0,0);',1,1)


def main():
 p=argparse.ArgumentParser();p.add_argument('--family',default='constants');p.add_argument('--filter',default='');p.add_argument('--jobs',type=int,default=3);a=p.parse_args()
 family=a.family.split('-')[0];factories={'constants':constant_cases,'operators':other_cases,'math':math_cases,'structures':structure_cases,'buffers':buffer_cases,'extra':extra_cases,'remaining':remaining_cases}
 selected=(c for factory in factories.values() for c in factory()) if family=='all' else factories[family]()
 cases=[c for c in selected if a.filter in c[0]];root=APP/'build/gen-expansion'/a.family;root.mkdir(parents=True,exist_ok=True)
 with concurrent.futures.ProcessPoolExecutor(max_workers=a.jobs) as ex:rows=list(ex.map(run_case,cases,[root]*len(cases)))
 report=dict(rnbo_version='1.4.4',cases=rows,hardware_test=False);(root/'report.json').write_text(json.dumps(report,indent=2)+'\n')
 if any(r['status']!='pass' for r in rows):sys.exit(1)
if __name__=='__main__':main()
