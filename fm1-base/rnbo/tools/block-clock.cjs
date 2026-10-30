// SPDX-License-Identifier: MIT
// These RNBO methods schedule their notifications at the end of the fixed
// block. Current patcher time is invariant during their sample loop. Retain
// double precision but calculate the identical timestamp once per block.
function hoistBlockClock(source){
  let count=0;
  const expression='this->sampsToMs((SampleIndex)(256)) + this->_currentTime';
  const code=source.replace(/^void (?:snapshot_\d+|peakamp_\d+|linetilde_\d+)_perform\([^)]*\)\s*\{.*?^\}/gms,body=>{
    if(!body.includes(expression))return body;
    count++;
    const replaced=body.split(expression).join('fm1_block_end_time');
    const start=replaced.indexOf('{')+1;
    return replaced.slice(0,start)+'\n    const MillisecondTime fm1_block_end_time = '+expression+';'+replaced.slice(start);
  });
  return {code,count};
}
module.exports={hoistBlockClock};
