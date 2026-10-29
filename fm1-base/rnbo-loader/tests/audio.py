"""Load independently compiled real RNBO modules through their C function tables."""
import ctypes as C
import math
import wave
from pathlib import Path
APP=Path(__file__).resolve().parents[1]
U=C.c_uint
class Stats(C.Structure):_fields_=[(n,U) for n in ['used','capacity','allocations','late','errors','blocks','bad']]
class Api(C.Structure):
    _fields_=[('magic',U),('abi',U),('bytes',U),('patch_id',U),('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
def check(name):
    lib=C.CDLL(str(APP/'modules'/name/'build'/(name+'.dylib')),mode=C.RTLD_LOCAL)
    api=Api.in_dll(lib,'rnbo_module');assert api.magic==0x31495041 and api.abi==1 and api.bytes==C.sizeof(Api)
    fn={n:C.CFUNCTYPE(r,*args)(getattr(api,n)) for n,r,args in [
        ('init',C.c_int,[]),('render',None,[C.POINTER(C.c_int),U,U]),('midi',None,[U,U,U]),('panic',None,[]),('count',U,[]),('name',C.c_char_p,[U]),('value',C.c_float,[U]),('set',None,[U,C.c_float]),('stats',None,[C.POINTER(Stats)])]}
    assert fn['init']()==1
    params={fn['name'](i).decode():i for i in range(fn['count']())};assert set(params)==({'level','attack','release'} if name=='mono' else {'ratio','depth','attack','release'})
    data=(C.c_int*512)()
    def render(blocks):
        out=[]
        for _ in range(blocks):
            fn['render'](data,256,4096)
            assert list(data)[::2]==list(data)[1::2];assert max(map(abs,data))<8388608
            out.extend(v/8388607 for v in list(data)[::2])
        return out
    def setp(n,v):fn['set'](params[n],v)
    if name=='fm':setp('depth',0)
    fn['midi'](0x90,69,127);render(50);clean=render(173)
    rms=lambda x:math.sqrt(sum(v*v for v in x)/len(x))
    assert .05<rms(clean)<.25
    def energy(x,hz):
        step=2*math.pi*hz/44100
        re=sum(v*math.cos(i*step) for i,v in enumerate(x));im=sum(v*math.sin(i*step) for i,v in enumerate(x));return math.hypot(re,im)/len(x)
    assert energy(clean,440)>.05 and energy(clean,1320)<.001
    if name=='fm':
        # Ratio 2 and index 2 produce a strong third harmonic. This measures
        # the generated FM graph's output rather than just checking metadata.
        setp('ratio',(2-.25)/(8-.25));setp('depth',2/8);render(30);rich=render(173)
        assert energy(rich,1320)>.01 and energy(rich,1320)>energy(clean,1320)*20
        setp('depth',0);render(30);assert energy(render(173),1320)<.001
    before=Stats();fn['stats'](C.byref(before));assert before.used<98304
    fn['panic']();assert rms(render(2))==0
    fn['midi'](0x90,69,64);render(40);assert .02<rms(render(1))<.12
    fn['midi'](0x80,69,0);render(400);assert rms(render(1))==0
    for b in range(20000):
        if b%80==0:fn['midi'](0x90,48+(b//80)%36,100)
        if b%80==60:fn['midi'](0x80,48+(b//80)%36,0)
        fn['render'](data,256,4096)
    after=Stats();fn['stats'](C.byref(after));assert not (after.errors or after.late or after.bad);assert before.used==after.used
    assert fn['init']()==1
    print('PASS',name,'real RNBO module table, MIDI, spectral checks, panic, reconstruction, 116 s render;',before.used,'arena bytes')
for name in ['mono','fm','mono','fm']:check(name)
