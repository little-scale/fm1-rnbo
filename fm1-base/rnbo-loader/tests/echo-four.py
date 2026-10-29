"""Four real RNBO voices, safe stealing, one master echo and tail/panic checks."""
import ctypes as C
import json
import math
import struct
import wave
from pathlib import Path
APP=Path(__file__).resolve().parents[1];U=C.c_uint
class Stats(C.Structure):_fields_=[(n,U) for n in ['used','capacity','allocations','late','errors','blocks','bad']]
class Api(C.Structure):
    _fields_=[(n,U) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
lib=C.CDLL(str(APP/'modules/fm4echo/build/fm4echo.dylib'),mode=C.RTLD_LOCAL);api=Api.in_dll(lib,'rnbo_module');assert api.abi==2
fn={n:C.CFUNCTYPE(r,*args)(getattr(api,n)) for n,r,args in [
 ('init',C.c_int,[]),('render',None,[C.POINTER(C.c_int),U,U]),('midi',None,[U,U,U]),('panic',None,[]),('count',U,[]),('name',C.c_char_p,[U]),('set',None,[U,C.c_float]),('stats',None,[C.POINTER(Stats)])]}
active=lib.rnbo_fm1_host_active_voices;active.restype=U
a=(C.c_int*512)()
def render(blocks):
    l=[];r=[]
    for _ in range(blocks):
        fn['render'](a,256,4096);assert max(map(abs,a))<8388607,'Clipped output'
        l.extend(v/8388607 for v in list(a)[::2]);r.extend(v/8388607 for v in list(a)[1::2])
    return l,r
def energy(x,n):
    w=2*math.pi*440*2**((n-69)/12)/44100
    return abs(sum(v*complex(math.cos(i*w),math.sin(i*w)) for i,v in enumerate(x)))/len(x)
def rms(x):return math.sqrt(sum(v*v for v in x)/len(x))
def on(n):fn['midi'](0x90,n,127)
def off(n):fn['midi'](0x80,n,0)
def configure(mix=0,feedback=0,time=80):
    assert fn['init']()==1 and active()==0
    assert [fn['name'](i).decode() for i in range(fn['count']())]==['ratio','attack','depth','release','level','Echo Time','Echo Feedback','Echo Mix']
    for i,v in [(1,0),(2,0),(3,0),(4,.8),(5,(time-40)/130),(6,feedback/.98),(7,mix)]:fn['set'](i,v)
    render(40)
configure()
for n in [60,64,67,71]:on(n);render(8)
assert active()==4
chord=render(64)[0];assert all(energy(chord,n)>.025 for n in [60,64,67,71])
on(72);render(8);stolen=render(64)[0]
assert energy(stolen,60)<.001 and all(energy(stolen,n)>.025 for n in [64,67,71,72])
off(60);render(8);after=render(64)[0];assert energy(after,72)>.025 and active()==4
for n in [64,67,71,72]:off(n)
render(16);assert active()==0 and max(map(abs,render(2)[0]))==0
# Prefer a releasing voice to stealing an older key that is still held.
configure();fn['set'](3,(500-1)/(2000-1))
for n in [60,64,67,71]:on(n);render(8)
off(64);render(8);assert active()==4
on(72);render(8);preferred=render(64)[0]
assert energy(preferred,64)<.001 and all(energy(preferred,n)>.025 for n in [60,67,71,72])
off(64);render(8);assert active()==4
for n in [60,67,71,72]:off(n)
render(120);assert active()==0;fn['set'](3,0);render(8)
# Sustain and repeated notes must not create an extra voice or hang a release.
for n in [60,64,67,71]:on(n);render(4)
on(71);render(4);assert active()==4
fn['midi'](0xb0,64,127)
for n in [60,64,67,71]:off(n)
render(16);assert active()==4
fn['midi'](0xb0,64,0);render(16);assert active()==0
# One short note yields one stereo echo after voices sleep, no repeats at feedback zero.
configure(1,0);on(69);pulse=render(4);off(69);tail=render(80);assert active()==0
l=pulse[0]+tail[0];r=pulse[1]+tail[1]
assert max(map(abs,l[:3528]))==0 and max(map(abs,r[:3528]))==0,'100% mix leaked undelayed dry audio'
left_start=next(i for i in range(3000,len(l)) if abs(l[i])>1e-5)
right_start=next(i for i in range(3000,len(r)) if abs(r[i])>1e-5)
assert abs(left_start-3528)<=3,(left_start,right_start)
assert right_start-left_start==128
assert rms(l[3600:4300])>.01 and max(map(abs,l[6000:]))==0
# Feedback repeats decay at the chosen gain; the master continues with zero voices.
configure(1,.5);on(69);pulse=render(4);off(69);tail=render(100);assert active()==0
l=pulse[0]+tail[0];r=pulse[1]+tail[1]
peaks=[rms(l[3528+k*(3528+256)+128:3528+k*(3528+256)+850]) for k in range(3)]
assert .48<peaks[1]/peaks[0]<.52 and .48<peaks[2]/peaks[1]<.52,peaks
# At the new 0.98 maximum, long echoes still decay without approaching clipping.
configure(1,.98,170);on(69);pulse=render(4);off(69);tail=render(300);assert active()==0
high=pulse[0]+tail[0]
near_unity_peaks=[rms(high[7497+k*(7497+256)+128:7497+k*(7497+256)+850]) for k in range(3)]
assert all(.975<near_unity_peaks[k+1]/near_unity_peaks[k]<.985 for k in range(2)),near_unity_peaks
late_peak=0
for block in range(11000):
    fn['render'](a,256,4096)
    assert max(map(abs,a))<.75*8388607,'Near-unity feedback approached clipping'
    if block>=10900:late_peak=max(late_peak,max(map(abs,a))/8388607)
assert late_peak<max(near_unity_peaks)*.01,'High-feedback tail failed to decay over a minute'
# Panic clears synth voices, delay lines and feedback history before the next note.
configure(1,.98)
for n in [60,64,67,71]:on(n)
render(60);fn['panic']();assert active()==0;render(2)
assert max(map(abs,render(4)[0]))==0
on(72);render(4);off(72);new=render(6)[0];assert max(map(abs,new[512:]))==0,'Panic revived old master echo before new echo time'
render(180)
# Parameter changes and a 116-second four-voice run stay within the fixed arena.
configure(1,.98,170)
for n in [48,52,55,59]:on(n)
for v in [0,.5,1]:
    for i in range(8):fn['set'](i,v)
    render(40)
fn['panic']();render(40)
before=Stats();fn['stats'](C.byref(before))
for b in range(20000):
    root=48+(b//100)%12
    if b%100==0:
        for n in [root,root+4,root+7,root+11]:on(n)
    if b%100==60:
        for n in [root,root+4,root+7,root+11]:off(n)
    fn['render'](a,256,4096)
    assert max(map(abs,a))<.75*8388607,'Four-voice stress exceeded headroom'
after=Stats();fn['stats'](C.byref(after));assert after.used==before.used and after.allocations==before.allocations
assert not(after.late or after.errors or after.bad)
assert after.used<=114688
# A short, reproducible echo audition using default controls.
assert fn['init']()==1
outl=[];outr=[]
for n in [60,64,67,71]:on(n)
x,y=render(50);outl+=x;outr+=y
for n in [60,64,67,71]:off(n)
x,y=render(400);outl+=x;outr+=y
with wave.open(str(APP/'build/four-voice-echo-audition.wav'),'wb') as w:
    w.setnchannels(2);w.setsampwidth(2);w.setframerate(44100)
    w.writeframes(b''.join(struct.pack('<hh',round(x*32767),round(y*32767)) for x,y in zip(outl,outr)))
print(json.dumps({'PASS':'four-note chord, fifth-note oldest-voice stealing, stale note-offs, sustain, master echo timing/decay, stereo offset, tails after voice sleep, panic, full control sweeps and 116 s render','echo_first_sample':left_start,'stereo_offset_samples':right_start-left_start,'feedback_repeat_rms':peaks,'feedback_098_repeat_rms':near_unity_peaks,'feedback_098_tail_peak_after_minute':late_peak,'arena_bytes':after.used,'arena_capacity':after.capacity,'late_allocations':after.late,'errors':after.errors,'bad_samples':after.bad,'is_hardware_measurement':False},indent=2))

for filename,present,absent in [('four',[60,64,67,71],[72]),('fifth',[64,67,71,72],[60]),('survivor',[64,67,71,72],[60]),('silent',[],[60,64,67,71,72])]:
    with wave.open(str(APP/'build/echo-player'/(filename+'.wav')),'rb') as w:
        frames=w.readframes(w.getnframes());channels=w.getnchannels()
    samples=[v/32768 for v in struct.unpack('<'+'h'*(len(frames)//2),frames)[::channels]]
    assert all(energy(samples,n)>.02 for n in present),filename
    assert all(energy(samples,n)<.001 for n in absent),filename
print('PASS full player four-key chord, fifth-note stealing, stale note-off, silence, FX controls and SAVE/reboot')
