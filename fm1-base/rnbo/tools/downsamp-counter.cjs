// SPDX-License-Identifier: MIT
// A fixed positive integral factor bounds the sample counter to [0,factor].
// Keep dynamic/nonintegral factors and unexpected generated layouts untouched.
function narrowDownsampleCounter(source){
  const changes=[];let code=source;
  for(const match of source.matchAll(/^void (downsamp_tilde_\d+)_perform\([^)]*\)\s*\{.*?^\}/gms)){
    const body=match[0],name=match[1];
    if(!body.includes('RNBO_UNUSED(downSample);'))continue;
    const constant=body.match(/if \((\d+) != __\w+_lastDownSample\)/);
    if(!constant)continue;
    const factor=Number(constant[1]);if(factor<1||factor>1048576)continue;
    const member=name+'_current',local='__'+member,last='__'+name+'_lastDownSample';
    const declaration='Int '+member+';';
    const reset=member+' = 0;';
    if(source.split(declaration).length!==2||source.split(reset).length!==2)throw Error('Review changed downsample counter storage');
    // Exactly four references: declaration, zero initialization, read and write.
    if([...source.matchAll(new RegExp('\\b'+member+'\\b','g'))].length!==4)throw Error('Review additional downsample counter access');
    const statements=[
      `if (${factor} != ${last}) {`,
      `${last} = this->maximum(1.0, rnbo_abs(${factor}));`,
      `if (${last} < ${local}) {`,`${local} = ${last};`,
      `${local}++;`,`if (${local} >= ${last}) {`,`${local} -= ${last};`
    ];
    if(!statements.every(s=>body.includes(s)))throw Error('Review changed downsample counter loop');
    code=code.replace(declaration,'int '+member+';');changes.push({object:name,fixed_factor:factor});
  }
  return {code,changes};
}
module.exports={narrowDownsampleCounter};
