/* SPDX-License-Identifier: MIT
 * Optional, CRC-protected metadata trailer; the original module ABI is intact.
 * Header: magic,u16 version,nodes,segments,params,width,height.
 * Nodes: x,y,w,h,param,inlets,outlets,flags + NUL-terminated 16-byte label.
 * Flag bit 0 marks Gen; legacy nodes use zero (RNBO). Segments: 4 bytes.
 * Parameters: NUL-terminated 12-byte unit. All coordinates are precomputed.
 */
#pragma once
#define RM_VISUAL_MAGIC 0x31564952u
#define RM_VISUAL_FOOTER 0x31545652u
#define RM_VISUAL_NODE_GEN 0x01u
static uint32_t rm_u16(const uint8_t *p){return p[0]|((uint32_t)p[1]<<8);}
static int rm_visual_valid(const uint8_t *p,uint32_t n){
    if(n<16 || n>8192 || rm_u32(p)!=RM_VISUAL_MAGIC || rm_u16(p+4)!=1 || rm_u16(p+12)!=240 || rm_u16(p+14)!=166)return 0;
    uint32_t nodes=rm_u16(p+6),lines=rm_u16(p+8),params=rm_u16(p+10);
    uint32_t need=16+24*nodes+4*lines+12*params;
    if(!nodes || nodes>96 || lines>384 || params>16 || need>n || n-need>3)return 0;
    for(uint32_t i=0;i<nodes;++i){
        const uint8_t *b=p+16+24*i;
        if(!b[2] || !b[3] || b[0]+b[2]>240 || b[1]+b[3]>166 || (b[4]!=255 && b[4]>=params) || b[23])return 0;
    }
    const uint8_t *s=p+16+24*nodes;
    for(uint32_t i=0;i<lines;++i,s+=4)if(s[0]>=240 || s[1]>=166 || s[2]>=240 || s[3]>=166)return 0;
    for(uint32_t i=0;i<params;++i)if(s[12*i+11])return 0;
    return 1;
}
