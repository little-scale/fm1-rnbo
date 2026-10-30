// SPDX-License-Identifier: MIT
// peakamp~ caches its interval for the block. Its change detector needs one
// evaluation, before the loop, rather than repeating on every sample.
function hoistPeakInterval(source){
  let count=0;
  const code=source.replace(/^void (peakamp_\d+)_perform\([^)]*\)\s*\{.*?^\}/gms,(body,name)=>{
    const detector=`number ${name}_d_next(number x) {
    number temp = (number)(x - this->${name}_d_prev);
    this->${name}_d_prev = x;
    return temp;
}`;
    if(!source.includes(detector))throw Error('Review changed '+name+' interval detector');
    const block=`        if ((bool)(this->${name}_d_next(__${name}_interval))) {
            __${name}_maxIndex = this->mstosamps(__${name}_interval);
        }`;
    const loop='    for (Index i = 0; i < n; i++) {';
    if(body.split(block).length!==2||body.split(loop).length!==2)throw Error('Review changed '+name+' peak loop');
    count++;
    return body.replace(block,'').replace(loop,block.replace('if ((bool)','if (n && (bool)')+'\n'+loop);
  });
  return {code,count};
}
module.exports={hoistPeakInterval};
