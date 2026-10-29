#!/usr/bin/env python3
"""Read the real JieLi ELF archives without executing their Linux tools."""
import struct
from pathlib import Path

def elf_symbols(data):
    if data[:6]!=b'\x7fELF\x01\x01':
        raise ValueError('Expected little-endian ELF32')
    h=struct.unpack_from('<16sHHIIIIIHHHHHH',data)
    sections=[struct.unpack_from('<IIIIIIIIII',data,h[6]+i*h[11]) for i in range(h[12])]
    defined,undefined=set(),set()
    for sh in sections:
        if sh[1]!=2:continue
        strings=sections[sh[6]];names=data[strings[4]:strings[4]+strings[5]]
        for off in range(sh[4],sh[4]+sh[5],sh[9]):
            name,value,size,info,other,index=struct.unpack_from('<IIIBBH',data,off)
            if not name or not info>>4:continue
            text=names[name:names.index(b'\0',name)].decode('ascii')
            (defined if index else undefined).add(text)
    return defined,undefined

class Archive:
    def __init__(self,path):
        self.path=Path(path);self.data=self.path.read_bytes();self.symbols={};self.long_names=b''
        if self.data[:8]!=b'!<arch>\n':raise ValueError('Expected GNU archive')
        off=8
        while off<len(self.data):
            header=self.data[off:off+60];size=int(header[48:58]);name=header[:16].decode().strip()
            body=self.data[off+60:off+60+size]
            if name=='/':
                count=int.from_bytes(body[:4],'big');offsets=struct.unpack_from('>'+str(count)+'I',body,4)
                names=body[4+count*4:].split(b'\0')
                self.symbols={n.decode('ascii'):p for n,p in zip(names,offsets)}
            elif name=='//':self.long_names=body
            off+=60+size+(size&1)
        if not self.symbols:raise ValueError('No GNU archive symbol index')
    def member(self,offset):
        h=self.data[offset:offset+60];n=int(h[48:58]);name=h[:16].decode().strip()
        if name.startswith('/') and name[1:].isdigit():
            start=int(name[1:]);name=self.long_names[start:].split(b'/\n',1)[0].decode()
        return name,self.data[offset+60:offset+60+n]

def closure(required,archives,provided=()):
    resolved=set(provided);pending=set(required);members=set();unresolved=set()
    while pending:
        symbol=pending.pop()
        if symbol in resolved:continue
        found=next(((a,a.symbols[symbol]) for a in archives if symbol in a.symbols),None)
        if not found:unresolved.add(symbol);continue
        a,off=found;key=(str(a.path),off)
        if key in members:continue
        members.add(key);name,body=a.member(off);defines,uses=elf_symbols(body)
        resolved.update(defines);pending.update(uses-resolved)
    return sorted(unresolved-resolved),sorted(f'{Path(p).name}:{a.member(off)[0]}' for p,off in members for a in archives if str(a.path)==p)
