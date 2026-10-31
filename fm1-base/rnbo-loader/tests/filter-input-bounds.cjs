// SPDX-License-Identifier: MIT
const assert=require('node:assert/strict'),fs=require('node:fs');
const {parameterMaximum}=require('../../rnbo/tools/bounded-filters.cjs');
const xam={parseBoxText(text){
  if(/^comb~/.test(text))return {xamclass:'comb~',attributes:{delayTime:Number(text.split(/\s+/)[1])}};
  throw Error('Unexpected constructor in this bounds fixture: '+text);
},parseExtraAttributes(){}};
const box=(id,text)=>({box:{id,text}}),wire=(a,b,inlet=0,outlet=0)=>({patchline:{source:[a,outlet],destination:[b,inlet]}});
const graph={boxes:[box('lfo','cycle~'),box('bounds','clip~ 10 40'),box('comb','comb~ 20')],lines:[wire('lfo','bounds'),wire('bounds','comb',1)]};
assert.equal(parameterMaximum(graph,xam),40);
for(const text of ['clip~ 10 3e1','clip~ 0. 30.0','clip~ +10 30']){
  const p=structuredClone(graph);p.boxes[1].box.text=text;assert.equal(parameterMaximum(p,xam),30);
}
for(const text of ['scale~ -1 1 10 40','clip~ -1 40','clip~ 40 10','clip~ 0 0','clip~ 10 1001','clip~ 10 Infinity','clip~ 10 1e999','clip~ 10 40 @max 100']){
  const p=structuredClone(graph);p.boxes[1].box.text=text;assert.equal(parameterMaximum(p,xam),null);
}
for(const inlet of [1,2]){
  const p=structuredClone(graph);p.lines.push(wire('other','bounds',inlet));assert.equal(parameterMaximum(p,xam),null);
}
const saved=structuredClone(graph);saved.boxes[1].box.rnbo_extra_attributes={max:100};assert.equal(parameterMaximum(saved,xam),null);
const mismatch=structuredClone(graph);mismatch.boxes[1].box.rnbo_classname='scale~';assert.equal(parameterMaximum(mismatch,xam),null);
const mixed=structuredClone(graph);mixed.lines.push(wire('other','comb',1));assert.equal(parameterMaximum(mixed,xam),null);
const parameterGraph={boxes:[box('p','param time'),box('comb','comb~ 20')],lines:[wire('p','comb',1)]};
for(const range of [{min:-1,max:40},{min:0,max:1001},{min:0,max:Infinity},{min:40,max:10}]){
 const parser={parseBoxText:text=>text==='param time'?{xamclass:'param',attributes:range}:xam.parseBoxText(text),parseExtraAttributes(){}};
 assert.equal(parameterMaximum(parameterGraph,parser),null);
}
if(process.argv[2]&&process.argv[3]){
  const original=JSON.parse(fs.readFileSync(process.argv[2],'utf8')).patcher;
  const updated=JSON.parse(fs.readFileSync(process.argv[3],'utf8')).patcher;
  assert.equal(parameterMaximum(original,xam),null);assert.equal(parameterMaximum(updated,xam),40);
}
console.log('PASS literal clip bounds, dynamic limits/overrides rejected, malformed constructors rejected, and optional saws3 graph inference');
