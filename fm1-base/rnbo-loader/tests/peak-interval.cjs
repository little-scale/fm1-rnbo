// SPDX-License-Identifier: MIT
const assert=require('node:assert'),fs=require('node:fs');
const {hoistPeakInterval}=require('../../rnbo/tools/peak-interval.cjs');
const source=fs.readFileSync(process.argv[2],'utf8');
assert.equal(hoistPeakInterval(source).count,1);
assert.throws(()=>hoistPeakInterval(source.replace('this->peakamp_01_d_prev = x;','this->peakamp_01_d_prev = x + 1;')));
assert.throws(()=>hoistPeakInterval(source.replace('for (Index i = 0; i < n; i++) {','while (false) {')));
assert.equal(hoistPeakInterval('void untouched() {}').code,'void untouched() {}');
console.log('PASS peak interval loop/detector layout guards');
