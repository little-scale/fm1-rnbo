/* SPDX-License-Identifier: MIT */
/* One audio owner for RNBO. The UI publishes bounded commands; it never calls
 * the patch while the audio interrupt could be processing it. */
#include "loader.h"
#include "visual.h"
#ifndef PLAT_HOST
#include "fm1_module_guard.h"
#endif
#define RNBO_FM1_PATCH_ID loader_patch_id()
int loader_allow_code(uint32_t bytes){
#ifndef PLAT_HOST
    extern uint8_t _module_image[];
    uint32_t start=(uint32_t)(uintptr_t)_module_image;
    uint32_t f=plat_lock();
    int rc=fm1_module_allow_ram(start,bytes,start+RM_IMAGE_MAX);
    plat_unlock(f);
    return rc;
#else
    (void)bytes;return 0;
#endif
}
typedef struct { uint32_t magic; int32_t octave; uint32_t count; float value[RNBO_FM1_PARAMS]; } rnbo_settings;
#define BANK_SETTINGS_MAGIC 0x33424e52u
typedef struct { uint32_t magic,selected; rnbo_settings slot[RM_PATCH_SLOTS]; } bank_settings;
static bank_settings settings;
static float param_value[RNBO_FM1_PARAMS];
static const char *param_name[RNBO_FM1_PARAMS];
static uint32_t param_count,keys_last,buttons_last,dirty,queue_drops;
static volatile int32_t last_note;
static volatile uint32_t render_peak_us,render_blocks;
void app_audio_meter(uint32_t peak_us,uint32_t blocks){render_peak_us=peak_us;render_blocks=blocks;}
static uint32_t note_order[128],note_serial;
static uint8_t note_velocity[128];
static uint32_t held_note[27];
static int octave,engine_ok;
static uint32_t knob_bank;
static volatile float actual_value[RNBO_FM1_PARAMS];
static int overlay_parameter=-1;
static uint32_t overlay_at,visual_dirty=1,last_ui_frame;
/* Audio publishes per-channel peaks; UI consumes them with interrupts locked.
 * Measure the signed 24-bit output after the patch's master gain. */
