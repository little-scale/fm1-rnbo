/* Register mock, used only by guard-test.inc on the host. */
#include <stdint.h>
#include <assert.h>
#define _rt_start ((uint32_t *)(uintptr_t)0x01c00000u)
#define _rt_end ((uint32_t *)(uintptr_t)0x01c00bb8u)
#define _guard0 ((char *)(uintptr_t)0x01c74000u)
static uint32_t pc0_low=0x02000120u,pc0_high=0x02014000u;
static uint32_t pc1_low=0x01c00000u,pc1_high=0x01c00bb7u;
static uint32_t enabled=0x003f0030u,write_guard=7u,locks,unlocks;
static int unlocked;
#define FM1_PC_LIMIT1_L pc1_low
#define FM1_PC_LIMIT1_H pc1_high
static void fm1__dbg_unlock(void){assert(!unlocked);unlocked=1;++unlocks;}
static void fm1__dbg_lock(void){assert(unlocked);unlocked=0;++locks;}
