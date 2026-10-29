"""Versioned, fixed-address pi32v2 native RNBO module packages."""
import struct
import zlib
MAGIC=0x314d4e52
API_MAGIC=0x31495041
TEXT=0x01c34000
STATE=0x01c44000
IMAGE_MAX=65536
STATE_MAX=180224
def parse(data):
    if len(data)<64:raise ValueError('Short module')
    h=list(struct.unpack_from('<16I',data))
    if h[2] not in (1,2) or h[:8]!=[MAGIC,1,h[2],241,44100,256,TEXT,STATE]:raise ValueError('Incompatible module format/ABI/addresses')
    if not 84<=h[8]<=IMAGE_MAX or h[8]%4 or len(data)!=64+h[8]:raise ValueError('Module length')
    if h[9]>STATE_MAX or h[9]%4:raise ValueError('Module state budget')
    if h[12]!=zlib.crc32(data[:48]) or any(h[13:]):raise ValueError('Module header CRC')
    image=data[64:]
    if zlib.crc32(image)!=h[10]:raise ValueError('Module image CRC')
    if list(struct.unpack_from('<4I',image))!=[API_MAGIC,h[2],84,h[11]]:raise ValueError('Module API')
    title=image[16:48]
    if b'\0' not in title:raise ValueError('Unterminated title')
    pointers=struct.unpack_from('<9I',image,48)
    if any(p<TEXT+84 or p>=TEXT+len(image) or p%2 for p in pointers):raise ValueError('API pointer outside image')
    if len(image)>=100 and struct.unpack_from('<I',image,len(image)-16)[0]==0x31545652:
        from layout import MAGIC as VISUAL_MAGIC
        _,size,crc,fn=struct.unpack_from('<4I',image,len(image)-16)
        if size>len(image)-100 or fn<TEXT+84 or fn>=TEXT+len(image)-16-size or fn%2:raise ValueError('Visual trailer pointer')
        visual=image[-16-size:-16]
        if len(visual)<16 or zlib.crc32(visual)!=crc:raise ValueError('Visual trailer CRC')
        magic,version,nodes,lines,params,width,height=struct.unpack_from('<I6H',visual)
        need=16+nodes*24+lines*4+params*12
        if magic!=VISUAL_MAGIC or version!=1 or not 1<=nodes<=96 or lines>384 or params>16 or (width,height)!=(240,166) or not 0<=size-need<=3:raise ValueError('Visual trailer bounds')
    return {'abi':h[2],'title':title.split(b'\0')[0].decode('ascii'),'patch_id':h[11],'image_bytes':h[8],'state_bytes':h[9]}
def create(image,state_bytes,patch_id):
    abi=struct.unpack_from('<I',image,4)[0]
    h=[MAGIC,1,abi,241,44100,256,TEXT,STATE,len(image),state_bytes,zlib.crc32(image),patch_id,0,0,0,0]
    data=struct.pack('<16I',*h);h[12]=zlib.crc32(data[:48]);data=struct.pack('<16I',*h)+image
    parse(data)
    return data
