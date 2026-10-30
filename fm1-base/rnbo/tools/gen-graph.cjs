// SPDX-License-Identifier: MIT
// Translate embedded Gen graphs using the installed RNBO constructor catalogue.
// Original graphs remain editable; only the compiler copy consumes GenExpr.
const fs=require('node:fs'),path=require('node:path');
let cached;
function catalogue(){
 if(cached)return cached;
 const root=process.env.RNBO_DIR||path.join(process.env.HOME,'Documents/Max 9/Packages/RNBO');
 const entries=JSON.parse(fs.readFileSync(path.join(root,'server/node_modules/@rnbo/genexpr_js/operators.json')));
 cached=new Map();for(const o of entries){cached.set(o.op,o);if(Array.isArray(o.aliases))for(const a of o.aliases)cached.set(a,o);}
 return cached;
}
const arr=v=>Array.isArray(v)?v:[];
const numeric=v=>typeof v==='number'?Number.isFinite(v):typeof v==='string'&&/^[+-]?(?:\d+\.?\d*|\.\d+)(?:e[+-]?\d+)?$/i.test(v)&&Number.isFinite(Number(v));
const identifier=v=>typeof v==='string'&&/^[A-Za-z_]\w*$/.test(v);
function genGraph(p,options={}){
 const cats=options.catalogue||catalogue();
 const fail=s=>{throw Error('Unsupported embedded Gen graph: '+s);};
 let prefix='fm1g';while(JSON.stringify(p).includes(prefix))prefix+='g';
 const nodes=new Map(),incoming=new Map(),histories=[],delays=[],declarations=[],functions=[],resources=new Map(),receivers=[],sends=new Map(),changes=[];
 let serial=0,estimatedBytes=0;
 const budget=options.bufferMaxBytes??24576,defaultDelay=options.delayMaxSamples??2048;
 if(!Number.isInteger(budget)||budget<16||budget>131072||!Number.isInteger(defaultDelay)||defaultDelay<1||defaultDelay>44100)fail('invalid Gen memory limits');
 const atom=v=>{
  if(v===true||v==='true')return '1';if(v===false||v==='false')return '0';
  if(numeric(v))return String(v);
  const o=cats.get(v);if(o?.box_expr==='constant')return o.op;
  fail('expected numeric value or constant, got '+v);
 };
 const symbol=v=>{if(!identifier(v)||/^(?:in|out)\d+$/.test(v))fail('invalid/reserved name '+v);return v;};
 function reserve(bytes,label){estimatedBytes+=bytes;if(estimatedBytes>budget)fail(label+' exceeds Gen buffer budget ('+estimatedBytes+' > '+budget+' bytes); reduce sizes or set gen_buffer_max_bytes');}
 function attributes(o,attrs){
  const result=[];
  for(const [key,value] of Object.entries(attrs)){
   const def=o.attributes?.[key];if(!def)fail('unknown attribute @'+key+' on '+o.op);
   if(def.type==='enum'){if(!def.enums?.[value])fail('invalid @'+key);result.push(key+'='+JSON.stringify(value));}
   else if(def.type==='string')result.push(key+'='+JSON.stringify(symbol(value)));
   else result.push(key+'='+atom(value));
  }
  return result;
 }
 function canvas(p,scope='',depth=0){
  if(depth>16||p.classnamespace!=='dsp.gen'||!Array.isArray(p.boxes)||!Array.isArray(p.lines))fail('invalid Gen canvas');
  const ports=new Map(),ins=new Map(),outs=new Map();
  for(const {box:b} of p.boxes){
   if(['comment','panel'].includes(b.maxclass))continue;
   if(ports.has(b.id))fail('duplicate object ID');
   let tokens=(b.text||'').trim().split(/\s+/),spelling=tokens.shift();
   if(numeric(spelling)){tokens.unshift(spelling);spelling='constant';}
   const args=[],attrs={};
   for(let i=0;i<tokens.length;i++){
    if(tokens[i].startsWith('@')){const k=tokens[i].slice(1);if(Object.hasOwn(attrs,k)||i+1===tokens.length)fail('duplicate/incomplete attribute');attrs[k]=tokens[++i];}
    else args.push(tokens[i]);
   }
   // Gen stores semantic attributes in object text. Reject unreviewed saved values.
   if(b.saved_object_attributes&&Object.keys(b.saved_object_attributes).length)fail('saved Gen attributes require explicit object text');
   if(b.patcher){
    if(spelling!=='gen'||args.length>1||Object.keys(attrs).length)fail('nested Gen arguments');
    const child=canvas(b.patcher,scope+'n'+serial+++'_',depth+1);ports.set(b.id,{inputs:child.ins,outputs:child.outs});continue;
   }
   const meta=cats.get(spelling),op=b.maxclass==='codebox'?'codebox':meta?.op;
   if(!op)fail('object '+spelling);
   const id=prefix+serial++,n={id,op,meta,args,attrs,scope};let inputs=[],outputs=1;
   if(op==='codebox'){
    if(!Number.isInteger(b.numinlets)||b.numinlets<0||b.numinlets>16||!Number.isInteger(b.numoutlets)||b.numoutlets<1||b.numoutlets>16||typeof b.code!=='string'||b.code.length>65536)fail('codebox needs saved port metadata');
    inputs=Array.from({length:b.numinlets},(_,i)=>'in'+(i+1));outputs=b.numoutlets;n.function=id+'_code';
    functions.push(n.function+'('+inputs.join(', ')+') {\n'+b.code+'\nreturn '+Array.from({length:outputs},(_,i)=>'out'+(i+1)).join(', ')+';\n}');
   }else if(op==='in'||op==='out'){
    if(args.length!==1||!/^\d+$/.test(args[0])||+args[0]<1||+args[0]>16||Object.keys(attrs).length)fail('invalid port');
    const index=+args[0]-1,m=op==='in'?ins:outs;if(m.has(index))fail('duplicate '+op+' port');m.set(index,id);
    if(depth)n.op='alias';else n.port=index+1;
    inputs=(op==='out'||depth)?['value']:[];outputs=op==='out'&&!depth?0:1;
   }else if(op==='constant'){
    if(args.length!==1||Object.keys(attrs).length)fail('constant requires one value');n.expression=atom(args[0]);
   }else if(op==='history'||op==='param'){
    if(Object.keys(attrs).some(k=>!['min','max'].includes(k))||(op==='history'&&Object.keys(attrs).length))fail('unsupported state attributes');
    if(args.length>(op==='history'?2:2)||(!args.length&&op==='param'))fail('state arguments');
    n.state=scope+(args.length?symbol(args[0]):id+'_state');n.initial=args.length>1?atom(args[1]):'0';
    if(op==='param'){
     declarations.push({name:n.state,code:'Param '+n.state+'('+[n.initial,...attributes(meta,attrs)].join(', ')+');'});
    }else{inputs=['value'];histories.push(n);declarations.push({name:n.state,code:'History '+n.state+'('+n.initial+');'});}
   }else if(op==='delay'){
    if(args.length>2||Object.keys(attrs).some(k=>!['feedback','interp'].includes(k))||(attrs.feedback??'1')!=='1')fail('delay supports feedback 1');
    const maximum=args.length?Number(args[0]):defaultDelay,taps=args.length>1?Number(args[1]):1,interp=attrs.interp||'linear';
    if(!Number.isInteger(maximum)||maximum<1||maximum>44100||!Number.isInteger(taps)||taps<1||taps>8||!['none','step','linear','cosine','cubic','spline'].includes(interp))fail('invalid delay limits/interpolation');
    n.maximum=maximum;n.interp=interp;n.state=id+'_delay';n.taps=taps;
    reserve(2**Math.ceil(Math.log2(Math.max(2,maximum)))*8,id);
    declarations.push({name:n.state,code:'Delay '+n.state+'('+maximum+');'});delays.push(n);inputs=Array.from({length:taps+1},(_,i)=>i?'tap'+i:'value');outputs=taps;
    if(!args.length)changes.push({object:b.id,default_delay_samples:maximum});
   }else if(op==='data'){
    if(args.length<1||args.length>3||Object.keys(attrs).length)fail('data requires name [frames channels]');
    const frames=args.length>1?Number(args[1]):512,channels=args.length>2?Number(args[2]):1;
    if(!Number.isInteger(frames)||frames<1||!Number.isInteger(channels)||channels<1||channels>8)fail('invalid data dimensions');
    n.state=scope+symbol(args[0]);n.frames=frames;n.channels=channels;reserve(frames*channels*8,id);outputs=2;
    if(resources.has(n.state))fail('duplicate data name');resources.set(n.state,n);
    declarations.push({name:n.state,code:'Data '+n.state+'('+frames+', '+channels+');'});
   }else if(['send','receive'].includes(op)){
    if(args.length!==1||Object.keys(attrs).length)fail('send/receive requires a name');n.bus=scope+symbol(args[0]);
    if(op==='send'){if(sends.has(n.bus))fail('multiple send objects');sends.set(n.bus,id);inputs=['value'];outputs=0;}else receivers.push(n);
   }else if(['peek','sample','nearest','lookup','wave'].includes(op)){
    if(args.length<1||args.length>2||(args.length===2&&Object.hasOwn(attrs,'channels')))fail('buffer read requires name [channels]');
    const channels=Number(args[1]??attrs.channels??1),mode=attrs.index??meta.attributes.index.default;
    if(!Number.isInteger(channels)||channels<1||channels>8)fail('buffer read channels must be 1..8');
    attributes(meta,attrs);n.resource=scope+symbol(args[0]);n.read=true;outputs=channels+1;
    inputs=mode==='wave'?['wave_phase','wave_start','wave_end','channel_offset']:[mode==='samples'?'index':mode==='phase'?'phase':'signal','channel_offset'];
    n.keywords=attributes(meta,{...attrs,channels:String(channels)});
   }else if(op==='interp'){
    const mode=attrs.mode??'linear',values=['spline','cubic'].includes(mode)?['a','b','c','d']:['a','b'];
    if(args.length>values.length)fail('too many interpolation arguments');
    n.keywords=attributes(meta,attrs);n.arguments=['t',...values];n.values=new Map(args.map((v,i)=>[values[i],v]));inputs=['t',...values.slice(args.length)];
   }else if(op==='cycle'){
    if(args.length||Object.keys(attrs).some(k=>k!=='index'))fail('cycle currently supports its built-in sine table; connect frequency/phase to its inlet');
    n.keywords=attributes(meta,attrs);inputs=[attrs.index==='phase'?'phase':'freq'];n.arguments=inputs;outputs=2;
   }else if(['selector','gate'].includes(op)){
    if(args.length>1||Object.keys(attrs).some(k=>k!=='choices')||(args.length&&Object.hasOwn(attrs,'choices')))fail('invalid routing arguments');
    const choices=Number(args[0]??attrs.choices??1);if(!Number.isInteger(choices)||choices<1||choices>16)fail('routing choices must be 1..16');
    inputs=op==='gate'?['choose','input']:['choose',...Array.from({length:choices},(_,i)=>'choice'+i)];n.arguments=inputs;n.keywords=['choices='+choices];outputs=op==='gate'?choices:1;
   }else if(meta.box_expr==='constant'||meta.box_expr==='global'){
    if(op.startsWith('FFT'))fail('FFT constants require an FFT host context unavailable in the FM1 player');
    if(op.toLowerCase()==='voice')fail('voice requires a verified Gen-to-RNBO voice-index mapping');
    if(args.length||Object.keys(attrs).length)fail('constant/global takes no arguments');n.expression=op;
   }else{
    if(['buffer','FFT'].includes(meta.category)&&!['cycle','dim','channels','peek','poke','sample','nearest','lookup','wave','splat'].includes(op))fail('resource/host object '+op);
    if(!['generic','special','revop'].includes(meta.box_expr))fail('object '+op);
    const candidates=arr(meta.constructors).filter(c=>arr(c.arguments).length===args.length&&!c.constraints&&!arr(c.inlets).includes('...'));
    if(candidates.length!==1)fail('unreviewed constructor '+spelling+' '+args.join(' '));
    const ctor=candidates[0];inputs=arr(ctor.inlets);n.values=new Map();
    arr(ctor.arguments).forEach((key,i)=>n.values.set(key,args[i]));
    n.keywords=attributes(meta,attrs);n.arguments=arr(meta.arguments);
    if((!Array.isArray(meta.arguments)&&Object.keys(meta.arguments||{missing:1}).length)||n.arguments.includes('...'))fail('variable-arity object '+op);
    outputs=arr(meta.outputs).length;n.writes=['poke','splat'].includes(op);
   }
   if(nodes.size>=2048)fail('too many nodes');n.inputs=inputs;n.outputs=outputs;nodes.set(id,n);incoming.set(id,new Map());
   ports.set(b.id,{inputs:new Map(inputs.map((_,i)=>[i,[id,i]])),outputs:new Map(Array.from({length:outputs},(_,i)=>[i,[id,i]]))});
  }
  function endpoint(e,kind){const [id,index]=e||[];const v=ports.get(id)?.[kind].get(index);if(!v)fail('invalid cord endpoint');return typeof v==='string'?[v,0]:v;}
  for(const {patchline:l} of p.lines){const src=endpoint(l.source,'outputs'),[id,i]=endpoint(l.destination,'inputs');if(incoming.get(id).has(i))fail('multiple cords into an inlet');incoming.get(id).set(i,src);}
  for(const m of [ins,outs])for(let i=0;i<m.size;i++)if(!m.has(i))fail('noncontiguous ports');
  return {ins,outs};
 }
 const root=canvas(p);if(!root.outs.size)fail('no outputs');
 const names=new Set();for(const d of declarations){if(names.has(d.name))fail('duplicate state name');names.add(d.name);}
 const statements=[...functions,...declarations.map(d=>d.code)],done=new Map(),active=new Set();
 for(const n of histories){statements.push(n.id+'_0 = '+n.state+';');done.set(n.id+':0',n.id+'_0');}
 function input(n,i){
  const edge=incoming.get(n.id).get(i);if(edge)return emit(...edge);
  const key=n.inputs[i];if(n.op==='delay')return i?'1':'0';
  return atom(n.meta?.inputs?.[key]?.default??0);
 }
 function arg(n,key){
  if(n.values?.has(key)){
   const v=n.values.get(key);if(key==='name'){const resource=resources.get(n.scope+v);if(!resource)fail('unknown local data '+v);return resource.state;}
   return atom(v);
  }
  const i=n.inputs.indexOf(key);if(i>=0)return input(n,i);
  if(Object.hasOwn(n.attrs,key))return atom(n.attrs[key]);
  return atom(n.meta?.inputs?.[key]?.default??n.meta?.attributes?.[key]?.default??0);
 }
 function emit(id,port=0){
  const key=id+':'+port;if(done.has(key))return done.get(key);
  if(active.has(key))fail('feedback path without History/Delay');active.add(key);
  const n=nodes.get(id);let expression;
  if(n.op==='in')expression='in'+n.port;
  else if(n.op==='out'||n.op==='alias'||n.op==='send')expression=input(n,0);
  else if(n.op==='receive'){const send=sends.get(n.bus);if(!send)fail('receive has no send');expression=emit(send);}
  else if(n.op==='param')expression=n.state;
  else if(n.op==='data')expression=String(port?n.channels:n.frames);
  else if(n.op==='delay')expression=n.state+'.read(clamp('+input(n,port+1)+', 1, '+n.maximum+'), interp='+JSON.stringify(n.interp)+')';
  else if(n.expression)expression=n.expression;
  else if(n.op==='codebox')expression=n.function+'('+n.inputs.map((_,i)=>input(n,i)).join(', ')+')';
  else if(n.read){
   if(!resources.has(n.resource))fail('unknown local data '+n.resource);
   expression=n.op+'('+[n.resource,...n.inputs.map((_,i)=>input(n,i)),...n.keywords].join(', ')+')';
  }
  else {
   const args=n.arguments.map(k=>arg(n,k));
   if(n.meta.box_expr==='revop')args.reverse();
   expression=(n.meta.box_expr==='revop'?n.op.slice(1):n.op)+'('+[...args,...n.keywords].join(', ')+')';
  }
  const outputCount=n.op==='delay'||n.op==='data'?1:Math.max(1,n.outputs);
  const vars=Array.from({length:outputCount},(_,i)=>n.op==='out'?'out'+n.port:id+'_'+(outputCount===1?port:i));
  if(n.outputs===0&&n.op!=='out'&&n.op!=='send')statements.push(expression+';');else statements.push(vars.join(', ')+' = '+expression+';');
  vars.forEach((v,i)=>done.set(id+':'+(outputCount===1?port:i),v));active.delete(key);return done.get(key);
 }
 for(const [id,n] of nodes)if(!n.writes){if(n.op==='delay'||n.op==='data')for(let i=0;i<n.outputs;i++)emit(id,i);else emit(id);}
 const writes=[];
 for(const n of histories){const e=incoming.get(n.id).get(0);if(e)writes.push(n.state+' = fixdenorm('+emit(...e)+');');}
 for(const n of delays)writes.push(n.state+'.write('+input(n,0)+');');
 for(const [id,n] of nodes)if(n.writes)emit(id);
 statements.push(...writes);
 return {expr:statements.join('\n'),geninlets:root.ins.size,genoutlets:root.outs.size,memory:{estimated_buffer_bytes:estimatedBytes,maximum_bytes:budget,changes}};
}
module.exports={genGraph,catalogue};
