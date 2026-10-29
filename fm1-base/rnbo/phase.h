/* SPDX-License-Identifier: MIT */
#pragma once
#ifndef _RNBO_Std_H_
#include <stdint.h>
#endif
/* Truncate an IEEE binary32 value toward zero, then take its low 32 bits.
 * Matches (uint32_t)(int64_t)x throughout that cast's defined input range,
 * including negative FM frequencies. No FP-to-int64 runtime helper is needed.
 * Huge finite floats have no low 32 bits; non-finite input returns zero. */
static inline uint32_t rnbo_fm1_phase_increment(float x) {
    uint32_t bits;
    __builtin_memcpy(&bits,&x,sizeof bits);
    uint32_t exponent=(bits>>23)&255u;
    if(exponent<127u || exponent==255u)return 0;
    uint32_t shift=exponent-127u;
    if(shift>=55u)return 0;
    uint32_t value=(bits&0x7fffffu)|0x800000u;
    value=shift<23u?value>>(23u-shift):value<<(shift-23u);
    return bits>>31?0u-value:value;
}
