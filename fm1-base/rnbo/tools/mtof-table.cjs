// SPDX-License-Identifier: MIT
// RNBO 1.4.4 emits a 65536-sample mtof table even when its generated
// conversion uses exp directly. Shrink only tables proven unread in this
// self-contained player (which has no external data-reference interface).
function compactMtofTables(source) {
  const table='RNBODefaultMtofLookupTable256';
  const bindings=[...source.matchAll(/this->(\w*(?:_innerMtoF|gen_\d+_mtof_\d+)_buffer) = new SampleBuffer\(this->RNBODefaultMtofLookupTable256\);/g)].map(m=>m[1]);
  if(!bindings.length)return {code:source,count:0};
  const esc=s=>s.replace(/[.*+?^${}()|[\]\\]/g,'\\$&');
  for(const buffer of bindings){
    const b=esc(buffer);
    const allowed=[
      new RegExp(`^this->${b} = new SampleBuffer\\(this->${table}\\);$`),
      new RegExp(`^this->${b} = reInitDataView\\(this->${b}, this->${table}\\);$`),
      new RegExp(`^this->${b}->requestSize\\(65536, 1\\);$`),
      new RegExp(`^this->${b}->setSampleRate\\(this->sr\\);$`),
      new RegExp(`^this->${b} = this->${b}->allocateIfNeeded\\(\\);$`),
      new RegExp(`^SampleBufferRef ${b};$`)
    ];
    if(source.split('\n').filter(l=>new RegExp(`\\b${b}\\b`).test(l)).some(l=>!allowed.some(r=>r.test(l.trim()))))return {code:source,count:0};
  }
  const bound=bindings.map(esc).join('|');
  const permitted=[
    new RegExp(`^return addressOf\\(this->${table}\\);$`),
    new RegExp(`^this->(?:${bound}) = (?:new SampleBuffer\\(this->${table}\\)|reInitDataView\\(this->(?:${bound}), this->${table}\\));$`),
    new RegExp(`^this->${table} = initDataRef\\($`),
    new RegExp(`^this->${table},$`),
    new RegExp(`^this->${table}->setIndex\\(\\d+\\);$`),
    new RegExp(`^if \\(this->${table}->(?:hasRequestedSize|wantsFill)\\(\\)\\)(?: \\{)?$`),
    new RegExp(`^this->fill${table}\\(this->${table}\\);$`)
  ];
  if(source.split('\n').filter(l=>l.includes('this->'+table)).some(l=>!permitted.some(r=>r.test(l.trim()))))return {code:source,count:0};
  let count=0;
  const code=source.replace(new RegExp(`(this->(?:${bound})->requestSize\\()65536(, 1\\);)`,'g'),(_,a,b)=>{count++;return a+'2'+b;});
  return {code,count};
}
module.exports={compactMtofTables};
