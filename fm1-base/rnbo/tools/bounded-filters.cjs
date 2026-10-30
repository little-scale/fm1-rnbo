// SPDX-License-Identifier: MIT
// RNBO 1.4.4 comb~/allpass~ rings. Automatic bounds require a compiler-folded
// constant delay; otherwise the caller must explicitly choose a maximum.
function boundedFilters(source,maximumMs=null,inferredMaximum=false){
  if(maximumMs!==null && (!Number.isFinite(maximumMs)||maximumMs<=0||maximumMs>1000))throw Error('Filter delay maximum must be > 0 and <= 1000 ms');
  const changes=[];let code=source;
  const methods=[...source.matchAll(/^void ((?:allpass|comb)_tilde_\d+)_perform\([^)]*\)\s*\{.*?^\}/gms)];
  for(const match of methods){
    const name=match[1],body=match[0];
    const literal=name.startsWith('allpass')?body.match(/this->mstosamps\((\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)[fF]?\)/):body.match(/number __delayTime = (\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)[fF]?;/);
    const fixed=body.includes('RNBO_UNUSED(delayTime);')&&literal?Number(literal[1]):null;
    if(fixed===null && maximumMs===null)continue;
    const constant=fixed!==null&&(maximumMs===null||inferredMaximum||fixed<=maximumMs);
    const maxMs=constant?Math.min(1000,Math.max(fixed,1/44.1)):maximumMs;
    // Keep the original read delay for a fixed source; a couple of samples
    // cover float rounding. Explicit caps define the new maximum read delay.
    const samples=constant||inferredMaximum?Math.ceil(maxMs*44.1)+2:Math.max(2,Math.ceil(maxMs*44.1));
    const frames=2**Math.ceil(Math.log2(samples));
    let prepared=body.replace(/this->mstosamps\((__delayTime|delayTime(?:\[\(Index\)i\])?|\d+(?:\.\d+)?(?:[eE][+-]?\d+)?[fF]?)\)/g,(_,arg)=>{
      let value='static_cast<number>('+arg+')';
      if(maximumMs!==null&&!inferredMaximum){
        const cap=Number.isInteger(maximumMs)?maximumMs+'.0f':maximumMs+'f';
        value='('+value+' > '+cap+' ? '+cap+' : '+value+')';
      }
      return '('+value+' * 44100.0f * 0.001f)';
    });
    if(prepared===body || prepared.includes('this->mstosamps('))throw Error('Review changed '+name+' delay conversion');
    code=code.replace(body,prepared);
    for(const side of ['feedForward','feedBack']){
      const prefix=name+'_'+side;
      const size=new RegExp('(number '+prefix+'_evaluateSizeExpr\\([^)]*\\)\\s*\\{[\\s\\S]*?return )44100(;\\n\\})');
      if(!size.test(code))throw Error('Review changed '+prefix+' size expression');
      code=code.replace(size,(_,a,b)=>a+samples+b);
      const ctor='new Float64Buffer(this->'+prefix+'_bufferobj)';
      const ref='Float64BufferRef '+prefix+'_buffer;';
      if(code.split(ctor).length!==2||code.split(ref).length!==2)throw Error('Review changed '+prefix+' buffer declarations');
      code=code.replace(ctor,'new Float32Buffer(this->'+prefix+'_bufferobj)').replace(ref,'Float32BufferRef '+prefix+'_buffer;');
      const read=new RegExp('number '+prefix+'_read\\([^)]*\\)\\s*\\{[\\s\\S]*?^\\}','m');
      code=code.replace(read,b=>b.replace(/Int index1 = \(Int\)\(rnbo_floor\(r\)\);/g,'Int index1 = (Int)(int)(rnbo_floor(r));'));
    }
    changes.push({object:name,mode:constant?'inferred constant':inferredMaximum?'declared parameter range':'explicit maximum',maximum_ms:maxMs,maximum_samples:samples,frames_per_buffer:frames,buffer_count:2,buffer_data_bytes:frames*4*2});
  }
  return {code,changes};
}
// Only direct, unwired-at-input host parameters have a proven range here.
// Arithmetic, signal modulation and subpatch inputs require an explicit cap.
function parameterMaximum(patcher,xam){
  let maximum=0,seen=false,unknown=false;
  function visit(p){
    const boxes=new Map(p.boxes.map(e=>[e.box.id,e.box]));
    const inputs=id=>p.lines.filter(e=>e.patchline.destination[0]===id).map(e=>e.patchline);
    for(const {box} of p.boxes){
      if(box.patcher)visit(box.patcher);
      if(!/^(?:allpass|comb)~(?:\s|$)/.test(box.text||''))continue;
      const target=xam.parseBoxText(box.text),attr=target.attributes;
      xam.parseExtraAttributes(target.xamclass,box.rnbo_extra_attributes,attr);
      const wires=inputs(box.id).filter(w=>w.destination[1]===1);
      if(!wires.length){
        const time=attr.delayTime===undefined?0:attr.delayTime;
        if(typeof time!=='number'||!Number.isFinite(time)){unknown=true;continue;}
        maximum=Math.max(maximum,time);continue;
      }
      if(wires.length!==1||wires[0].source[1]!==0){unknown=true;continue;}
      const source=boxes.get(wires[0].source[0]);
      if(!source||!/^param~?(?:\s|$)/.test(source.text||'')||inputs(source.id).length){unknown=true;continue;}
      const spec=xam.parseBoxText(source.text);xam.parseExtraAttributes(spec.xamclass,source.rnbo_extra_attributes,spec.attributes);
      const a=spec.attributes;
      // Enum finalization replaces numeric min/max with the label index range.
      if(a.enum!==undefined){unknown=true;continue;}
      if(typeof a.min!=='number'||typeof a.max!=='number'||!Number.isFinite(a.min)||!Number.isFinite(a.max)||a.max<a.min){unknown=true;continue;}
      maximum=Math.max(maximum,a.max);seen=true;
    }
  }
  visit(patcher);
  return seen&&!unknown&&Number.isFinite(maximum)?Math.min(1000,Math.max(maximum,1/44.1)):null;
}
module.exports={boundedFilters,parameterMaximum};
