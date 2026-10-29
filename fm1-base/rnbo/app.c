/* SPDX-License-Identifier: MIT */
/* One audio owner for RNBO. The UI publishes bounded commands; it never calls
 * the patch while the audio interrupt could be processing it. */
#include "bridge.h"
#include "export/patch_config.h"
typedef struct { uint32_t magic; int32_t octave; uint32_t count; float value[RNBO_FM1_PARAMS]; } rnbo_settings;
static rnbo_settings saved;
static float param_value[RNBO_FM1_PARAMS];
static const char *param_name[RNBO_FM1_PARAMS];
static uint32_t param_count,keys_last,buttons_last,dirty,queue_drops;
static volatile int32_t last_note;
static uint32_t note_order[128],note_serial;
static uint8_t note_velocity[128];
static uint32_t held_note[27];
static int octave,engine_ok;
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
    // Merge the keyboard and MIDI into one monophonic last-note-priority voice.
    uint32_t best=0;int32_t winner=-1;
    for(uint32_t i=0;i<128;++i)if(note_velocity[i] && note_order[i]>=best){winner=(int32_t)i;best=note_order[i];}
    if(winner<0){if(last_note>=0)rnbo_fm1_midi(0x80,(uint32_t)last_note,0);}
    else if(winner!=last_note || ((status&0xf0u)==0x90u && vel))rnbo_fm1_midi(0x90,(uint32_t)winner,note_velocity[winner]);
    last_note=winner;
}
void app_render(int32_t *lr,uint32_t n,uint32_t master) {
    if(panic_due){
        panic_due=0;qread=qwrite;
        for(uint32_t i=0;i<128;++i)note_velocity[i]=0;
        rnbo_fm1_panic();last_note=-1;
    }
    for(uint32_t count=0;count<COMMANDS && qread!=qwrite;++count){
        command c=commands[qread&(COMMANDS-1u)];++qread;
        if(c.kind==1)note_event(c.a,c.b,c.c);
        else if(c.kind==2)rnbo_fm1_set_param(c.a,c.value);
    }
    uint32_t packet;int port;
    for(uint32_t count=0;count<64 && plat_midi_in(&packet,&port);++count){
        (void)port;uint32_t status=(packet>>8)&255u;
        if(status<0xf0u)note_event(status,(packet>>16)&127u,(packet>>24)&127u);
    }
    rnbo_fm1_render((int*)lr,n,master);
}
void app_panic(void){panic_due=1;}
void app_init(void) {
    qwrite=qread=panic_due=0;keys_last=buttons_last=dirty=queue_drops=0;last_note=-1;note_serial=0;
    for(uint32_t i=0;i<128;++i){note_velocity[i]=0;note_order[i]=0;}
    for(uint32_t i=0;i<27;++i)held_note[i]=0;
    engine_ok=rnbo_fm1_init();param_count=rnbo_fm1_param_count();octave=0;
    int valid=plat_store_load(OBJ_SETTINGS,&saved,sizeof saved)==(int)sizeof saved && saved.magic==RNBO_FM1_PATCH_ID && saved.count==param_count && saved.octave>=-2 && saved.octave<=2;
    for(uint32_t i=0;i<param_count;++i)if(!(saved.value[i]>=0 && saved.value[i]<=1))valid=0;
    if(valid)octave=saved.octave;
    for(uint32_t i=0;i<param_count;++i){
        param_name[i]=rnbo_fm1_param_name(i);
        param_value[i]=valid?saved.value[i]:rnbo_fm1_param_normalized(i);
        rnbo_fm1_set_param(i,param_value[i]);
    }
}
static void input(void) {
    touch_poll();uint32_t keys=touch_keys(),buttons=plat_buttons();
    for(uint32_t k=0;k<27;++k){
        uint32_t bit=1u<<k;
        if((keys&bit) && !(keys_last&bit)){
            uint32_t note=(uint32_t)(53+(int32_t)k+12*octave);held_note[k]=note;
            enqueue((command){1,0x90,note,touch_vel(k),0});
        }else if(!(keys&bit) && (keys_last&bit))enqueue((command){1,0x80,held_note[k],0,0});
    }
    for(uint32_t i=0;i<param_count && i<4;++i){
        int32_t turns=plat_enc(EN_K1+(int)i);
        if(turns){float v=param_value[i]+(float)turns*.01f;v=v<0?0:v>1?1:v;param_value[i]=v;dirty=1;enqueue((command){2,i,0,0,v});}
    }
    // Drain unused encoders so their deltas never accumulate indefinitely.
    for(uint32_t i=param_count;i<4;++i)(void)plat_enc(EN_K1+(int)i);
    (void)plat_enc(EN_SELECT);(void)plat_enc(EN_ALGO);(void)plat_enc(EN_PRESET);
    uint32_t rising=buttons&~buttons_last;
    if(rising&(1u<<B_OCTUP)){if(octave<2){++octave;dirty=1;}}
    if(rising&(1u<<B_OCTDN)){if(octave> -2){--octave;dirty=1;}}
    if(rising&(1u<<B_PLAY))panic_due=1;
    if(rising&(1u<<B_SAVE)){
        saved.magic=RNBO_FM1_PATCH_ID;saved.count=param_count;saved.octave=octave;
        for(uint32_t i=0;i<param_count;++i)saved.value[i]=param_value[i];
        if(plat_store_save(OBJ_SETTINGS,&saved,sizeof saved)==0)dirty=0;
    }
    keys_last=keys;buttons_last=buttons;
    plat_glow(1);plat_leds(buttons|(dirty?1u<<B_SAVE:0),keys);
}
static void number_text(uint32_t n,char *out){char b[12];uint32_t i=0;do{b[i++]=(char)('0'+n%10);n/=10;}while(n);uint32_t j=0;while(i)out[j++]=b[--i];out[j]=0;}
static void draw(void){
    char text[24];rnbo_fm1_stats st;uint32_t f=plat_lock();rnbo_fm1_get_stats(&st);plat_unlock(f);
    cv_begin(240,48,C_BLACK);cv_text(10,8,&FONT_B,"RNBO",C_WHITE);cv_text(90,12,&FONT_XS,engine_ok?"MONO PROBE":"INIT FAILED",C_HI);cv_blit(0,0);
    for(uint32_t i=0;i<param_count && i<4;++i){
        cv_begin(240,32,C_BLACK);char name[22];uint32_t j=0;const char *s=param_name[i];
        while(j<21 && s[j]){name[j]=s[j]>='a'&&s[j]<='z'?(char)(s[j]-32):s[j];++j;}name[j]=0;
        cv_text(10,6,&FONT_B,name,C_GRAY);number_text((uint32_t)(param_value[i]*100+.5f),text);cv_text(178,6,&FONT_B,text,C_HI);cv_text(211,8,&FONT_XS,"%",C_GRAY);cv_blit(0,48+32*i);
    }
    cv_begin(240,48,C_BLACK);cv_text(8,0,&FONT_XS,"POOL KB",C_GRAY);number_text(st.pool_used/1024,text);cv_text(72,0,&FONT_XS,text,C_HI);
    cv_text(112,0,&FONT_XS,"CPU",C_GRAY);number_text(plat_cpu_pct(),text);cv_text(148,0,&FONT_XS,text,C_HI);
    cv_text(8,20,&FONT_XS,st.errors||st.late_allocations||queue_drops?"FAULT / CHECK LOG":"PLAY: PANIC  SAVE: STORE",C_GRAY);cv_blit(0,184);
}
void app_ui_init(void){touch_on(1);lcd_fill(0,0,240,240,C_BLACK);draw();}
void app_frame(void){input();draw();}
void app_input_only(void){input();}
void app_say(const char *a,const char *b){(void)a;(void)b;}
int app_expect(const char *s,int *v){
    if(same(s,"note"))*v=last_note;
    else if(same(s,"octave"))*v=octave;
    else if(same(s,"dirty"))*v=(int)dirty;
    else if(same(s,"rnbo_ok"))*v=engine_ok;
    else if(same(s,"params"))*v=(int)param_count;
    else if(same(s,"drops"))*v=(int)queue_drops;
    else if(same(s,"param0"))*v=(int)(param_value[0]*100+.5f);
    else if(same(s,"faults")){rnbo_fm1_stats st;rnbo_fm1_get_stats(&st);*v=(int)(st.errors+st.late_allocations+st.bad_samples);}
    else return 0;return 1;
}
