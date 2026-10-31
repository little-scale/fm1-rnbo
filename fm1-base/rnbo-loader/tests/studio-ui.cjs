// Exercise actual Studio page handlers with fake downloads and firmware transport.
const fs=require('fs'),path=require('path'),assert=require('assert');
(async()=>{
 const code=fs.readFileSync(path.join(__dirname,'../web/studio.js'),'utf8');
 const s=await import('data:text/javascript;base64,'+Buffer.from(code).toString('base64'));
 const cases=JSON.parse(fs.readFileSync(path.join(__dirname,'../hardware-tests/manifest.json'))).patches;
 const firmware=new Uint8Array(1200);firmware.set(new TextEncoder().encode('FELUCCA-LOADER-1'),1000);
 const module=new Uint8Array(1088).fill(42),source=new Uint8Array(1000);
 const asset=async(bytes,file)=>({file,bytes:bytes.length,sha256:Buffer.from(await crypto.subtle.digest('SHA-256',bytes)).toString('hex')});
 const release={format:1,version:'0.1.0',identity:'FM-1_9400',firmware:await asset(firmware,'firmware/player.fwsc'),sources:await asset(source,'sources.zip'),patches:[]};
 for(const c of cases)release.patches.push({...c,...await asset(module,'patches/'+c.id+'.rnbom'),abi:2,image_bytes:1024,state_bytes:10000});
 let badDownload=false,manifestMode='valid',midiCalls=0,installs=0,loaded=null,busy=false,controller,disconnects=0,message;
 const elements=new Map();
 function node(){return {disabled:false,hidden:false,textContent:'',value:0,files:[],children:[],replaceChildren(){this.children=[];},append(...children){this.children.push(...children);},removeAttribute(){},scrollIntoView(){}};}
 const el=id=>{if(!elements.has(id))elements.set(id,node());return elements.get(id);};
 const doc={getElementById:el,createElement:node},listeners=new Set();
 const win={addEventListener:(name,fn)=>listeners.add(fn),removeEventListener:(name,fn)=>listeners.delete(fn)};
 const host={isBusy:()=>busy,reserve(){if(busy)return false;busy=true;controller?.update({busy});return true;},release(m){message=m;busy=false;controller?.update({busy});},async loadFile(f){loaded=f;},async disconnect(){disconnects++;}};
 const response=(value,status=200)=>({ok:status===200,status,async json(){return structuredClone(value);},async arrayBuffer(){return value.slice().buffer;}});
 const request=async(url,options={})=>{
  const u=String(url);
  if(u.endsWith('/release.json'))return response(manifestMode==='valid'?release:{},manifestMode==='missing'?404:200);
  if(u.endsWith('/catalogue.json'))return response({patches:cases});
  if(u==='/api/session')return response({studio_version:1,token:'token',builder:false});
  if(u==='/api/quit'){assert.equal(options.headers['X-FM1-Token'],'token');return response({});}
  assert(u.startsWith('https://example.test/fm1-rnbo/'));
  const bytes=u.endsWith('.fwsc')?firmware:module;
  const data=bytes.slice();if(badDownload)data[0]^=1;
  return response(data);
 };
 const port=()=>({async close(){},onmidimessage:null});
 const access={inputs:new Map([['in',port()]]),outputs:new Map([['out',port()]])};
 class Updater{async resume(){return false;}async install(data,identity,onStep){assert(busy);assert(el('install-player').disabled);installs++;onStep('write',10);onStep('done');}}
 const deps={document:doc,window:win,base:'https://example.test/fm1-rnbo/',fetch:request,loadPackage:async()=>({productOf:()=> 'FM-1_9400',logicalImage:b=>b}),loadUpdater:async()=>({Updater}),midi:async()=>{midiCalls++;return access;}};
 controller=await s.setupStudio(host,deps);
 assert.equal(el('library').children.length,15);assert(!el('install-player').disabled);assert(!el('source-download').hidden);
 assert.equal(el('source-download').href,'https://example.test/fm1-rnbo/sources.zip');
 await el('library').children[14].children.at(-1).onclick();assert.equal(loaded.name,'t15_hybrid.rnbom');assert.equal(installs,0);assert.equal(midiCalls,0);assert(!busy);
 loaded=null;badDownload=true;await controller.choose(release.patches[0]);assert.equal(loaded,null);assert(message.includes('checksum'));assert(!busy);
 await controller.install();assert.equal(installs,0);assert.equal(midiCalls,0);assert.equal(disconnects,0);assert(!busy);assert.equal(listeners.size,0);
 badDownload=false;busy=true;controller.update({busy});await controller.install();assert.equal(installs,0);assert(el('library').children.every(c=>c.children.at(-1).disabled));
 busy=false;controller.update({busy});await controller.install();assert.equal(installs,1);assert.equal(midiCalls,1);assert.equal(disconnects,1);assert(message.includes('Reconnect'));assert.equal(listeners.size,0);
 el('firmware-file').files=[new File([new Uint8Array(10)],'wrong.fwsc')];await el('firmware-file').onchange();assert(el('install-player').disabled);await controller.install();assert.equal(installs,1);
 el('firmware-file').files=[new File([firmware],'player.fwsc')];await el('firmware-file').onchange();assert(!el('install-player').disabled);
 await el('stop-service').onclick();assert(message.includes('stopped'));assert.equal(disconnects,2);
 manifestMode='missing';controller=await s.setupStudio(host,deps);assert(el('install-player').disabled);assert.equal(el('library').children.length,15);assert(el('library').children.every(c=>c.children.at(-1).disabled));
 manifestMode='invalid';controller=await s.setupStudio(host,deps);assert(el('install-player').disabled);assert(el('release-status').textContent.includes('not a complete'));
 console.log('PASS Studio UI: all 15 cards, nested hosting paths, choose without upload, corrupt artifact refusal before MIDI, mutual exclusion, checked firmware file, service shutdown and source-only mode');
})().catch(e=>{console.error(e);process.exit(1)});
