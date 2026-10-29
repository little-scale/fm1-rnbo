/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdint.h>
#include "plat.h"
#define APP_NAME "RNBO"
#define APP_TAGLINE "MONO EXPORT PROBE"
#define APP_BLOCK 256u
#define APP_CANVAS_PX (240u * 64u)
#define APP_TOUCH
#define APP_BLE_AT_BOOT 0
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
