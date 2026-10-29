// Actual page handlers with fake Web MIDI and build HTTP responses.
const fs=require('fs'),path=require('path'),assert=require('assert');
(async()=>{
 const src=fs.readFileSync(path.join(__dirname,'../web/module-loader.js'),'utf8');
 const code='data:text/javascript;base64,'+Buffer.from(src).toString('base64');
 const w=await import(code);
 const data=new Uint8Array(1088),im=data.subarray(64);
 im.set([...w.put32(0x31495041),...w.put32(1),...w.put32(84),...w.put32(123)]);im.set(new TextEncoder().encode('TEST'),16);
 for(let i=48;i<84;i+=4)im.set(w.put32(0x1c34054),i);
 data.set([0x314d4e52,1,1,241,44100,256,0x1c34000,0x1c44000,1024,140000,w.crc(im),123,0,0,0,0].flatMap(w.put32));data.set(w.put32(w.crc(data.subarray(0,48))),48);
 const mono=fs.readFileSync(path.join(__dirname,'../patches/mono.rnbopat'),'utf8');
 const echo=fs.readFileSync(path.join(__dirname,'../patches/fm4echo.rnbopat'),'utf8');
 assert.equal(w.inspectSource(echo).embeddedVoices,4);assert.equal(w.inspectSource(mono).embeddedVoices,0);
 assert.throws(()=>w.inspectSource('{}'));assert.throws(()=>w.inspectSource('{broken'));
 const elements=new Map();
 function el(id){if(!elements.has(id))elements.set(id,{disabled:false,hidden:false,textContent:'',value:'',options:[],files:[],attributes:{},setAttribute(k,v){this.attributes[k]=v;},removeAttribute(k){delete this.attributes[k];},replaceChildren(){this.options=[];this.value='';},add(o){this.options.push(o);if(!this.value)this.value=o.value;}});return elements.get(id);}
 const sent=[],requests=[],remembered=new Map();let buildMode='success',pendingJob;
 const input={id:'in',name:'FM1',state:'connected',async open(){}};
 const output={name:'FM1',state:'connected',async open(){},send(b){sent.push(Uint8Array.from(b));}};
 const access={inputs:new Map([[input.id,input]]),outputs:new Map([['out',output]])};
 const oldNav=Object.getOwnPropertyDescriptor(globalThis,'navigator'),oldFetch=globalThis.fetch,oldSet=globalThis.setTimeout,oldClear=globalThis.clearTimeout;
 const timers=new Map();let serial=0;
 const response=json=>({ok:true,async json(){return json;}});
 try{
  globalThis.document={getElementById:el};globalThis.Option=class{constructor(text,value){this.text=text;this.value=value;}};
  globalThis.localStorage={getItem:k=>remembered.get(k),setItem:(k,v)=>remembered.set(k,v)};
  Object.defineProperty(globalThis,'navigator',{configurable:true,value:{async requestMIDIAccess(o){assert(o.sysex);return access;}}});
  globalThis.setTimeout=(fn,ms)=>{timers.set(++serial,{fn,ms});return serial;};globalThis.clearTimeout=id=>timers.delete(id);
  globalThis.fetch=async(url,options={})=>{
   requests.push([url,options]);if(url==='/api/session')return response({version:2,token:'test-token',builder:true});
   assert.equal(options.headers['X-FM1-Token'],'test-token');
   if(url==='/api/build')return response({id:'testjob'});
   if(url.endsWith('/module'))return {ok:true,async arrayBuffer(){const bytes=data.slice();if(buildMode==='corrupt')bytes[100]^=1;return bytes.buffer;}};
   if(buildMode==='wait')await new Promise(resolve=>pendingJob=resolve);
   return response(buildMode==='fail'?{state:'failed',error:'Patch exceeds memory',stage:'checking',log:'Too large'}:{state:'succeeded',stage:'validating',log:'All checks passed'});
  };
  await import(code+'#flow');await Promise.resolve();await Promise.resolve();
  assert(el('upload').disabled && el('slot1').disabled);
  async function connect(bank=true){
   input.state='connected';await el('ports').onclick();await el('connect').onclick();
   const identity=[...new TextEncoder().encode('FM-1_9400')];input.onmidimessage({data:w.frame(0x11,[...identity,...Array(27-identity.length).fill(0)])});
   input.onmidimessage({data:status(0x69)});
   if(bank)input.onmidimessage({data:bankFrame(1,1)});
   else {const t=[...timers.values()].find(t=>t.ms===1200);assert(t);t.fn();}
  }
  const status=cmd=>w.frame(cmd,[...w.put32(0),...w.put32(123),...w.put32(10),...w.put32(0),...w.put32(2),...w.put32(600),...w.put32(1234)]);
  const bankFrame=(active,mask)=>w.frame(0x6d,[...w.put32(1),...w.put32(3),...w.put32(active),...w.put32(mask)]);
  async function choose(name,bytes){el('file').files=[{name,size:bytes.length,async arrayBuffer(){return Uint8Array.from(bytes).buffer;}}];await el('file').onchange();}
  const decode=b=>w.unpack(b.subarray(1,-1));
  await connect();assert(!el('slot3').disabled);await choose('test.rnbom',data);el('slot3').onclick();el('upload').onclick();
  assert.equal(decode(sent.at(-1))[2],0x6e);assert.equal(w.u32(decode(sent.at(-1)),14),3);assert(el('file').disabled);
  input.onmidimessage({data:w.frame(0x30,[0,...w.put32(0),0,2,0])});assert.deepEqual(decode(sent.at(-1)).subarray(14,-1),data.subarray(0,512));
  input.onmidimessage({data:status(0x6b)});assert.equal(decode(sent.at(-1))[2],0x6c);input.onmidimessage({data:bankFrame(3,5)});assert(el('log').textContent.includes('active in slot 3'));
  // Legacy firmware is identified by a valid status reply and no bank reply.
  await connect(false);assert(el('slot-options').hidden);await choose('new_synth.rnbopat',new TextEncoder().encode(mono));
  el('voices').value='2';el('voices').onchange();assert.equal(el('upload').textContent,'Build & Upload');assert(!el('build').disabled);
  await el('upload').onclick();
  const posted=JSON.parse(requests.find(([url])=>url==='/api/build')[1].body);assert.equal(posted.voices,2);assert.equal(posted.name,'new_synth.rnbopat');
  assert.equal(decode(sent.at(-1))[2],0x6a);input.onmidimessage({data:status(0x6b)});assert(el('log').textContent.includes('Ready to play'));
  assert(!el('download').hidden);assert.equal(remembered.get('fm1-voices:new_synth.rnbopat'),'2');
  // Build-only needs no MIDI connection, remembers voices, and does not upload.
  input.state='disconnected';access.onstatechange();await choose('new_synth.rnbopat',new TextEncoder().encode(mono));assert.equal(el('voices').value,'2');
  let count=sent.length;await el('build').onclick();assert.equal(sent.length,count);assert(el('log').textContent.includes('Build passed'));assert(el('upload').disabled);
  // Embedded polyphony is respected and cannot accidentally multiply the master effect.
  await choose('fm4echo.rnbopat',new TextEncoder().encode(echo));assert.equal(el('voices').value,'4');assert(el('voices').disabled);
  buildMode='fail';count=sent.length;await el('build').onclick();assert.equal(sent.length,count);assert(el('log').textContent.includes('exceeds memory'));assert(el('download').hidden);
  buildMode='corrupt';await el('build').onclick();assert(el('log').textContent.includes('integrity'));assert(el('download').hidden);
  // Disconnect while compiling must leave a downloadable result, never send it automatically.
  await connect(false);await choose('new_synth.rnbopat',new TextEncoder().encode(mono));buildMode='wait';count=sent.length;
  const build=el('upload').onclick();for(let i=0;i<20&&!pendingJob;i++)await Promise.resolve();assert(pendingJob);
  input.state='disconnected';access.onstatechange();buildMode='success';pendingJob();await build;
  assert.equal(sent.length,count);assert(el('log').textContent.includes('Reconnect'));assert(!el('download').hidden);assert(el('upload').disabled);
  assert.equal(timers.size,0);
 }finally{
  delete globalThis.document;delete globalThis.Option;delete globalThis.localStorage;
  if(oldNav)Object.defineProperty(globalThis,'navigator',oldNav);else delete globalThis.navigator;
  globalThis.fetch=oldFetch;globalThis.setTimeout=oldSet;globalThis.clearTimeout=oldClear;
 }
 console.log('PASS browser flow: three-slot and legacy firmware, source build/upload, voice memory, embedded effects, offline build, failure/corruption and disconnect during build');
})().catch(e=>{console.error(e.message);process.exit(1)});
