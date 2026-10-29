"""Observe real RNBO voice mute state; never mute a release tail early."""
import ctypes as C
from pathlib import Path
APP=Path(__file__).resolve().parents[1]
U=C.c_uint
class Api(C.Structure):
    _fields_=[(n,U) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
lib=C.CDLL(str(APP/'modules/fm8poly2fast/build/fm8poly2fast.dylib'),mode=C.RTLD_LOCAL)
a=Api.in_dll(lib,'rnbo_module')
init=C.CFUNCTYPE(C.c_int)(a.init);render=C.CFUNCTYPE(None,C.POINTER(C.c_int),U,U)(a.render)
midi=C.CFUNCTYPE(None,U,U,U)(a.midi);setp=C.CFUNCTYPE(None,U,C.c_float)(a.set)
active=lib.rnbo_fm1_host_active_voices;active.restype=U
audio=(C.c_int*512)()
def blocks(n):
    for _ in range(n):render(audio,256,4096)
assert init()==1 and active()==0
setp(1,0);setp(2,0);setp(3,(500-1)/(2000-1));setp(5,0);setp(6,1);blocks(8)
midi(0x90,60,127);blocks(8);assert active()==1
midi(0x90,64,127);blocks(8);assert active()==2
midi(0x80,60,0);blocks(40);assert active()==2,'Release muted early'
blocks(60);assert active()==1,'Completed voice still runs DSP'
midi(0x80,64,0);blocks(100);assert active()==0
midi(0x90,67,127);blocks(8);assert active()==1 and max(map(abs,audio))>0
midi(0x80,67,0);blocks(100);assert active()==0
# At short-release block boundaries, fresh notes must survive pending mute clocks.
setp(3,0);blocks(4)
for i in range(100):
    midi(0x90,60,127);blocks(1);assert active()>=1
    midi(0x80,60,0);blocks(1)
    midi(0x90,60,127);blocks(4);assert active()>=1 and max(map(abs,audio))>0
    midi(0x80,60,0);blocks(8);assert active()==0
print('PASS real RNBO voice sleep: 0/1/2 active voices, intact 500 ms release tails, note wake-up and 100 rapid retriggers')
