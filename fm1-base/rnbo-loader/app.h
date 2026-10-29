/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdint.h>
#include "plat.h"
#define APP_NAME "RNBO PLAYER"
#define APP_TAGLINE "LOADABLE PATCHES"
#define APP_BLOCK 256u
#define APP_CANVAS_PX (240u * 64u)
#define APP_TOUCH
#define APP_BLE_AT_BOOT 0
#ifndef PLAT_HOST
/* APP_GAIN expands inside render_block after the platform diagnostics exist.
 * Sample the previous completed callback while preserving the default gain. */
void app_audio_meter(uint32_t peak_us,uint32_t blocks);
#define APP_GAIN(m) (app_audio_meter(fm1b_dbg.max_us,fm1b_dbg.halves),((uint32_t)(m)*(uint32_t)(m))>>12)
#endif
enum { OBJ_SETTINGS,OBJ_PANEL,OBJ_NOBJ };
#define APP_STORE_MAP {0xFC000u,0xDC000u}
void app_init(void);
void app_render(int32_t *,uint32_t,uint32_t);
void app_panic(void);
void app_ui_init(void);
void app_frame(void);
void app_input_only(void);
void app_say(const char *,const char *);
#define APP_HOST_EXPECT
int app_expect(const char *,int *);

#define APP_USB_CMD
void app_usb_cmd(const uint8_t *,uint32_t);
#ifdef PLAT_HOST
#define APP_HOST_CMD
#define APP_HOST_REBOOT
void app_host_reboot(void);
int app_host_cmd(const char *,const char *,const char *,const char *,const char *);
#endif
