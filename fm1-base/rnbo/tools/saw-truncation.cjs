// SPDX-License-Identifier: MIT
// RNBO's bandlimited saw wraps t to [0,1] on each sample. Thus t1=t+0.5
// remains in [0.5,1.5], and its integer truncation needs only 32 bits.
// Leave the oscillator, anti-alias correction and all other Int casts intact.
function narrowSawTruncation(source){
  let count=0;
  const code=source.replace(/\bvoid saw_tilde_\d+_perform\([\s\S]*?\n\}/g,body=>{
    if(!body.includes('number t1 = __saw_tilde_') || !body.includes('t1 -= trunc(t1);'))
      throw Error('Review changed RNBO saw phase wrapping before narrowing');
    count++;
    return body.replace('t1 -= trunc(t1);','t1 -= (int)(t1);');
  });
  return {code,count};
}
module.exports={narrowSawTruncation};