static volatile uint32_t audio_peak[2];
static uint32_t meter_q8[2],meter_clip_hold[2],meter_time;
static void capture_output(const int32_t *lr,uint32_t n){
    uint32_t peak[2]={0,0};
    for(uint32_t i=0;i<n;++i)for(uint32_t ch=0;ch<2;++ch){
        int32_t v=lr[2*i+ch];
        uint32_t a=v<0?0u-(uint32_t)v:(uint32_t)v;
        if(a>peak[ch])peak[ch]=a;
    }
    for(uint32_t ch=0;ch<2;++ch)if(peak[ch]>audio_peak[ch])audio_peak[ch]=peak[ch];
}
static volatile uint32_t panic_due;
static int same(const char *a,const char *b){while(*a && *a==*b){++a;++b;}return *a==*b;}
typedef struct { uint32_t kind,a,b,c; float value; } command;
#define COMMANDS 64u
static command commands[COMMANDS];
static volatile uint32_t qwrite,qread;
static void enqueue(command c) {
    uint32_t f=plat_lock(),w=qwrite;
    if(w-qread>=COMMANDS){++queue_drops;panic_due=1;}
    else {commands[w&(COMMANDS-1u)]=c;qwrite=w+1;}
    plat_unlock(f);
}
static void note_event(uint32_t status,uint32_t note,uint32_t vel) {
    if(note>127 || vel>127)return;
    if((status&0xf0u)==0x90u && vel) {note_velocity[note]=(uint8_t)vel;note_order[note]=++note_serial;}
    else if((status&0xf0u)==0x80u || (status&0xf0u)==0x90u)note_velocity[note]=0;
    else {rnbo_fm1_midi(status,note,vel);return;}
    // ABI 2 instruments own voice allocation and need every note event.
    // Retain mono priority for ABI 1 modules and for the note diagnostic.
    int raw=loader_raw_midi();
    if(raw)rnbo_fm1_midi(status,note,vel);
    uint32_t best=0;int32_t winner=-1;
    for(uint32_t i=0;i<128;++i)if(note_velocity[i] && note_order[i]>=best){winner=(int32_t)i;best=note_order[i];}
    if(!raw && winner<0){if(last_note>=0)rnbo_fm1_midi(0x80,(uint32_t)last_note,0);}
    else if(!raw && (winner!=last_note || ((status&0xf0u)==0x90u && vel)))rnbo_fm1_midi(0x90,(uint32_t)winner,note_velocity[winner]);
    last_note=winner;
}
void app_render(int32_t *lr,uint32_t n,uint32_t master) {
    if(loader_busy){for(uint32_t i=0;i<2*n;++i)lr[i]=0;return;}
    if(panic_due){
        panic_due=0;qread=qwrite;
        for(uint32_t i=0;i<128;++i)note_velocity[i]=0;
        rnbo_fm1_panic();last_note=-1;
    }
    for(uint32_t count=0;count<COMMANDS && qread!=qwrite;++count){
        command c=commands[qread&(COMMANDS-1u)];++qread;
        if(c.kind==1)note_event(c.a,c.b,c.c);
        else if(c.kind==2){rnbo_fm1_set_param(c.a,c.value);actual_value[c.a]=loader_param_actual(c.a,c.value);}
    }
    uint32_t packet;int port;
    for(uint32_t count=0;count<64 && plat_midi_in(&packet,&port);++count){
        (void)port;uint32_t status=(packet>>8)&255u;
        if(status<0xf0u)note_event(status,(packet>>16)&127u,(packet>>24)&127u);
    }
    rnbo_fm1_render((int*)lr,n,master);
    capture_output(lr,n);
}
void app_panic(void){panic_due=1;}
void app_init(void) {
    audio_peak[0]=audio_peak[1]=meter_q8[0]=meter_q8[1]=0;
    meter_clip_hold[0]=meter_clip_hold[1]=0;meter_time=plat_ms();
    qwrite=qread=panic_due=0;keys_last=buttons_last=dirty=queue_drops=0;last_note=-1;note_serial=0;
    for(uint32_t i=0;i<128;++i){note_velocity[i]=0;note_order[i]=0;}
    for(uint32_t i=0;i<27;++i)held_note[i]=0;
    int size=plat_store_load(OBJ_SETTINGS,&settings,sizeof settings);
    if(size!=(int)sizeof settings || settings.magic!=BANK_SETTINGS_MAGIC || settings.selected>RM_PATCH_SLOTS){
        settings=(bank_settings){.magic=BANK_SETTINGS_MAGIC};
        // Existing single-patch settings migrate to logical slot 1.
        rnbo_settings legacy;
        if(size==(int)sizeof legacy && plat_store_load(OBJ_SETTINGS,&legacy,sizeof legacy)==(int)sizeof legacy)settings.slot[0]=legacy;
    }
    loader_prefer_slot(settings.selected);
    overlay_parameter=-1;visual_dirty=1;
    engine_ok=rnbo_fm1_init();param_count=rnbo_fm1_param_count();octave=0;knob_bank=0;
    unsigned number=loader_slot_number();rnbo_settings *saved=&settings.slot[number?number-1:0];
    int valid=saved->magic==RNBO_FM1_PATCH_ID && saved->count==param_count && saved->octave>=-2 && saved->octave<=2;
    for(uint32_t i=0;i<param_count;++i)if(!(saved->value[i]>=0 && saved->value[i]<=1))valid=0;
    if(valid)octave=saved->octave;
    for(uint32_t i=0;i<param_count;++i){
        param_name[i]=rnbo_fm1_param_name(i);
        param_value[i]=valid?saved->value[i]:rnbo_fm1_param_normalized(i);
        rnbo_fm1_set_param(i,param_value[i]);actual_value[i]=loader_param_actual(i,param_value[i]);
    }
}
static void input(void) {
    touch_poll();uint32_t keys=touch_keys(),buttons=plat_buttons();
    int32_t presets=plat_enc(EN_PRESET);
    if(presets && loader_cycle(presets)){
        app_init();
        // A held physical key must be released before triggering the new patch.
        keys_last=keys;buttons_last=buttons;
        for(unsigned k=0;k<27;++k)held_note[k]=128; // ignore releases belonging to the old patch
        for(int e=0;e<NE;++e)(void)plat_enc(e);
        loader_resume();app_ui_init();return;
    }
    for(uint32_t k=0;k<27;++k){
        uint32_t bit=1u<<k;
        if((keys&bit) && !(keys_last&bit)){
            uint32_t note=(uint32_t)(53+(int32_t)k+12*octave);held_note[k]=note;
            enqueue((command){1,0x90,note,touch_vel(k),0});
        }else if(!(keys&bit) && (keys_last&bit))enqueue((command){1,0x80,held_note[k],0,0});
    }
    uint32_t rising=buttons&~buttons_last;
    // Apply the button edge before routing this frame's encoder deltas.
    if(rising&(1u<<B_FX)){knob_bank^=1u;overlay_parameter=-1;visual_dirty=1;}
    for(uint32_t k=0;k<4;++k){
        int32_t turns=plat_enc(EN_K1+(int)k);
        uint32_t i=knob_bank*4u+k;
        // Always drain every encoder, including an empty bank.
        if(i<param_count && turns){
            float v=param_value[i]+(float)turns*.01f;v=v<0?0:v>1?1:v;
            param_value[i]=v;dirty=1;overlay_parameter=(int)i;overlay_at=plat_ms();visual_dirty=1;enqueue((command){2,i,0,0,v});
        }
    }
    (void)plat_enc(EN_SELECT);(void)plat_enc(EN_ALGO);
    if(rising&(1u<<B_OCTUP)){if(octave<2){++octave;dirty=1;}}
    if(rising&(1u<<B_OCTDN)){if(octave> -2){--octave;dirty=1;}}
    if(rising&(1u<<B_PLAY))panic_due=1;
    if(rising&(1u<<B_SAVE)){
        unsigned number=loader_slot_number();rnbo_settings *saved=&settings.slot[number?number-1:0];
        settings.selected=number;saved->magic=RNBO_FM1_PATCH_ID;saved->count=param_count;saved->octave=octave;
        for(uint32_t i=0;i<param_count;++i)saved->value[i]=param_value[i];
        if(plat_store_save(OBJ_SETTINGS,&settings,sizeof settings)==0)dirty=0;
    }
    keys_last=keys;buttons_last=buttons;
    plat_glow(1);plat_leds(buttons|(dirty?1u<<B_SAVE:0)|(knob_bank?1u<<B_FX:0),keys);
}
static void number_text(uint32_t n,char *out){char b[12];uint32_t i=0;do{b[i++]=(char)('0'+n%10);n/=10;}while(n);uint32_t j=0;while(i)out[j++]=b[--i];out[j]=0;}
/* Player palette: #404040 background, existing label grey, white values. */
#define PLAYER_BG RGB(64,64,64)
#include "battery.h"
/* Twenty segments at 3 dB intervals, -57 to 0 dBFS. No audio-rate logs. */
static void draw_output_meter(void){
    static const uint32_t threshold[20]={11849u,16737u,23642u,33396u,47173u,66633u,94122u,132950u,187798u,265271u,374705u,529285u,747635u,1056063u,1491729u,2107123u,2976390u,4204263u,5938679u,8388607u};
    uint32_t peak[2],f=plat_lock();
    for(uint32_t ch=0;ch<2;++ch){peak[ch]=audio_peak[ch];audio_peak[ch]=0;}
    plat_unlock(f);
    uint32_t now=plat_ms(),dt=now-meter_time;meter_time=now;
    if(dt>2000)dt=2000;
    for(uint32_t ch=0;ch<2;++ch){
        uint32_t level=0;
        while(level<20 && peak[ch]>=threshold[level])++level;
        uint32_t fall=dt*256u/60u;
        uint32_t previous=meter_q8[ch]>fall?meter_q8[ch]-fall:0;
        meter_q8[ch]=previous>level*256u?previous:level*256u;
        // Near-full-scale warning for this output, held for 600 ms.
        if(peak[ch]>=0x7f0000u)meter_clip_hold[ch]=600u;
        else meter_clip_hold[ch]=meter_clip_hold[ch]>dt?meter_clip_hold[ch]-dt:0;
        int warning=meter_clip_hold[ch]>0;
        int32_t y=18+(int32_t)ch*11;
        cv_text(8,y-3,&FONT_T,ch?"R":"L",C_GRAY);
        for(uint32_t seg=0;seg<20;++seg)
            cv_rect(22+(int32_t)seg*10,y,8,5,meter_q8[ch]>seg*256u?C_WHITE:RGB(80,80,80));
        cv_rect(225,y,5,5,warning?RGB(255,80,80):RGB(80,80,80));
    }
}
#include "visual-ui.h"
static void draw_list(void){
    char text[24];
    for(uint32_t i=0;i<8;++i){
        cv_begin(240,18,PLAYER_BG);
        if(i>=param_count){cv_blit(0,32+18*i);continue;}
        int active=i/4u==knob_bank;
        cv_text(2,1,&FONT_XS,active?">":"",C_WHITE);
        char name[22];uint32_t j=0;int word_start=1;const char *s=param_name[i];
        while(j<21 && s[j]){
            char c=s[j];
            if(c>='A' && c<='Z')c=(char)(c+('a'-'A'));
            if(c>='a' && c<='z'){
                name[j]=word_start?(char)(c-('a'-'A')):c;word_start=0;
            }else{
                name[j]=c;word_start=(c==' ' || c=='_' || c=='-' || c=='/');
            }
            ++j;
        }name[j]=0;
        // Keep long patch labels out of the value column.
        while(j && text_w(&FONT_B,name)>158)name[--j]=0;
        cv_text(12,1,&FONT_B,name,C_GRAY);number_text((uint32_t)(param_value[i]*100+.5f),text);
        cv_text(206-text_w(&FONT_B,text),1,&FONT_B,text,C_WHITE);
        cv_text(213,3,&FONT_XS,"%",C_WHITE);cv_blit(0,32+18*i);
    }
}
static void draw(void){
    char text[32];
    if(overlay_parameter>=0 && plat_ms()-overlay_at>=1500u){overlay_parameter=-1;visual_dirty=1;}
    cv_begin(240,30,PLAYER_BG);
    char title[25];const char *source=engine_ok?loader_title():"Upload A Patch";unsigned j=0;
    while(j<24 && source[j]){title[j]=source[j];++j;}title[j]=0;
    while(j && text_w(&FONT_XS,title)>180)title[--j]=0;
    cv_text(5,2,&FONT_XS,title,C_WHITE);battery_draw();
    cv_text(5,17,&FONT_T,knob_bank?"Knobs 5 - 8":"Knobs 1 - 4",C_GRAY);
    cv_text(146,17,&FONT_T,"Slot",C_GRAY);number_text(loader_slot_number(),text);cv_text(170,17,&FONT_T,text,C_WHITE);
    cv_text(184,17,&FONT_T,dirty?"*":"",C_WHITE);cv_blit(0,0);
    if(loader_visual()){
        if(visual_dirty || overlay_parameter>=0){draw_visual();visual_dirty=0;}
    }else{
        draw_list();
        if(overlay_parameter>=0)draw_parameter_overlay(0);
    }
    cv_begin(240,44,PLAYER_BG);
    cv_text(8,0,&FONT_T,"CPU",C_GRAY);number_text(plat_cpu_pct(),text);cv_text(34,0,&FONT_T,text,C_WHITE);
    cv_text(64,0,&FONT_T,"%",C_GRAY);cv_text(100,0,&FONT_T,"Play: Panic",C_GRAY);
    draw_output_meter();cv_blit(0,196);
}
void app_ui_init(void){touch_on(1);lcd_fill(0,0,240,240,PLAYER_BG);draw();}
void app_frame(void){input();battery_poll();if(plat_ms()-last_ui_frame>=40u){last_ui_frame=plat_ms();draw();}}
void app_input_only(void){input();}
void app_say(const char *a,const char *b){(void)a;(void)b;}
int app_expect(const char *s,int *v){
    if(same(s,"note"))*v=last_note;
    else if(same(s,"octave"))*v=octave;
    else if(same(s,"dirty"))*v=(int)dirty;
    else if(same(s,"rnbo_ok"))*v=engine_ok;
    else if(same(s,"params"))*v=(int)param_count;
    else if(same(s,"drops"))*v=(int)queue_drops;
    else if(same(s,"visual"))*v=loader_visual()!=0;
    else if(same(s,"overlay"))*v=overlay_parameter;
    else if(same(s,"battery"))*v=battery_bars;
    else if(same(s,"battery_usb"))*v=battery_usb;
    else if(same(s,"actual"))*v=overlay_parameter>=0?(int)(actual_value[overlay_parameter]*100.f+.5f):-1;
    else if(same(s,"bank"))*v=(int)knob_bank;
    else if(same(s,"raw_midi"))*v=loader_raw_midi();
    else if(same(s,"patch_slot"))*v=(int)loader_slot_number();
    else if(same(s,"patch_slots"))*v=(int)loader_slot_mask();
    else if(same(s,"meter_left"))*v=meter_q8[0]>0;
    else if(same(s,"meter_right"))*v=meter_q8[1]>0;
    else if(s[0]=='p' && s[1]=='a' && s[2]=='r' && s[3]=='a' && s[4]=='m' && s[5]>='0' && s[5]<='7' && s[6]==0)
        *v=(int)(param_value[s[5]-'0']*100+.5f);
    else if(s[0]=='d' && s[1]=='s' && s[2]=='p' && s[3]>='0' && s[3]<='7' && s[4]==0)
        *v=(int)(rnbo_fm1_param_normalized((unsigned)(s[3]-'0'))*100+.5f);
    else if(same(s,"faults")){rnbo_fm1_stats st;rnbo_fm1_get_stats(&st);*v=(int)(st.errors+st.late_allocations+st.bad_samples);}
    else return 0;return 1;
}

