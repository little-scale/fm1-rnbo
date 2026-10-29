/* SPDX-License-Identifier: MIT */
#pragma once
#ifndef _RNBO_Std_H_
#include <stdint.h>
#endif
#include "../rnbo/bridge.h"
#define RM_MAGIC 0x314d4e52u
#define RM_API_MAGIC 0x31495041u
#define RM_ABI 1u
/* ABI 1 receives mono-priority notes; ABI 2 receives unmerged MIDI notes.
 * The native table layout is identical; old players reject ABI 2 safely. */
#define RM_ABI_RAW_MIDI 2u
#define RM_TEXT 0x01c34000u
#define RM_STATE 0x01c44000u
#define RM_IMAGE_MAX 65536u
#define RM_STATE_MAX 180224u
#define RM_HEADER 64u
#define RM_SLOT_BYTES 69632u
#define RM_SLOT_A 0x98000u
#define RM_SLOT_B (RM_SLOT_A+RM_SLOT_BYTES)
#define RM_PHYSICAL_SLOTS 4u
#define RM_PATCH_SLOTS 3u
#define RM_BANK_END (RM_SLOT_A+RM_PHYSICAL_SLOTS*RM_SLOT_BYTES)
#define RM_COMMIT_MAGIC 0x314b4f52u
#define RM_BANK_COMMIT_MAGIC 0x324b4f52u
typedef struct {
    uint32_t magic,abi,bytes,patch_id;
    char title[32];
    int (*init)(void);
    void (*render)(int *,unsigned,unsigned);
    void (*midi)(unsigned,unsigned,unsigned);
    void (*panic)(void);
    unsigned (*count)(void);
    const char *(*name)(unsigned);
    float (*value)(unsigned);
    void (*set)(unsigned,float);
    void (*stats)(rnbo_fm1_stats *);
} rm_api;
uint32_t rm_crc(const void *,uint32_t);
uint32_t rm_u32(const void *);
void rm_put32(void *,uint32_t);
int rm_header_valid(const uint8_t *,uint32_t);
int rm_image_valid(const uint8_t *,const uint8_t *);
