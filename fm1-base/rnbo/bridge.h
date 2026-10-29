/* SPDX-License-Identifier: MIT */
#pragma once
#ifdef __cplusplus
extern "C" {
#endif
#define RNBO_FM1_BLOCK 256u
#define RNBO_FM1_RATE 44100u
#define RNBO_FM1_PARAMS 16u
typedef struct {
    unsigned int pool_used, pool_capacity, allocations, late_allocations;
    unsigned int errors, blocks, bad_samples;
} rnbo_fm1_stats;
int rnbo_fm1_init(void);
void rnbo_fm1_render(int *stereo, unsigned int frames, unsigned int gain_q12);
void rnbo_fm1_midi(unsigned int status, unsigned int d1, unsigned int d2);
void rnbo_fm1_panic(void);
unsigned int rnbo_fm1_param_count(void);
const char *rnbo_fm1_param_name(unsigned int index);
float rnbo_fm1_param_normalized(unsigned int index);
void rnbo_fm1_set_param(unsigned int index, float normalized);
void rnbo_fm1_get_stats(rnbo_fm1_stats *stats);
#ifdef __cplusplus
}
#endif
