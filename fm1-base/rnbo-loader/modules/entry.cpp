/* SPDX-License-Identifier: MIT */
#include "../../rnbo/bridge.cpp"
#include "../module.h"
#if defined(PLAT_HOST) && defined(RNBO_FM1_VISUAL_SOURCE)
#include RNBO_FM1_VISUAL_SOURCE
#endif
// Called only by the audio owner (or initialization while audio is stopped).
// Use RNBO's conversion so exponents and stepped parameters match the DSP.
extern "C" __attribute__((visibility("default"))) float rnbo_fm1_param_actual(unsigned i,float normalized){
    return ready && i<rnbo_fm1_param_count()?patch->convertFromNormalizedParameterValue(i,normalized):0;
}
#ifndef PLAT_HOST
static_assert(sizeof(rm_api)==84,"Fixed pi32v2 module API layout");
#endif
#ifndef RNBO_MODULE_TITLE
#define RNBO_MODULE_TITLE "RNBO PATCH"
#endif
extern "C" {
#ifdef __APPLE__
#define MODULE_ATTR __attribute__((used,visibility("default")))
#else
#define MODULE_ATTR __attribute__((section(".module_api"),used,visibility("default")))
#endif
extern const rm_api rnbo_module MODULE_ATTR={
    RM_API_MAGIC,
#if defined(RNBO_FM1_POLYPHONY) && RNBO_FM1_POLYPHONY > 1
    RM_ABI_RAW_MIDI,
#else
    RM_ABI,
#endif
    sizeof(rm_api),RNBO_FM1_PATCH_ID,RNBO_MODULE_TITLE,
    rnbo_fm1_init,rnbo_fm1_render,rnbo_fm1_midi,rnbo_fm1_panic,
    rnbo_fm1_param_count,rnbo_fm1_param_name,rnbo_fm1_param_normalized,rnbo_fm1_set_param,rnbo_fm1_get_stats
};
}
