// SPDX-License-Identifier: MIT
const assert=require('node:assert');
const fs=require('node:fs');
const {compactMtofTables}=require('../../rnbo/tools/mtof-table.cjs');
const file=process.argv[2];
if(!file)throw Error('Pass the original generated mtof header from tests/compatibility/mtof.py');
const source=fs.readFileSync(file,'utf8');
const result=compactMtofTables(source);
assert.equal(result.count,1);
assert(result.code.includes('innerMtoF_buffer->requestSize(2, 1)'));
const buffer=source.match(/this->(\w+_innerMtoF_buffer) = new SampleBuffer/)[1];
for(const extra of [
  `number read(){return this->${buffer}[0];}`,
  `number read(){return this->${buffer}->getSample(0, 0);}`,
  'void alias(){SampleBuffer another(this->RNBODefaultMtofLookupTable256);}',
  `void unknown(){someFunction(this->${buffer});}`
]){
  const changed=source+'\n'+extra;
  const rejected=compactMtofTables(changed);
  assert.equal(rejected.count,0);assert.equal(rejected.code,changed);
}
assert.equal(compactMtofTables(source.replace('requestSize(65536, 1)','requestSize(32768, 1)')).count,0);
assert.equal(compactMtofTables('number untouched = 1;').count,0);
assert.equal(compactMtofTables(result.code).count,0);
console.log('PASS unused mtof table reduction and fail-closed reader/alias/layout guards');
