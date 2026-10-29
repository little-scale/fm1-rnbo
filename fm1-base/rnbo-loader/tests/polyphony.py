"""Measure real two-voice RNBO output, release, stealing and allocation stability."""
import ctypes as C
import json
import math
import os
import wave
from pathlib import Path
APP=Path(__file__).resolve().parents[1]
U=C.c_uint
class Stats(C.Structure):
    _fields_=[(n,U) for n in ['used','capacity','allocations','late','errors','blocks','bad']]
class Api(C.Structure):
    _fields_=[(n,U) for n in ['magic','abi','bytes','patch_id']]+[('title',C.c_char*32)]+[(n,C.c_void_p) for n in ['init','render','midi','panic','count','name','value','set','stats']]
module=os.environ.get('RNBO_POLY_TEST_MODULE','fm8poly2')
lib=C.CDLL(str(APP/'modules'/module/'build'/(module+'.dylib')),mode=C.RTLD_LOCAL)
api=Api.in_dll(lib,'rnbo_module');assert api.abi==2 and api.bytes==C.sizeof(Api)
fn={n:C.CFUNCTYPE(r,*a)(getattr(api,n)) for n,r,a in [
 ('init',C.c_int,[]),('render',None,[C.POINTER(C.c_int),U,U]),('midi',None,[U,U,U]),('panic',None,[]),('count',U,[]),('name',C.c_char_p,[U]),('set',None,[U,C.c_float]),('stats',None,[C.POINTER(Stats)])]}
audio=(C.c_int*512)()
def render(blocks):
    result=[]
    for _ in range(blocks):
        fn['render'](audio,256,4096)
        assert max(map(abs,audio))<8388608
        result.extend(v/8388607 for v in list(audio)[::2])
    return result
def energy(x,note):
    omega=2*math.pi*440*2**((note-69)/12)/44100
    return abs(sum(v*complex(math.cos(i*omega),math.sin(i*omega)) for i,v in enumerate(x)))/len(x)
def configure():
    assert fn['init']()==1
    names=[fn['name'](i).decode() for i in range(fn['count']())]
    assert names==['ratio','attack','depth','release','level','decay','sustain','pan']
    for name,value in [('attack',0),('release',0),('depth',0),('decay',0),('sustain',1)]:fn['set'](names.index(name),value)
    render(8)
def on(n,v=127):fn['midi'](0x90,n,v)
def off(n):fn['midi'](0x80,n,0)
configure();on(60);render(8);on(64);render(8);chord=render(64)
assert energy(chord,60)>.035 and energy(chord,64)>.035,'Second note replaced first'
off(60);render(8);one=render(64)
assert energy(one,60)<.001 and energy(one,64)>.035,'Note-off silenced wrong voice'
off(64);render(16);assert max(map(abs,render(4)))==0
# A third held note steals the oldest of the two voices; stale note-off is safe.
on(60);render(8);on(64);render(8);on(67);render(8);stolen=render(64)
assert energy(stolen,60)<.001 and energy(stolen,64)>.035 and energy(stolen,67)>.035
off(60);render(8);after=render(64);assert energy(after,64)>.035 and energy(after,67)>.035
off(64);off(67);render(16);assert max(map(abs,render(4)))==0
# A repeated note uses one voice; velocity-zero note-on releases it.
on(60);render(8);on(60);render(8);repeat=render(64);assert .035<energy(repeat,60)<.065
fn['midi'](0x90,60,0);render(16);assert max(map(abs,render(4)))==0
# Sustain pedal and panic must leave no stuck output.
on(60);on(64);render(8);fn['midi'](0xb0,64,127);off(60);off(64);render(8)
held=render(64);assert energy(held,60)>.035 and energy(held,64)>.035
fn['midi'](0xb0,64,0);render(16);assert max(map(abs,render(4)))==0
on(60);on(64);render(8);fn['midi'](0xb0,64,127);off(60);off(64);render(8);fn['panic']();assert max(map(abs,render(4)))==0
on(67);render(16);fresh=render(64);assert energy(fresh,67)>.035 and energy(fresh,60)<.001 and energy(fresh,64)<.001;off(67);render(16)
before=Stats();fn['stats'](C.byref(before))
for block in range(20000):
    if block%100==0:on(48+(block//100)%12);on(60+(block//100)%12)
    if block%100==60:off(48+(block//100)%12);off(60+(block//100)%12)
    fn['render'](audio,256,4096)
after=Stats();fn['stats'](C.byref(after));assert before.used==after.used and before.allocations==after.allocations
assert not(after.late or after.errors or after.bad)
# A small audition contains a chord, then its surviving note.
with wave.open(str(APP/'build/polyphony-audition.wav'),'wb') as w:
    w.setnchannels(1);w.setsampwidth(2);w.setframerate(44100)
    import struct
    w.writeframes(b''.join(struct.pack('<h',round(v*32767)) for v in chord+one))
assert fn['init']()==1
print(json.dumps({'PASS':'real RNBO two-voice chord, independent releases, oldest-voice stealing, repeated/zero-velocity notes, sustain, panic and 116 s stress render','arena_bytes':after.used,'late_allocations':after.late,'runtime_errors':after.errors,'is_hardware_measurement':False},indent=2))

# Check the complete player's recorded keyboard/MIDI chords, not just direct API calls.
for filename,present,absent in [('chord',[60,64],[67]),('survivor',[64],[60]),('stolen',[64,67],[60]),('midi-chord',[60,64],[67]),('midi-survivor',[64],[60]),('silent',[],[60,64,67])]:
    with wave.open(str(APP/'build'/('fast-player' if module=='fm8poly2fast' else 'poly-player')/(filename+'.wav')),'rb') as w:
        frames=w.readframes(w.getnframes());channels=w.getnchannels()
    samples=[v/32768 for v in struct.unpack('<'+'h'*(len(frames)//2),frames)[::channels]]
    assert all(energy(samples,n)>.03 for n in present),filename
    assert all(energy(samples,n)<.001 for n in absent),filename
print('PASS full player keyboard/MIDI spectra: two notes, independent release, voice stealing and silence')
