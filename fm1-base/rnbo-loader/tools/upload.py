#!/usr/bin/env python3
"""Upload .rnbom DSP modules; never invokes a firmware update."""
import argparse
import json
import struct
import sys
import time
import zlib
from pathlib import Path
from package import parse
APP=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(APP.parent/'tools'))
import fm1_install as wire

def status_packet(pkt,command):
    if not pkt or pkt[0]!=0xf0 or pkt[-1]!=0xf7:return None
    d=wire.unpack7(pkt[1:-1])
    if len(d)<7 or d[:3]!=bytes([0,0x59,command]):return None
    n=int.from_bytes(d[3:6],'little')
    if n!=28 or len(d)!=n+7 or (~sum(d[6:-1])&255)!=d[-1]:return None
    status,patch_id,cpu,xruns,abi,peak,blocks=struct.unpack_from('<i6I',d,6)
    return dict(status=status,patch_id=patch_id,cpu_percent=cpu,xruns=xruns,abi=abi,peak_render_us_since_boot=peak,render_blocks_since_boot=blocks)

def query(link):
    link.drain()
    if not link.send(wire.frame(0x68)):raise RuntimeError('Cannot send status query')
    deadline=time.monotonic()+5
    while time.monotonic()<deadline:
        info=status_packet(link.read(.25),0x69)
        if info:
            if info['abi'] not in (1,2):raise RuntimeError('Incompatible player ABI')
            return info
    raise RuntimeError('No RNBO Player response; install the player firmware first')

def bank_packet(pkt):
    if not pkt or pkt[0]!=0xf0 or pkt[-1]!=0xf7:return None
    d=wire.unpack7(pkt[1:-1])
    if len(d)!=23 or d[:6]!=bytes([0,0x59,0x6d,16,0,0]) or (~sum(d[6:-1])&255)!=d[-1]:return None
    version,count,active,occupied=struct.unpack_from('<4I',d,6)
    if version!=1 or count!=3 or active>3 or occupied>7 or (active and not occupied&(1<<(active-1))):return None
    return dict(version=version,slots=count,active_slot=active,occupied_mask=occupied)

def query_bank(link):
    link.drain()
    if not link.send(wire.frame(0x6c)):raise RuntimeError('Cannot query patch slots')
    deadline=time.monotonic()+5
    while time.monotonic()<deadline:
        info=bank_packet(link.read(.25))
        if info:return info
    raise RuntimeError('No three-slot player response. Install the updated player firmware first.')

def transfer(link,data,progress=lambda p:None,slot=None):
    meta=parse(data)
    if slot is not None and slot not in (1,2,3):raise ValueError('Patch slot must be 1, 2 or 3')
    link.drain()
    body=struct.pack('<II',len(data),zlib.crc32(data))+(struct.pack('<I',slot) if slot is not None else b'')
    if not link.send(wire.frame(0x6e if slot is not None else 0x6a,body)):raise RuntimeError('Cannot start upload')
    deadline=time.monotonic()+180;idle=time.monotonic()+20
    while time.monotonic()<deadline and time.monotonic()<idle:
        pkt=link.read(.25)
        if not pkt:continue
        request=wire.parse_request(pkt)
        if request:
            flags,addr,n=request
            if not 0<n<=512 or addr>len(data) or n>len(data)-addr:raise RuntimeError('Player requested bytes outside module')
            if not link.send(wire.response(addr,data[addr:addr+n])):raise RuntimeError('Connection lost')
            progress((addr+n)*100//len(data));idle=time.monotonic()+20
            continue
        info=status_packet(pkt,0x6b)
        if info:
            if info['status']:raise RuntimeError('Player rejected upload: '+str(info['status']))
            if info['abi'] not in (1,2) or info['abi']<meta['abi'] or info['patch_id']!=meta['patch_id']:raise RuntimeError('Active patch identity mismatch')
            return info
    raise RuntimeError('Upload timed out. The previous committed patch remains available on reboot; query status before retrying.')

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('module',nargs='?',type=Path);ap.add_argument('--status',action='store_true');ap.add_argument('--slots',action='store_true');ap.add_argument('--slot',type=int,choices=(1,2,3));ap.add_argument('--port');a=ap.parse_args()
    if sum([bool(a.module),a.status,a.slots])!=1:ap.error('Choose a module file, --status or --slots')
    if a.slot and not a.module:ap.error('--slot requires a module file')
    data=a.module.read_bytes() if a.module else None
    if data:print('Module:',json.dumps(parse(data)))
    backend=wire.MidoBackend();device=wire.Updater(backend,a.port).find()
    if not device:raise RuntimeError('No connected FM1 found')
    try:
        if device.id.text!='FM-1_9400':raise RuntimeError('Connected '+device.id.text+'. Install RNBO Player FM-1_9400 once before uploading modules.')
        before=query(device.link)
        if a.status:print(json.dumps(before,indent=2));return
        if a.slots:print(json.dumps(query_bank(device.link),indent=2));return
        if a.slot:print('Patch bank:',json.dumps(query_bank(device.link)))
        if parse(data)['abi']>before['abi']:raise RuntimeError('This polyphonic module needs the updated player. Install the new player once before uploading it.')
        last=[-1]
        def progress(p):
            if p//10!=last[0]:last[0]=p//10;print('upload',p,'%',flush=True)
        info=transfer(device.link,data,progress,slot=a.slot)
        if a.slot:
            bank=query_bank(device.link)
            if bank['active_slot']!=a.slot:raise RuntimeError('Active slot mismatch after upload')
            info.update(bank)
        print('Patch activated; firmware was not reinstalled.')
        print(json.dumps(info,indent=2))
        (APP/'build/last-upload.json').write_text(json.dumps({'module':str(a.module.resolve()),'result':info},indent=2)+'\n')
    finally:device.link.close()
if __name__=='__main__':
    try:main()
    except (RuntimeError,ValueError,wire.InstallError) as e:raise SystemExit(str(e))
