// SPDX-License-Identifier: MIT
const assert=require('node:assert'),fs=require('node:fs');
const {boundedFilters,parameterMaximum}=require('../../rnbo/tools/bounded-filters.cjs');
const source=fs.readFileSync(process.argv[2],'utf8');
const a=boundedFilters(source);assert.equal(a.changes.length,1);assert.equal(a.changes[0].buffer_data_bytes,8192);
assert(a.code.includes('Float32BufferRef allpass_tilde_01_feedForward_buffer'));
for(const cap of [0,-1,NaN,Infinity,1001])assert.throws(()=>boundedFilters(source,cap));
assert.throws(()=>boundedFilters(source.replace(/return 44100;/g,'return 48000;')));
const unknown=source.replace('RNBO_UNUSED(delayTime);','');
assert.equal(boundedFilters(unknown).code,unknown);
assert.equal(boundedFilters(unknown,32).changes[0].mode,'explicit maximum');
assert.equal(boundedFilters(source,8,true).changes[0].maximum_ms,16);
assert.equal(boundedFilters(source,8,false).changes[0].maximum_ms,8);
assert.equal(boundedFilters('void untouched() {}').changes.length,0);
const specs={
  'allpass~ 16 0.5':{xamclass:'allpass~',attributes:{delayTime:16}},
  'param time 16 @min 0 @max 32':{xamclass:'param',attributes:{min:0,max:32}},
  'param unknown':{xamclass:'param',attributes:{}},
  'param enum':{xamclass:'param',attributes:{min:0,max:1,enum:['a','b','c']}}
};
const xam={parseBoxText:t=>structuredClone(specs[t]),parseExtraAttributes:()=>{}};
const box=(id,text)=>({box:{id,text}}),wire=(a,b,inlet=1,outlet=0)=>({patchline:{source:[a,outlet],destination:[b,inlet]}});
const p={boxes:[box('p','param time 16 @min 0 @max 32'),box('f','allpass~ 16 0.5')],lines:[wire('p','f')]};
assert.equal(parameterMaximum(p,xam),32);
const changed=structuredClone(p);changed.boxes[0].box.text='param unknown';assert.equal(parameterMaximum(changed,xam),null);
const enumerated=structuredClone(p);enumerated.boxes[0].box.text='param enum';assert.equal(parameterMaximum(enumerated,xam),null);
const driven=structuredClone(p);driven.lines.push(wire('driver','p',0));assert.equal(parameterMaximum(driven,xam),null);
const outlet=structuredClone(p);outlet.lines[0]=wire('p','f',1,1);assert.equal(parameterMaximum(outlet,xam),null);
const mixed=structuredClone(p);mixed.lines.push(wire('other','f'));assert.equal(parameterMaximum(mixed,xam),null);
console.log('PASS constant/range bounds, explicit caps, unchanged unknown sources, and malformed-layout rejection');
