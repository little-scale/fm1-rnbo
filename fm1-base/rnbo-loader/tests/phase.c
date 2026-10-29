/* SPDX-License-Identifier: MIT */
#include "../../rnbo/phase.h"
#include <assert.h>
#include <stdio.h>
static unsigned comparisons;
static void check(float x){
    if(x>=-0x1p63f && x<0x1p63f){
        assert(rnbo_fm1_phase_increment(x)==(uint32_t)(int64_t)x);++comparisons;
    }
}
int main(void){
    const float edge[]={0,-0.0f,0.5f,-0.5f,1,-1,1.999f,-1.999f,
        0x1p31f,-0x1p31f,0x1p32f,-0x1p32f,0x1p32f-256,0x1p32f+512,
        -0x1p32f+256,-0x1p32f-512,0x1p54f,-0x1p54f,0x1p55f,-0x1p55f,
        0x1p62f,-0x1p63f};
    for(unsigned i=0;i<sizeof(edge)/sizeof(edge[0]);++i)check(edge[i]);
    uint32_t bits=0x12345678u;
    for(unsigned i=0;i<2000000;++i){
        bits^=bits<<13;bits^=bits>>17;bits^=bits<<5;
        float x;__builtin_memcpy(&x,&bits,4);check(x);
    }
    uint32_t special[]={0x7f800000u,0xff800000u,0x7fc00001u,0x7f7fffffu,0xff7fffffu};
    for(unsigned i=0;i<5;++i){float x;__builtin_memcpy(&x,special+i,4);assert(rnbo_fm1_phase_increment(x)==0);}
    printf("PASS phase conversion: %u defined-range reference comparisons across 2 million bit patterns, signed wrap boundaries and non-finite inputs (UBSan)\n",comparisons);
}
