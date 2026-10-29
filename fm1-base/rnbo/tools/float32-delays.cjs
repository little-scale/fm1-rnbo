// Use float32 storage for generated RNBO delay~ buffers on the FM1.
// Keep other double buffers unchanged, and check constructor/ref pairs.
function float32Delays(source){
  const created=new Set(),declared=new Set();
  let code=source.replace(/\bnew Float64Buffer\(this->(delaytilde_\d+_del_buffer)obj\)/g,(_,name)=>{
    created.add(name);return 'new Float32Buffer(this->'+name+'obj)';
  });
  code=code.replace(/\bFloat64BufferRef (delaytilde_\d+_del_buffer)\b/g,(_,name)=>{
    declared.add(name);return 'Float32BufferRef '+name;
  });
  if(created.size===0 || created.size!==declared.size || [...created].some(n=>!declared.has(n)))
    throw Error('Review RNBO delay buffer declarations before float32 adaptation');
  return {code,count:created.size};
}
module.exports={float32Delays};
