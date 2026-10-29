"""Compare active audio with the preserved reference, including negative FM frequencies."""
import ctypes as C
import json
from pathlib import Path
APP=Path(__file__).resolve().parents[1]
U=C.c_uint
class Api(C.Structure):
    _fields_=[(n,U) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
def load(name):
    lib=C.CDLL(str(APP/'modules'/name/'build'/(name+'.dylib')),mode=C.RTLD_LOCAL)
    api=Api.in_dll(lib,'rnbo_module')
    fn={n:C.CFUNCTYPE(r,*a)(getattr(api,n)) for n,r,a in [
        ('init',C.c_int,[]),('render',None,[C.POINTER(C.c_int),U,U]),('midi',None,[U,U,U]),('set',None,[U,C.c_float])]}
    fn['lib']=lib;return fn
ref=load('fm8poly2');fast=load('fm8poly2fast')
a=(C.c_int*512)();b=(C.c_int*512)();blocks=0
for depth in [0,.1875,1]:
    assert ref['init']()==fast['init']()==1
    for fn in [ref,fast]:
        for i,v in [(0,1),(1,0),(2,depth),(3,0),(4,.4),(5,0),(6,1),(7,.5)]:fn['set'](i,v)
        fn['midi'](0x90,120,127);fn['midi'](0x90,127,100)
    for block in range(200):
        # These event-rate products must update live from either operand.
        if block in (50,100,150):
            for fn in [ref,fast]:
                fn['set'](0,{50:.25,100:.8,150:1}[block])
                fn['set'](2,{50:1,100:.5,150:depth}[block])
        ref['render'](a,256,4096);fast['render'](b,256,4096)
        assert bytes(a)==bytes(b),'Optimized phase conversion changed active audio'
        blocks+=1
    for fn in [ref,fast]:fn['midi'](0x80,120,0);fn['midi'](0x80,127,0)
    for _ in range(64):
        ref['render'](a,256,4096);fast['render'](b,256,4096)
        assert bytes(a)==bytes(b),'Release tail changed'
        blocks+=1
print(json.dumps({'PASS':'sample-identical active audio against reference including release tails, live control changes, maximum ratio/depth and high/negative FM frequencies','compared_stereo_frames':blocks*256,'is_hardware_measurement':False},indent=2))
