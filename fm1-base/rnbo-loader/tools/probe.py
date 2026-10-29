#!/usr/bin/env python3
"""Initialize an arbitrary host module in a disposable subprocess before shipping it."""
import ctypes as C
import json
import sys
from pathlib import Path
class Stats(C.Structure):_fields_=[(n,C.c_uint) for n in ['pool_used','pool_capacity','allocations','late','errors','blocks','bad_samples']]
class Api(C.Structure):_fields_=[(n,C.c_uint) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
lib=C.CDLL(str(Path(sys.argv[1]).resolve()),mode=C.RTLD_LOCAL);api=Api.in_dll(lib,'rnbo_module')
assert api.magic==0x31495041 and api.abi in (1,2) and api.bytes==C.sizeof(Api)
assert C.CFUNCTYPE(C.c_int)(api.init)()==1,'Patch initialization/channel/parameter check failed'
render=C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(api.render)
midi=C.CFUNCTYPE(None,C.c_uint,C.c_uint,C.c_uint)(api.midi)
setp=C.CFUNCTYPE(None,C.c_uint,C.c_float)(api.set);count=C.CFUNCTYPE(C.c_uint)(api.count)();assert count<=16
audio=(C.c_int*512)();midi(0x90,69,100)
for v in [0,.5,1]:
    for p in range(count):setp(p,v)
    for b in range(64):render(audio,256,4096)
midi(0x80,69,0)
for b in range(64):render(audio,256,4096)
stats=Stats();C.CFUNCTYPE(None,C.POINTER(Stats))(api.stats)(C.byref(stats))
assert not (stats.late or stats.errors or stats.bad_samples),'Patch runtime error, invalid audio or late allocation'
report={'title':bytes(api.title).decode(),'parameters':count,**{n:getattr(stats,n) for n,_ in Stats._fields_},'is_hardware_measurement':False}
print(json.dumps(report,indent=2))
