"""Small read-only parser for the pinned toolchain's ELF32 outputs."""
import struct
def read(path):
    data=path.read_bytes()
    if data[:6]!=b'\x7fELF\x01\x01':raise ValueError('Expected little-endian ELF32')
    h=struct.unpack_from('<16sHHIIIIIHHHHHH',data)
    ss=[struct.unpack_from('<IIIIIIIIII',data,h[6]+i*h[11]) for i in range(h[12])]
    s=ss[h[13]];names=data[s[4]:s[4]+s[5]]
    sections={names[s[0]:names.index(b'\0',s[0])].decode():{'address':s[3],'bytes':s[5],'data':data[s[4]:s[4]+s[5]] if s[1]!=8 else b'','type':s[1]} for s in ss}
    symbols={};undefined=[]
    for s in ss:
        if s[1]!=2:continue
        strings=ss[s[6]];names=data[strings[4]:strings[4]+strings[5]]
        for off in range(s[4],s[4]+s[5],s[9]):
            n,value,size,info,other,index=struct.unpack_from('<IIIBBH',data,off)
            if not n:continue
            name=names[n:names.index(b'\0',n)].decode()
            if index:symbols[name]=value
            elif info>>4==1:undefined.append(name)
    return {'machine':h[2],'entry':h[4],'sections':sections,'symbols':symbols,'undefined':undefined}
