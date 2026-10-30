// SPDX-License-Identifier: MIT
// Preserve fixed positive averaging windows without a one-second history.
// Samples written by these operators are already float32 RNBO numbers.
function boundedAverages(source){
  let code=source;const changes=[];
  for(const match of source.matchAll(/^void (average(?:_rms)?_tilde_\d+)_perform\([^)]*\)\s*\{.*?^\}/gms)){
    const name=match[1],body=match[0],rms=name.startsWith('average_rms_'),prefix=name+(rms?'_av':'');
    if(!body.includes('RNBO_UNUSED(windowSize);'))continue;
    const number='(\\d+(?:\\.\\d+)?)[fF]?';
    const pattern=rms?new RegExp('this->'+prefix+'_next\\([^;\\n]*,\\s*'+number+',\\s*[^)]*\\)'):new RegExp('this->'+prefix+'_setwindowsize\\('+number+'\\)');
    const value=body.match(pattern);if(!value)continue;
    const window=Math.trunc(Number(value[1]));
    if(!Number.isFinite(window)||window<1||window>44100)continue;
    const ctor='new Float64Buffer(this->'+prefix+'_bufferobj)',ref='Float64BufferRef '+prefix+'_buffer;';
    if(code.split(ctor).length!==2||code.split(ref).length!==2)throw Error('Review changed '+prefix+' buffer declarations');
    const request='this->'+prefix+'_buffer->requestSize(this->sr + 1, 1);';
    if(code.split(request).length!==2)throw Error('Review changed '+prefix+' history allocation');
    code=code.replace(ctor,'new Float32Buffer(this->'+prefix+'_bufferobj)').replace(ref,'Float32BufferRef '+prefix+'_buffer;');
    code=code.replace(request,'this->'+prefix+'_buffer->requestSize('+String(window+1)+', 1);');
    const setup=new RegExp('void '+prefix+'_dspsetup\\([^)]*\\)\\s*\\{[\\s\\S]*?^\\}','m');
    code=code.replace(setup,b=>b.replace(new RegExp('(?:this->sr|44100) > this->'+prefix+'_buffer->getSize\\(\\)'),window+' > this->'+prefix+'_buffer->getSize()').replace(/->setSize\((?:this->sr|44100) \+ 1\)/g,'->setSize('+String(window+1)+')'));
    // The ring position and fixed window fit in 32 bits. Retain the original
    // state types, but avoid a float-to-int64 conversion on ring wrap.
    code=code.replace('this->'+prefix+'_bufferPos -= bufferSize;','this->'+prefix+'_bufferPos -= (Int)(int)bufferSize;');
    const setter=new RegExp('void '+prefix+'_setwindowsize\\([^)]*\\)\\s*\\{[\\s\\S]*?^\\}','m');
    code=code.replace(setter,b=>b.replace('wsize = trunc(wsize);','wsize = (int)wsize;'));
    changes.push({object:name,window_samples:window,frames:window+1,buffer_data_bytes:(window+1)*4});
  }
  return {code,changes};
}
module.exports={boundedAverages};
