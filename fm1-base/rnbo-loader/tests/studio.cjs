// Production release checks and updater orchestration; no physical MIDI device.
const fs=require('fs'),path=require('path'),assert=require('assert');
(async()=>{
 const code=fs.readFileSync(path.join(__dirname,'../web/studio.js'),'utf8');
 const s=await import('data:text/javascript;base64,'+Buffer.from(code).toString('base64'));
 const cases=JSON.parse(fs.readFileSync(path.join(__dirname,'../hardware-tests/manifest.json'))).patches;
 const hash='a'.repeat(64),entry={bytes:1088,sha256:hash,image_bytes:1024,state_bytes:1000,abi:2};
 const release={format:1,version:'0.1.0',identity:'FM-1_9400',firmware:{file:'firmware/player.fwsc',bytes:1200,sha256:hash},sources:{file:'sources.zip',bytes:1000,sha256:hash},
  patches:cases.map(c=>({...c,...entry,file:'patches/'+c.id+'.rnbom'}))};
 assert.equal(s.validateRelease(release),release);
 for(const change of [m=>m.patches.pop(),m=>m.patches[1].id=m.patches[0].id,m=>m.patches[0].file='patches/../../secret.rnbom',m=>m.patches[0].state_bytes=180225,m=>m.firmware.file='https://other.test/image.fwsc',m=>m.identity='FM-1_015']){
  const bad=structuredClone(release);change(bad);assert.throws(()=>s.validateRelease(bad));
 }
 assert.equal(s.assetURL('patches/test.rnbom','https://example.test/fm1-rnbo/'),'https://example.test/fm1-rnbo/patches/test.rnbom');
 for(const file of ['../secret.txt','/patches/test.rnbom','patches/%2e%2e/test.rnbom','//other.test/x.rnbom'])assert.throws(()=>s.assetURL(file,'https://example.test/app/'));
 const bytes=new TextEncoder().encode('reviewed bytes'),sha=Buffer.from(await crypto.subtle.digest('SHA-256',bytes)).toString('hex');
 await s.verifyBytes(bytes,{bytes:bytes.length,sha256:sha});
 await assert.rejects(()=>s.verifyBytes(bytes,{bytes:bytes.length,sha256:hash}),/checksum/);
 await assert.rejects(()=>s.verifyBytes(bytes,{bytes:bytes.length+1,sha256:sha}),/size/);
 const image=new Uint8Array(1200);image.set(new TextEncoder().encode('FELUCCA-LOADER-1'),1000);
 const state={resume:false,back:true,fail:false},calls=[],steps=[];
 const port=()=>({onmidimessage:()=>{},async close(){calls.push('close');}});
 const access={inputs:new Map([['in',port()]]),outputs:new Map([['out',port()]])};
 class Updater{
  constructor(a){assert.equal(a,access);}
  async resume(){calls.push('resume');return state.resume;}
  async install(data,identity,step){calls.push('install');assert.equal(identity,'FM-1_9400');if(state.fail)throw Error('Disconnected during write');step('done');}
  async waitFor(filter){assert(filter({text:'FM-1_9400'}));assert(!filter({text:'FM-1_015'}));return state.back?{link:{close(){calls.push('link-close');}}}:null;}
 }
 const options={access,Updater,productOf:()=> 'FM-1_9400',logicalImage:b=>b,onStep:step=>steps.push(step)};
 await s.installFirmware(image,options);assert(calls.includes('install'));assert.equal(calls.filter(x=>x==='close').length,2);
 calls.length=0;state.resume=true;await s.installFirmware(image,options);assert(!calls.includes('install'));assert(calls.includes('link-close'));assert(steps.includes('reboot'));
 state.back=false;await assert.rejects(()=>s.installFirmware(image,options),/did not reconnect/);
 state.resume=false;state.fail=true;await assert.rejects(()=>s.installFirmware(image,options),/Disconnected/);assert.equal(access.inputs.get('in').onmidimessage,null);
 calls.length=0;await assert.rejects(()=>s.installFirmware(new Uint8Array(1200),options),/no update loader/);assert.equal(calls.length,0);
 await assert.rejects(()=>s.installFirmware(image,{...options,productOf:()=> 'FM-1_015'}),/RNBO Player image/);
 console.log('PASS Studio: complete library, subdirectory asset paths, bounds/checksums, firmware identity/loader, normal/resumed update, reconnect verification and cleanup');
})().catch(e=>{console.error(e);process.exit(1)});
