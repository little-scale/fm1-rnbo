"""Exercise the real uploader loop against a fake wire peer; no MIDI ports."""
import struct
import sys
from pathlib import Path
APP=Path(__file__).resolve().parents[1];sys.path.insert(0,str(APP/'tools'))
import upload as u
from package import create,parse,TEXT
image=bytearray(1024);struct.pack_into('<4I',image,0,0x31495041,1,84,123);image[16:21]=b'TEST\0';struct.pack_into('<9I',image,48,*([TEXT+84]*9));data=create(bytes(image),140000,123)
def reply(status=0,patch=123,abi=1):return u.wire.frame(0x6b,struct.pack('<i6I',status,patch,10,0,abi,600,1234))
def request(a,n):
    d=bytearray([0,0x59,0x30,7,0,0,0]);d+=struct.pack('<II',a,n)[:7];d.append(~sum(d[6:])&255)
    return b'\xf0'+u.wire.pack7(d)+b'\xf7'
class Link:
    def __init__(self,packets):self.packets=list(packets);self.sent=[]
    def drain(self):pass
    def send(self,pkt):self.sent.append(pkt);return True
    def read(self,timeout):return self.packets.pop(0) if self.packets else None
link=Link([request(0,64),request(0,512),request(0,512),request(512,512),request(1024,64),reply()]);info=u.transfer(link,data)
assert info['patch_id']==123 and info['peak_render_us_since_boot']==600
for packet in link.sent[1:]:
    d=u.wire.unpack7(packet[1:-1]);address=int.from_bytes(d[7:11],'little');n=int.from_bytes(d[11:13],'little');assert d[14:-1]==data[address:address+n]
for packets in [[request(len(data)-10,100)],[request(0,513)],[reply(-3)],[reply(patch=124)]]:
    try:u.transfer(Link(packets),data);raise AssertionError('bad peer accepted')
    except RuntimeError:pass
damaged=bytearray(reply());damaged[-2]^=1;assert u.status_packet(damaged,0x6b) is None
for at in [0,8,32,40,48,64,112,len(data)-1]:
    broken=bytearray(data);broken[at]^=1
    try:parse(broken);raise AssertionError('corruption accepted')
    except ValueError:pass
print('PASS module format and real uploader: retries, byte responses, invalid reads, CRC, status and identity mismatch')

# Both MIDI contracts parse; ABI 2 requires a player advertising support for it.
polyimage=bytearray(image);struct.pack_into('<I',polyimage,4,2)
polydata=create(bytes(polyimage),140000,123);assert parse(polydata)['abi']==2
assert u.query(Link([u.wire.frame(0x69,struct.pack('<i6I',0,123,0,0,2,0,0))]))['abi']==2
assert u.transfer(Link([reply(abi=2)]),polydata)['abi']==2
try:u.transfer(Link([reply(abi=1)]),polydata);raise AssertionError('Old player accepted raw MIDI module')
except RuntimeError:pass
for abi in (0,3):
    broken=bytearray(polydata);struct.pack_into('<I',broken,8,abi)
    import zlib
    struct.pack_into('<I',broken,48,zlib.crc32(broken[:48]))
    try:parse(broken);raise AssertionError('Unknown ABI accepted')
    except ValueError:pass
print('PASS ABI 1/2 package and player capability handling')

# Slot-aware uploads use a distinct command: old firmware cannot overwrite
# another logical slot by accidentally treating the request as a legacy upload.
for slot in (1,2,3):
    link=Link([reply()]);u.transfer(link,data,slot=slot)
    d=u.wire.unpack7(link.sent[0][1:-1]);assert d[2]==0x6e and len(d)==19
    assert struct.unpack_from('<III',d,6)==(len(data),zlib.crc32(data),slot)
for slot in (0,4,-1):
    link=Link([])
    try:u.transfer(link,data,slot=slot);raise AssertionError('invalid destination accepted')
    except ValueError:pass
    assert not link.sent
bank=u.wire.frame(0x6d,struct.pack('<4I',1,3,2,7))
assert u.query_bank(Link([bank]))==dict(version=1,slots=3,active_slot=2,occupied_mask=7)
for body in [(1,3,4,7),(1,3,2,1),(2,3,1,1),(1,4,1,1),(1,3,0,8)]:
    assert u.bank_packet(u.wire.frame(0x6d,struct.pack('<4I',*body))) is None
bad=bytearray(bank);bad[-2]^=1;assert u.bank_packet(bad) is None
print('PASS explicit slot uploads, invalid-slot refusal and patch-bank capability validation')
