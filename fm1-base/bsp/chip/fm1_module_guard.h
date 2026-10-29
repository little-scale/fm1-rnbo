/* SPDX-License-Identifier: MIT */
/* Optional RAM-module extension. Existing BSP files are unchanged.
 * The CPU has two PC windows. Keep window 0 (XIP) untouched, and extend
 * window 1 to the envelope of flash RAM routines and a validated module.
 * Stack, write, bus and reserved-top guards remain in force. */
#pragma once
#ifndef FM1_MODULE_GUARD_BASE
#define FM1_MODULE_GUARD_BASE "fm1_guard.h"
#endif
#include FM1_MODULE_GUARD_BASE

/* Caller must disable interrupts while changing the window. limit is the
 * reserved image's exclusive end, never the module's writable state area. */
static int fm1_module_allow_ram(uint32_t start,uint32_t bytes,uint32_t limit)
{
    uint32_t low=(uint32_t)(uintptr_t)_rt_start;
    uint32_t rt_end=(uint32_t)(uintptr_t)_rt_end;
    uint32_t guard=(uint32_t)(uintptr_t)_guard0;
    if(low>=rt_end || start<rt_end || start>=limit || limit>guard ||
       !bytes || bytes>limit-start || (start&1u) || (bytes&1u))return -1;
    fm1__dbg_unlock();
    FM1_PC_LIMIT1_L=low;
    FM1_PC_LIMIT1_H=start+bytes-1u;
    fm1__dbg_lock();
    return 0;
}