/* Commands 0x68..0x6a are private to this experimental module player. */
void loader_reply(uint32_t command,uint32_t status){
    uint8_t raw[34]={0,0x59,(uint8_t)command,28,0,0},wire[44];
    rm_put32(raw+6,status);rm_put32(raw+10,loader_patch_id());rm_put32(raw+14,plat_cpu_pct());rm_put32(raw+18,plat_xruns());rm_put32(raw+22,RM_ABI_RAW_MIDI);
    uint32_t meter_lock=plat_lock();
    rm_put32(raw+26,render_peak_us);rm_put32(raw+30,render_blocks);
    plat_unlock(meter_lock);
    uint8_t sum=0;for(unsigned i=6;i<34;++i)sum+=raw[i];
    wire[0]=0xf0;unsigned j=1,acc=0,bits=0;
    for(unsigned i=0;i<35;++i){unsigned v=i==34?(uint8_t)~sum:raw[i];acc|=v<<bits;bits+=8;while(bits>=7){wire[j++]=acc&127;acc>>=7;bits-=7;}}
    if(bits)wire[j++]=acc&127;wire[j++]=0xf7;plat_sysex_send(wire,j);
}
void app_usb_cmd(const uint8_t *d,uint32_t n){
    if(n==7 && d[2]==0x68){loader_reply(0x69,(uint32_t)loader_status());return;}
    if(n==7 && d[2]==0x6c){
        uint8_t raw[23]={0,0x59,0x6d,16,0,0},wire[32];
        rm_put32(raw+6,1);rm_put32(raw+10,RM_PATCH_SLOTS);
        rm_put32(raw+14,loader_slot_number());rm_put32(raw+18,loader_slot_mask());
        uint8_t sum=0;for(unsigned i=6;i<22;++i)sum+=raw[i];raw[22]=(uint8_t)~sum;
        wire[0]=0xf0;unsigned j=1,acc=0,bits=0;
        for(unsigned i=0;i<23;++i){acc|=(unsigned)raw[i]<<bits;bits+=8;while(bits>=7){wire[j++]=acc&127;acc>>=7;bits-=7;}}
        if(bits)wire[j++]=acc&127;wire[j++]=0xf7;plat_sysex_send(wire,j);return;
    }
    if(!((n==15 && d[2]==0x6a) || (n==19 && d[2]==0x6e)))return;
    // Even a rejected length goes through the UI reset below. Keep its RNBO
    // parameter writes out of the audio interrupt for that failure path too.
    uint32_t f=plat_lock();loader_busy=1;plat_unlock(f);
    int rc=d[2]==0x6e?loader_receive_slot(rm_u32(d+6),rm_u32(d+10),rm_u32(d+14)):loader_receive(rm_u32(d+6),rm_u32(d+10));
    app_init();loader_resume();app_ui_init();loader_reply(0x6b,(uint32_t)rc);
}
#ifdef PLAT_HOST
int app_host_cmd(const char *cmd,const char *a,const char *b,const char *c,const char *d){
    (void)c;(void)d;
    if(!same(cmd,"patch") && !same(cmd,"patchslot"))return 0;
    loader_busy=1;int ok=same(cmd,"patch")?loader_host_open(a):
        (a && a[0]>='1' && a[0]<='3' && !a[1]?loader_host_store((unsigned)(a[0]-'0'),b):0);
    app_init();loader_resume();app_ui_init();return ok;
}
void app_host_reboot(void){loader_host_reboot();}
#endif
