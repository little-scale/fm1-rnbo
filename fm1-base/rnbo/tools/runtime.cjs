// Reproducible portability adaptations to the exported runtime, never to the
// installed RNBO package. Keep the original header and all upstream notices.
const fs=require('node:fs');
const path=require('node:path');
const crypto=require('node:crypto');
function prepareRuntime(out,options={}){
  const file=path.join(out,'common/RNBO_Std.h');
  const original=fs.readFileSync(file,'utf8');
  const start=original.indexOf('// size_t\n');
  const end=original.indexOf('\n\n#ifndef SIZE_MAX',start);
  if(start<0 || end<0 || !original.slice(start,end).includes('using size_t = unsigned int;')){
    throw Error('RNBO_Std.h typedef layout changed; review the compiler ABI adaptation');
  }
  const block=original.slice(start,end);
  const adapted=original.slice(0,start)+
    '// FM1 portability adaptation: compiler-defined types take precedence.\n'+
    '// pi32v2 has 32-bit unsigned-long size_t, unlike RNBO\'s generic fallback.\n'+
    '#if defined(__SIZE_TYPE__) && defined(__INTPTR_TYPE__)\n'+
    'using size_t = __SIZE_TYPE__;\nusing intptr_t = __INTPTR_TYPE__;\n'+
    '#else\n'+block+'\n#endif // compiler-defined ABI types\n'+original.slice(end);
  const originals=path.join(out,'originals');fs.mkdirSync(originals,{recursive:true});
  fs.writeFileSync(path.join(originals,'RNBO_Std.h'),original);
  fs.writeFileSync(file,adapted);
  const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
  const changes=[{file:'common/RNBO_Std.h',original:'originals/RNBO_Std.h',
    original_sha256:hash(original),prepared_sha256:hash(adapted),
    reason:'Use compiler size_t/intptr_t instead of assuming every 32-bit target uses unsigned int/int.'}];
  // A signal plus an integer constant selects the generic atan2<T,U>
  // overload, which otherwise promotes float32 DSP to software double math.
  const mathFile=path.join(out,'common/RNBO_Math.h');
  const mathOriginal=fs.readFileSync(mathFile,'utf8');
  const atan='template <typename T, typename U> inline RNBO::number rnbo_atan2(T y, U x) { return ::atan2(y, x); }';
  if(mathOriginal.split(atan).length!==2)throw Error('Review changed RNBO atan2 overload');
  let mathPrepared=mathOriginal.replace(atan,`template <typename T, typename U> inline RNBO::number rnbo_atan2(T y, U x) {
#ifdef RNBO_USE_FLOAT32
    return ::atan2f(static_cast<float>(y), static_cast<float>(x));
#else
    return ::atan2(y, x);
#endif
  }`);
  for(const [name,signature,call,floatCall] of [
    ['pow','typename T, typename U','T x, U y','static_cast<float>(x), static_cast<float>(y)'],
    ['floor','typename T','T x','static_cast<float>(x)']
  ]){
    const args=name==='pow'?'x, y':'x';
    const needle=`template <${signature}> inline RNBO::number rnbo_${name}(${call}) { return ::${name}(${args}); }`;
    if(mathPrepared.split(needle).length!==2)throw Error('Review changed RNBO '+name+' overload');
    mathPrepared=mathPrepared.replace(needle,`template <${signature}> inline RNBO::number rnbo_${name}(${call}) {
#ifdef RNBO_USE_FLOAT32
    return ::${name}f(${floatCall});
#else
    return ::${name}(${args});
#endif
  }`);
  }
  fs.writeFileSync(path.join(originals,'RNBO_Math.h'),mathOriginal);
  fs.writeFileSync(mathFile,mathPrepared);
  changes.push({file:'common/RNBO_Math.h',original:'originals/RNBO_Math.h',original_sha256:hash(mathOriginal),prepared_sha256:hash(mathPrepared),reason:'Keep generic atan2/pow/floor numeric arguments in float32 builds on the float math path.'});
  const listFile=path.join(out,'common/RNBO_List.h');
  const listOriginal=fs.readFileSync(listFile,'utf8');
  const stackCopy=/for \(; i < length; i\+\+\) \{(\s+)_stackValues\[i\] = l\[i\];/g;
  if([...listOriginal.matchAll(stackCopy)].length!==4)throw Error('Review changed RNBO list copy loops');
  let listPrepared=listOriginal.replace(stackCopy,'for (; i < length && i < FIXED; i++) {$1_stackValues[i] = l[i];');
  listPrepared=listPrepared.replace(/_values\[i\] = l\[i\];/g,'(*this)[i] = l[i];');
  listPrepared=listPrepared.replace('_values[i] = listValues[i];','(*this)[i] = listValues[i];');
  fs.writeFileSync(path.join(originals,'RNBO_List.h'),listOriginal);
  fs.writeFileSync(listFile,listPrepared);
  changes.push({file:'common/RNBO_List.h',original:'originals/RNBO_List.h',original_sha256:hash(listOriginal),prepared_sha256:hash(listPrepared),reason:'Bound inline list copies and address overflow storage through the checked index operator.'});
  if(options.clockTargets){
    const clockFile=path.join(out,'common/RNBO_MinimalEngine.h');
    const clockOriginal=fs.readFileSync(clockFile,'utf8');
    const needle='_patcher->processClockEvent(event.time, event.clockId, event.clockHasValue, event.value);';
    if(clockOriginal.split(needle).length!==2)throw Error('Review changed RNBO MinimalEngine clock dispatch');
    const clockPrepared=clockOriginal.replace(needle,'(event.eventTarget ? event.eventTarget : _patcher)->processClockEvent(event.time, event.clockId, event.clockHasValue, event.value);');
    fs.writeFileSync(path.join(originals,'RNBO_MinimalEngine.h'),clockOriginal);
    fs.writeFileSync(clockFile,clockPrepared);
    changes.push({file:'common/RNBO_MinimalEngine.h',original:'originals/RNBO_MinimalEngine.h',original_sha256:hash(clockOriginal),prepared_sha256:hash(clockPrepared),reason:'Dispatch nested voice clocks to their recorded target, with root fallback for null targets.'});
  }
  return changes;
}
module.exports={prepareRuntime};
