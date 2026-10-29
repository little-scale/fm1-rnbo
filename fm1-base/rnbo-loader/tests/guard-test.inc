/* Exercise the exact BSP extension with fake register lvalues, not hardware. */
#include <stdio.h>
#define FM1_MODULE_GUARD_BASE "guard-base.inc"
#include "fm1_module_guard.h"
static int permits(uint32_t pc){return (pc>=pc0_low && pc<=pc0_high)||(pc>=pc1_low && pc<=pc1_high);}
int main(void){
    assert(permits(0x02001000u) && permits(0x01c00080u));
    // Reproduce the original configuration: an address in a valid module
    // image is outside both PC windows, despite passing package validation.
    assert(!permits(0x01c34054u));
    assert(!fm1_module_allow_ram(0x01c34000u,19116u,0x01c44000u));
    assert(permits(0x01c34054u) && permits(0x01c36632u));
    assert(permits(0x01c00080u) && permits(0x02001000u));
    assert(!permits(0x01c44000u) && !permits(0x01c74000u));
    assert(pc1_high==0x01c34000u+19116u-1u);
    assert(pc0_low==0x02000120u && pc0_high==0x02014000u && enabled==0x003f0030u && write_guard==7);
    uint32_t high=pc1_high;
    const uint32_t bad[][3]={{0x01c34000u,0,0x01c44000u},{0x01c34000u,65538u,0x01c44000u},{0x01c34001u,100u,0x01c44000u},{0x01c34000u,101u,0x01c44000u},{0x01c00000u,100u,0x01c44000u},{0x01c34000u,100u,0x01c80000u},{0xfffffff0u,100u,0xffffffffu}};
    for(unsigned i=0;i<sizeof bad/sizeof bad[0];++i){assert(fm1_module_allow_ram(bad[i][0],bad[i][1],bad[i][2])==-1);assert(pc1_high==high && locks==1 && unlocks==1 && !unlocked);}
    // Switching to a smaller image also narrows the window again.
    assert(!fm1_module_allow_ram(0x01c34000u,1000u,0x01c44000u));
    assert(!permits(0x01c36632u) && locks==2 && unlocks==2);
    puts("PASS exact BSP PC-window extension: reproduce blocked entry, allow module, preserve XIP/flash/other guards, reject overflow and shrink on switch");
}
