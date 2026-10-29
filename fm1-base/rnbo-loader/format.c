/* SPDX-License-Identifier: MIT */
#include "module.h"
#include "visual.h"
uint32_t rm_u32(const void *p){const uint8_t *b=p;return b[0]|((uint32_t)b[1]<<8)|((uint32_t)b[2]<<16)|((uint32_t)b[3]<<24);}
void rm_put32(void *p,uint32_t x){uint8_t *b=p;for(unsigned i=0;i<4;++i)b[i]=(uint8_t)(x>>(8*i));}
uint32_t rm_crc(const void *p,uint32_t n){const uint8_t *b=p;uint32_t c=~0u;while(n--){c^=*b++;for(unsigned i=0;i<8;++i)c=(c>>1)^(0xedb88320u& (0u-(c&1u)));}return ~c;}
int rm_header_valid(const uint8_t *h,uint32_t n){
    if(n<RM_HEADER)return 0;
    return rm_u32(h)==RM_MAGIC && rm_u32(h+4)==1 && (rm_u32(h+8)==RM_ABI || rm_u32(h+8)==RM_ABI_RAW_MIDI) && rm_u32(h+12)==241 &&
        rm_u32(h+16)==44100 && rm_u32(h+20)==256 && rm_u32(h+24)==RM_TEXT && rm_u32(h+28)==RM_STATE &&
        rm_u32(h+32)>=84 && rm_u32(h+32)<=RM_IMAGE_MAX && !(rm_u32(h+32)&3u) &&
        rm_u32(h+36)<=RM_STATE_MAX && !(rm_u32(h+36)&3u) &&
        n==RM_HEADER+rm_u32(h+32) && rm_crc(h,48)==rm_u32(h+48) &&
        !rm_u32(h+52) && !rm_u32(h+56) && !rm_u32(h+60);
}
int rm_image_valid(const uint8_t *h,const uint8_t *image){
    if(!rm_header_valid(h,RM_HEADER+rm_u32(h+32)) || rm_crc(image,rm_u32(h+32))!=rm_u32(h+40))return 0;
    if(rm_u32(image)!=RM_API_MAGIC || rm_u32(image+4)!=rm_u32(h+8) || rm_u32(image+8)!=84 || rm_u32(image+12)!=rm_u32(h+44))return 0;
    unsigned terminated=0;for(unsigned i=16;i<48;++i)if(!image[i])terminated=1;
    if(!terminated)return 0;
    for(unsigned i=48;i<84;i+=4){uint32_t p=rm_u32(image+i);if(p<RM_TEXT+84 || p>=RM_TEXT+rm_u32(h+32) || (p&1u))return 0;}
    uint32_t bytes=rm_u32(h+32);
    if(bytes>=100 && rm_u32(image+bytes-16)==RM_VISUAL_FOOTER){
        const uint8_t *footer=image+bytes-16;
        uint32_t n=rm_u32(footer+4),fn=rm_u32(footer+12);
        if(n>bytes-100 || fn<RM_TEXT+84 || fn>=RM_TEXT+bytes-16-n || (fn&1u))return 0;
        const uint8_t *v=footer-n;
        if(rm_crc(v,n)!=rm_u32(footer+8) || !rm_visual_valid(v,n))return 0;
    }
    return 1;
}
