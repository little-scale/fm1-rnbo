// SPDX-License-Identifier: MIT
const assert=require('node:assert'),fs=require('node:fs');
const {boundedAverages}=require('../../rnbo/tools/bounded-averages.cjs');
assert(process.argv.length>2,'Pass a generated unbounded averaging header');
for(const file of process.argv.slice(2)){
  const source=fs.readFileSync(file,'utf8');const r=boundedAverages(source);
  assert.equal(r.changes.length,1);assert.equal(r.changes[0].window_samples,32);assert.equal(r.changes[0].buffer_data_bytes,132);
  assert(r.code.includes('requestSize(33, 1)'));assert(r.code.includes('new Float32Buffer'));
  assert.equal(boundedAverages(source.replace('RNBO_UNUSED(windowSize);','')).code,source.replace('RNBO_UNUSED(windowSize);',''));
  const zero=source.replace(/_setwindowsize\(32\)/g,'_setwindowsize(0)').replace(/, 32, /g,', 0, ');
  assert.notEqual(zero,source);assert.equal(boundedAverages(zero).code,zero);
  assert.throws(()=>boundedAverages(source.replace('new Float64Buffer','new SampleBuffer')));
}
assert.equal(boundedAverages('void untouched() {}').changes.length,0);
console.log('PASS constant mean/RMS history bounds, unknown-window preservation and buffer-layout guards');
