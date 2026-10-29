/* SPDX-License-Identifier: MIT */
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "module.h"
#include "visual.h"
static unsigned char image[1024],head[64];
static void crc(void){rm_put32(head+40,rm_crc(image,sizeof image));rm_put32(head+48,rm_crc(head,48));}
int main(void){
    uint32_t h[]={RM_MAGIC,1,1,241,44100,256,RM_TEXT,RM_STATE,1024,1024,0,123,0,0,0,0};
    memcpy(head,h,64);rm_put32(image,RM_API_MAGIC);rm_put32(image+4,1);rm_put32(image+8,84);rm_put32(image+12,123);
    for(unsigned i=48;i<84;i+=4)rm_put32(image+i,RM_TEXT+84);
    crc();assert(rm_image_valid(head,image)); // Legacy module stays compatible.
    // One 24-byte node + header = 40 bytes, aligned; deliberately exercise
    // corrected trailer positions through the same validator used at boot.
    unsigned char v[40]={0};rm_put32(v,RM_VISUAL_MAGIC);v[4]=1;v[6]=1;v[12]=240;v[14]=166;
    v[16]=4;v[17]=4;v[18]=20;v[19]=12;v[20]=255;memcpy(v+24,"saw~",5);
    assert(rm_visual_valid(v,sizeof v));
    memcpy(image+968,v,40);rm_put32(image+1008,RM_VISUAL_FOOTER);rm_put32(image+1012,40);rm_put32(image+1016,rm_crc(v,40));rm_put32(image+1020,RM_TEXT+84);crc();
    assert(rm_image_valid(head,image));
    for(unsigned n=0;n<40;++n)assert(!rm_visual_valid(v,n));
    rm_put32(image+1012,0xffffffffu);crc();assert(!rm_image_valid(head,image));
    rm_put32(image+1012,40);rm_put32(image+1020,RM_TEXT+968);crc();assert(!rm_image_valid(head,image));
    rm_put32(image+1020,RM_TEXT+84);
    image[968+18]=255;rm_put32(image+1016,rm_crc(image+968,40));crc();assert(!rm_image_valid(head,image));
    image[968+18]=20;image[968+20]=0;rm_put32(image+1016,rm_crc(image+968,40));crc();assert(!rm_image_valid(head,image));
    // Fuzz bounded input, including sizes too short to hold a header.
    uint32_t random=17;for(unsigned k=0;k<20000;++k){
        random=random*1664525u+1013904223u;unsigned at=random%40;v[at]^=(uint8_t)(random>>24);
        (void)rm_visual_valid(v,k%41);
    }
    puts("PASS legacy module, visual CRC/pointer/size/coordinate/parameter bounds and 20000 sanitizer mutations");
}
