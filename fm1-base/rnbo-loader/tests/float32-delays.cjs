const assert=require('assert');
const {float32Delays}=require('../../rnbo/tools/float32-delays.cjs');
const source='new Float64Buffer(this->delaytilde_01_del_bufferobj); Float64BufferRef delaytilde_01_del_buffer; Float64BufferRef untouched;';
const r=float32Delays(source);assert.equal(r.count,1);assert(r.code.includes('new Float32Buffer(this->delaytilde_01_del_bufferobj)'));assert(r.code.includes('Float32BufferRef delaytilde_01_del_buffer'));assert(r.code.includes('Float64BufferRef untouched'));
assert.throws(()=>float32Delays('new Float64Buffer(this->delaytilde_01_del_bufferobj);'));
assert.throws(()=>float32Delays('Float64BufferRef delaytilde_01_del_buffer;'));
assert.throws(()=>float32Delays('Float64BufferRef unrelated;'));
console.log('PASS targeted float32 delay adaptation, preserved unrelated buffers and declaration mismatch rejection');
