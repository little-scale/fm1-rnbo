/* SPDX-License-Identifier: MIT */
#pragma once
#include "module.h"
extern volatile unsigned loader_busy;
int loader_boot(void);
int loader_receive(uint32_t,uint32_t);
int loader_receive_slot(uint32_t,uint32_t,unsigned);
unsigned loader_slot_number(void);
unsigned loader_slot_mask(void);
void loader_prefer_slot(unsigned);
int loader_select(unsigned);
int loader_cycle(int32_t);
unsigned loader_patch_id(void);
const char *loader_title(void);
int loader_status(void);
int loader_raw_midi(void);
void loader_resume(void);
const uint8_t *loader_visual(void);
float loader_param_actual(unsigned,float);
void loader_reply(uint32_t,uint32_t);
int loader_slot_valid(uint32_t,uint32_t *);
int loader_allow_code(uint32_t);
#ifdef PLAT_HOST
int loader_host_open(const char *);
int loader_host_store(unsigned,const char *);
void loader_host_reboot(void);
#endif
