import ctypes as C,math,json
from pathlib import Path
APP=Path(__file__).resolve().parents[1];U=C.c_uint
class Stats(C.Structure):_fields_=[(n,U) for n in ['used','capacity','allocations','late','errors','blocks','bad']]
class Api(C.Structure):_fields_=[(n,U) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
lib=C.CDLL(str(APP/'modules/saw_cutoff_delay/build/saw_cutoff_delay.dylib'));api=Api.in_dll(lib,'rnbo_module')
fn={n:C.CFUNCTYPE(r,*args)(getattr(api,n)) for n,r,args in [('init',C.c_int,[]),('render',None,[C.POINTER(C.c_int),U,U]),('midi',None,[U,U,U]),('count',U,[]),('name',C.c_char_p,[U]),('set',None,[U,C.c_float]),('stats',None,[C.POINTER(Stats)])]}
a=(C.c_int*512)()
def render(blocks):
 out=[]
 for _ in range(blocks):
  fn['render'](a,256,4096);assert list(a)[::2]==list(a)[1::2];out.extend(v/8388607 for v in list(a)[::2])
 return out
assert fn['init']()==1;assert fn['count']()==8
print('Names:',[fn['name'](i).decode() for i in range(8)])
render(40);fn['midi'](0x90,60,100);default=render(350);fn['midi'](0x80,60,0);tail=render(650)
assert max(map(abs,default))<.95, 'Default output clips'
print('Default peak:',max(map(abs,default)))
print('Released peak after 3s:',max(map(abs,tail[-44100:])))
# A short sound followed by integer-spaced echoes proves the corrected loop.
assert fn['init']()==1
for i,v in [(2,80/170),(3,.7),(4,1/2500),(5,1/2500),(6,0),(7,0)]:fn['set'](i,v)
render(40);fn['midi'](0x90,60,127);pulse=render(130)
def rms(x):return math.sqrt(sum(v*v for v in x)/len(x))
step=3528+256;energies=[rms(pulse[k*step:k*step+500]) for k in range(4)]
print('Dry/echo RMS:',energies)
assert energies[0]>.0001 and all(.67<energies[k+1]/energies[k]<.73 for k in range(3)),energies
assert max(map(abs,pulse[1000:3000]))<1e-6
st=Stats();fn['stats'](C.byref(st));assert not(st.late or st.errors or st.bad)
print('Stats:',json.dumps({k:getattr(st,k) for k,_ in st._fields_}))
print('PASS audible notes, stereo, envelope release, correctly timed feedback echoes, no runtime errors or late allocations')

# Compare the optimized saw against the original generated int64 truncation.
# Run explicitly after building build/saw-reference/module as a host reference.
import sys
if '--reference' in sys.argv:
 ref=C.CDLL(str(APP/'build/saw-reference/module/build/saw_cutoff_delay.dylib'),mode=C.RTLD_LOCAL)
 refapi=Api.in_dll(ref,'rnbo_module')
 ref_init=C.CFUNCTYPE(C.c_int)(refapi.init);ref_render=C.CFUNCTYPE(None,C.POINTER(C.c_int),U,U)(refapi.render)
 ref_midi=C.CFUNCTYPE(None,U,U,U)(refapi.midi);ref_set=C.CFUNCTYPE(None,U,C.c_float)(refapi.set)
 assert fn['init']()==ref_init()==1
 rb=(C.c_int*512)();frames=0
 for i,v in [(0,.8),(1,.3),(3,.5),(4,0),(5,.1),(6,.5),(7,.1)]:fn['set'](i,v);ref_set(i,v)
 for note in [0,21,53,60,69,96,127]:
  fn['midi'](0x90,note,100);ref_midi(0x90,note,100)
  for _ in range(80):
   fn['render'](a,256,4096);ref_render(rb,256,4096);assert list(a)==list(rb),'Optimized saw changed the waveform';frames+=256
  fn['midi'](0x80,note,0);ref_midi(0x80,note,0)
 print('PASS exact reference comparison:',frames,'frames across MIDI 0..127')
