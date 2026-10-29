// Test the exact browser wire/validation helpers without claiming browser MIDI QA.
const fs=require('fs'),path=require('path'),assert=require('assert');
(async()=>{
 const file=path.join(__dirname,'../web/module-loader.js');const src=fs.readFileSync(file,'utf8');
 const w=await import('data:text/javascript;base64,'+Buffer.from(src).toString('base64'));
 const bytes=Uint8Array.from({length:1024},(_,i)=>i&255);assert.deepEqual(w.unpack(w.pack(bytes)),bytes);
 assert.equal(w.crc(new TextEncoder().encode('123456789')),0xcbf43926);
 const raw=w.unpack(w.frame(0x6a,[...w.put32(1088),...w.put32(123456)]).subarray(1,-1));assert.equal(w.u32(raw,6),1088);assert.equal(w.u32(raw,10),123456);
 const im=new Uint8Array(1024);im.set([...w.put32(0x31495041),...w.put32(1),...w.put32(84),...w.put32(123)]);im.set(new TextEncoder().encode('TEST'),16);for(let i=48;i<84;i+=4)im.set(w.put32(0x1c34054),i);
 const header=[0x314d4e52,1,1,241,44100,256,0x1c34000,0x1c44000,1024,140000,w.crc(im),123,0,0,0,0];const data=new Uint8Array(1088);data.set(header.flatMap(w.put32));data.set(im,64);data.set(w.put32(w.crc(data.subarray(0,48))),48);assert.equal(w.parseModule(data).title,'TEST');
 for(const i of [0,8,32,40,48,64,112,1087]){const damaged=data.slice();damaged[i]^=1;assert.throws(()=>w.parseModule(damaged));}
 const rawModule=data.slice();rawModule.set(w.put32(2),8);rawModule.set(w.put32(2),68);rawModule.set(w.put32(w.crc(rawModule.subarray(64))),40);rawModule.set(w.put32(w.crc(rawModule.subarray(0,48))),48);assert.equal(w.parseModule(rawModule).abi,2);
 const mismatch=rawModule.slice();mismatch.set(w.put32(1),8);mismatch.set(w.put32(w.crc(mismatch.subarray(0,48))),48);assert.throws(()=>w.parseModule(mismatch));
 const unknown=rawModule.slice();unknown.set(w.put32(3),8);unknown.set(w.put32(w.crc(unknown.subarray(0,48))),48);assert.throws(()=>w.parseModule(unknown));
 const bankFrame=(active,occupied)=>w.frame(0x6d,[...w.put32(1),...w.put32(3),...w.put32(active),...w.put32(occupied)]);
 assert.deepEqual(w.parseBank(w.unpack(bankFrame(2,7).subarray(1,-1))),{version:1,count:3,active:2,occupied:7});
 for(const [active,occupied] of [[4,7],[2,1],[0,8]])assert.throws(()=>w.parseBank(w.unpack(bankFrame(active,occupied).subarray(1,-1))));
 console.log('PASS browser module parser, bank parser, CRC and SysEx helpers');
})().catch(e=>{console.error(e.message);process.exit(1)});
