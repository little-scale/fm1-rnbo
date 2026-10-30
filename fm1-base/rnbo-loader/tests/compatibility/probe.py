#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Exercise a real compiled RNBO module in a disposable process, without MIDI I/O."""
import argparse,ctypes as C,json,math,time
from pathlib import Path

class Stats(C.Structure):
    _fields_=[(n,C.c_uint) for n in ['pool_used','pool_capacity','allocations','late','errors','blocks','bad_samples']]
class Api(C.Structure):
    _fields_=[(n,C.c_uint) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]

def run(path,assertion='finite'):
    lib=C.CDLL(str(Path(path).resolve()),mode=C.RTLD_LOCAL);api=Api.in_dll(lib,'rnbo_module')
    assert api.magic==0x31495041 and api.abi in (1,2) and api.bytes==C.sizeof(Api)
    init=C.CFUNCTYPE(C.c_int)(api.init);render=C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(api.render)
    midi=C.CFUNCTYPE(None,C.c_uint,C.c_uint,C.c_uint)(api.midi);setp=C.CFUNCTYPE(None,C.c_uint,C.c_float)(api.set)
    count=C.CFUNCTYPE(C.c_uint)(api.count);getstats=C.CFUNCTYPE(None,C.POINTER(Stats))(api.stats)
    panic=C.CFUNCTYPE(None)(api.panic);audio=(C.c_int*512)();stats=Stats();peak=0;energy=0;blocks=0;nonzero=0
    assert init()==1,'Module initialization failed'
    getstats(C.byref(stats));initial_allocations=stats.allocations
    def process(n):
        nonlocal peak,energy,blocks,nonzero
        for _ in range(n):
            render(audio,256,4096);blocks+=1
            values=list(audio);block_peak=max(map(abs,values));peak=max(peak,block_peak)
            energy+=sum(v*v for v in values);nonzero+=block_peak>0
            assert all(-8388607<=v<=8388607 for v in values),'Output outside signed 24-bit range'
    start=time.perf_counter();process(16)
    # Notes, chords, stealing, channel-specific controllers, pitch bend and sustain.
    for channel in [0,1,15]:
        for note in [36,60,64,67,72]:midi(0x90|channel,note,100)
        midi(0xb0|channel,64,127);midi(0xb0|channel,1,80);midi(0xe0|channel,0,64);midi(0xc0|channel,2,0)
        process(12)
        for note in [36,60,64,67,72]:midi(0x80|channel,note,0)
        midi(0xb0|channel,64,0);process(12)
    for value in [0,.01,.25,.5,.75,.99,1]:
        for p in range(count()):setp(p,value)
        midi(0x90,69,100);process(12);midi(0x90,69,0);process(8)
    process(128);getstats(C.byref(stats))
    assert not(stats.late or stats.errors or stats.bad_samples),'Late allocation/runtime error/invalid sample'
    assert stats.allocations==initial_allocations,'Allocation count changed after initialization'
    assert stats.pool_used<=stats.pool_capacity
    if assertion=='audible':assert peak>16 and nonzero>0,'The tested graph produced no measurable signal'
    if assertion.startswith('constant:'):
        expected=float(assertion.split(':',1)[1])*8388607
        assert all(abs(v-expected)<12 for v in audio),'Constant output mismatch: expected '+str(expected)+', got '+str(audio[0])
    panic();process(4);assert not any(audio),'Panic did not silence output'
    assert init()==1,'Explicit reinitialization failed';process(8);getstats(C.byref(stats))
    assert not(stats.late or stats.errors or stats.bad_samples)
    return {'kind':'host runtime stress probe','assertion':assertion,'parameters':count(),'peak':peak,'rms':math.sqrt(energy/(blocks*512)),'nonzero_blocks':nonzero,'rendered_blocks':blocks,'elapsed_seconds':time.perf_counter()-start,'initial_allocations':initial_allocations,'stats':{n:getattr(stats,n) for n,_ in Stats._fields_},'hardware_test':False,'cpu_percent_is_not_device_cpu':True}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('module');p.add_argument('--assertion',default='finite');a=p.parse_args()
    if a.assertion not in ['finite','audible'] and not a.assertion.startswith('constant:'):p.error('Unknown assertion')
    print(json.dumps(run(a.module,a.assertion),indent=2))
