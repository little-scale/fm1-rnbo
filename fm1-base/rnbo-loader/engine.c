/* SPDX-License-Identifier: MIT */
#include "app.h"
#include "loader.h"
#include "visual.h"
#if defined(PLAT_HOST) && !defined(RM_TEST)
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#endif
_Static_assert(RM_BANK_END==0xdc000u,"Patch bank must stop before panel calibration");
volatile unsigned loader_busy;
static const rm_api *active;
static const uint8_t *active_visual;
static float (*actual_parameter)(unsigned,float);
const uint8_t *loader_visual(void){return active?active_visual:0;}
float loader_param_actual(unsigned i,float n){return active && actual_parameter?actual_parameter(i,n):n*100.f;}
static uint32_t patch_id,slot_now,generation;
static unsigned logical_now,preferred_slot,occupied;
static int load_status;
typedef struct { uint32_t address,gen; unsigned logical,valid; } bank_record;
static bank_record records[RM_PHYSICAL_SLOTS];
static uint32_t heads[RM_PATCH_SLOTS];
static int newer(uint32_t a,uint32_t b){return (int32_t)(a-b)>0;}
unsigned loader_slot_number(void){return active?logical_now:0;}
unsigned loader_slot_mask(void){return occupied;}
void loader_prefer_slot(unsigned n){preferred_slot=n<=RM_PATCH_SLOTS?n:0;}
#if defined(PLAT_HOST) && !defined(RM_TEST)
static void *host_handle;
static char host_names[RM_PATCH_SLOTS][25];
static int host_activate(const char *name){
    const char *directory=getenv("RNBO_HOST_MODULES");char path[1024];
    if(!directory || !name || !*name)return 0;
    for(const char *p=name;*p;++p)if(!((*p>='a'&&*p<='z')||(*p>='A'&&*p<='Z')||(*p>='0'&&*p<='9')||*p=='_'||*p=='-'))return 0;
    if(snprintf(path,sizeof path,"%s/%s/build/%s.dylib",directory,name,name)>=(int)sizeof path)return 0;
    void *handle=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!handle)return 0;
    const rm_api *next=dlsym(handle,"rnbo_module");
    if(!next || next->magic!=RM_API_MAGIC || (next->abi!=RM_ABI && next->abi!=RM_ABI_RAW_MIDI) || next->bytes!=sizeof(rm_api) || !next->init() || next->count()>RNBO_FM1_PARAMS){dlclose(handle);return 0;}
    const uint8_t *visual=dlsym(handle,"rnbo_visual");
    const unsigned *visual_bytes=dlsym(handle,"rnbo_visual_bytes");
    active_visual=visual && visual_bytes && rm_visual_valid(visual,*visual_bytes)?visual:0;
    actual_parameter=active_visual?dlsym(handle,"rnbo_fm1_param_actual"):0;
    void *old=host_handle;active=next;host_handle=handle;patch_id=next->patch_id;load_status=0;if(old)dlclose(old);return 1;
}
int loader_host_store(unsigned n,const char *name){
    if(n<1 || n>RM_PATCH_SLOTS || !name || strlen(name)>24 || !host_activate(name))return 0;
    strcpy(host_names[n-1],name);occupied|=1u<<(n-1);logical_now=n;return 1;
}
int loader_host_open(const char *name){return loader_host_store(1,name);}
void loader_host_reboot(void){active=0;active_visual=0;actual_parameter=0;patch_id=0;}
#endif
#ifndef PLAT_HOST
extern uint8_t _module_image[],_module_state[];
#endif
static int activate(uint32_t slot){
#ifdef RM_TEST
    extern const rm_api *rm_test_activate(uint32_t);
    const rm_api *next=rm_test_activate(slot);
    if(!next){load_status=-4;return 0;}
    active_visual=0;actual_parameter=0;active=next;patch_id=rm_u32(plat_data(slot+64)+44);load_status=0;return 1;
#elif defined(PLAT_HOST)
    (void)slot;load_status=-20;return 0;
#else
    const uint8_t *h=plat_data(slot+64),*image=plat_data(slot+128);
    if(!h || !image || !rm_image_valid(h,image)){load_status=-3;return 0;}
    for(unsigned i=0;i<rm_u32(h+32);++i)_module_image[i]=image[i];
    for(unsigned i=0;i<RM_STATE_MAX;++i)_module_state[i]=0;
    if(loader_allow_code(rm_u32(h+32))){load_status=-6;return 0;}
    const rm_api *next=(const rm_api *)_module_image;
    if(!next->init() || next->count()>RNBO_FM1_PARAMS){load_status=-4;return 0;}
    active_visual=0;actual_parameter=0;
    uint32_t bytes=rm_u32(h+32);const uint8_t *footer=_module_image+bytes-16;
    if(rm_u32(footer)==RM_VISUAL_FOOTER){
        active_visual=footer-rm_u32(footer+4);
        actual_parameter=(float (*)(unsigned,float))(uintptr_t)rm_u32(footer+12);
    }
    active=next;patch_id=next->patch_id;load_status=0;return 1;
#endif
}
static int record_read(uint32_t slot,bank_record *r){
    if(slot<RM_SLOT_A || slot>=RM_BANK_END || (slot-RM_SLOT_A)%RM_SLOT_BYTES)return 0;
    const uint8_t *s=plat_data(slot),*h=plat_data(slot+64),*image=plat_data(slot+128);
    if(!s || !h || !image)return 0;
    unsigned logical=1;
    if(rm_u32(s)==RM_COMMIT_MAGIC){if(rm_crc(s,12)!=rm_u32(s+12))return 0;}
    else if(rm_u32(s)==RM_BANK_COMMIT_MAGIC){
        logical=rm_u32(s+12);
        if(logical<1 || logical>RM_PATCH_SLOTS || rm_crc(s,16)!=rm_u32(s+16))return 0;
    }else return 0;
    uint32_t n=rm_u32(s+8);
    if(n>RM_HEADER+RM_IMAGE_MAX || !rm_header_valid(h,n) || !rm_image_valid(h,image))return 0;
    *r=(bank_record){slot,rm_u32(s+4),logical,1};return 1;
}
int loader_slot_valid(uint32_t slot,uint32_t *gen){bank_record r;if(!record_read(slot,&r))return 0;*gen=r.gen;return 1;}
static void scan_bank(void){
    occupied=0;generation=0;int have_gen=0;
    for(unsigned j=0;j<RM_PATCH_SLOTS;++j)heads[j]=0;
    for(unsigned i=0;i<RM_PHYSICAL_SLOTS;++i){
        bank_record *r=&records[i];r->valid=record_read(RM_SLOT_A+i*RM_SLOT_BYTES,r);
        if(!r->valid)continue;
        if(!have_gen || newer(r->gen,generation)){generation=r->gen;have_gen=1;}
        unsigned j=r->logical-1;uint32_t old=heads[j];
        if(!old || newer(r->gen,records[(old-RM_SLOT_A)/RM_SLOT_BYTES].gen))heads[j]=r->address;
        occupied|=1u<<j;
    }
    // Boot/selection may have fallen back after a newer version failed init.
    // Protect that working version and let the rejected head become the spare.
    if(active && logical_now && slot_now){
        bank_record *r=&records[(slot_now-RM_SLOT_A)/RM_SLOT_BYTES];
        if(r->valid && r->logical==logical_now)heads[logical_now-1]=slot_now;
    }
}
/* Try all committed versions of one logical slot, newest first. A corrupt or
 * returned-init-failure version must not hide a working older version. */
static int activate_logical(unsigned n){
    unsigned tried=0;
    for(unsigned attempt=0;attempt<RM_PHYSICAL_SLOTS;++attempt){
        int best=-1;
        for(unsigned i=0;i<RM_PHYSICAL_SLOTS;++i)if(!(tried&(1u<<i)) && records[i].valid && records[i].logical==n)
            if(best<0 || newer(records[i].gen,records[best].gen))best=(int)i;
        if(best<0)break;
        tried|=1u<<best;
        bank_record checked;
        if(record_read(records[best].address,&checked) && activate(checked.address)){
            slot_now=checked.address;logical_now=n;heads[n-1]=slot_now;return 1;
        }
    }
    return 0;
}
int loader_select(unsigned n){
    if(n<1 || n>RM_PATCH_SLOTS || !(occupied&(1u<<(n-1))) || (active && n==logical_now))return 0;
    uint32_t f=plat_lock();loader_busy=1;plat_unlock(f);
    unsigned oldlogical=logical_now;uint32_t oldslot=slot_now;
    if(active)active->panic();
#if defined(PLAT_HOST) && !defined(RM_TEST)
    if(host_activate(host_names[n-1])){logical_now=n;return 1;}
    if(oldlogical)host_activate(host_names[oldlogical-1]);
#else
    active=0;patch_id=0;
    if(activate_logical(n))return 1;
    if(oldslot)activate(oldslot);
#endif
    slot_now=oldslot;logical_now=oldlogical;load_status=-4;return -1;
}
int loader_cycle(int32_t turns){
    unsigned list[RM_PATCH_SLOTS],count=0,index=0;
    for(unsigned n=1;n<=RM_PATCH_SLOTS;++n)if(occupied&(1u<<(n-1))){if(n==logical_now)index=count;list[count++]=n;}
    if(!count || !turns)return 0;
    int32_t next=((int32_t)index+turns%(int32_t)count)%(int32_t)count;if(next<0)next+=(int32_t)count;
    return loader_select(list[next]);
}
int loader_boot(void){
    if(active)return 1;
    loader_busy=1;
#if defined(PLAT_HOST) && !defined(RM_TEST)
    if(!occupied){int ok=loader_host_open(getenv("RNBO_HOST_PATCH"));loader_busy=0;return ok;}
    unsigned n=preferred_slot && (occupied&(1u<<(preferred_slot-1)))?preferred_slot:logical_now;
    if(n && host_activate(host_names[n-1]))logical_now=n;
    else for(n=1;n<=RM_PATCH_SLOTS;++n)if((occupied&(1u<<(n-1))) && host_activate(host_names[n-1])){logical_now=n;break;}
#else
    scan_bank();active=0;patch_id=0;
    if(preferred_slot)activate_logical(preferred_slot);
    unsigned tried=0;
    while(!active){
        int best=-1;
        for(unsigned i=0;i<RM_PHYSICAL_SLOTS;++i)if(records[i].valid && !(tried&(1u<<i)))
            if(best<0 || newer(records[i].gen,records[best].gen))best=(int)i;
        if(best<0)break;
        tried|=1u<<best;
        if(activate(records[best].address)){slot_now=records[best].address;logical_now=records[best].logical;heads[logical_now-1]=slot_now;}
    }
#endif
    loader_busy=0;return active!=0;
}
int rnbo_fm1_init(void){return loader_boot();}
void rnbo_fm1_render(int *lr,unsigned n,unsigned gain){if(active && !loader_busy)active->render(lr,n,gain);else for(unsigned i=0;i<2*n;++i)lr[i]=0;}
void rnbo_fm1_midi(unsigned s,unsigned a,unsigned b){if(active && !loader_busy)active->midi(s,a,b);}
void rnbo_fm1_panic(void){if(active && !loader_busy)active->panic();}
unsigned rnbo_fm1_param_count(void){return active?active->count():0;}
const char *rnbo_fm1_param_name(unsigned i){return active?active->name(i):"";}
float rnbo_fm1_param_normalized(unsigned i){return active?active->value(i):0;}
void rnbo_fm1_set_param(unsigned i,float n){if(active)active->set(i,n);}
void rnbo_fm1_get_stats(rnbo_fm1_stats *s){if(active)active->stats(s);else *s=(rnbo_fm1_stats){0};}
unsigned loader_patch_id(void){return patch_id;}
const char *loader_title(void){return active?active->title:"UPLOAD A PATCH";}
int loader_raw_midi(void){return active && active->abi==RM_ABI_RAW_MIDI;}
int loader_status(void){return load_status;}
void loader_resume(void){uint32_t f=plat_lock();loader_busy=0;plat_unlock(f);}
#ifdef RM_TEST
void rm_test_reset(void){active=0;slot_now=0;generation=0;patch_id=0;loader_busy=0;logical_now=preferred_slot=occupied=0;}
#endif
int loader_receive(uint32_t n,uint32_t crc){return loader_receive_slot(n,crc,logical_now?logical_now:1);}
int loader_receive_slot(uint32_t n,uint32_t expected_crc,unsigned logical){
    uint8_t buf[512],head[64];int rc=-1;uint32_t target=0,oldslot=slot_now;unsigned oldlogical=logical_now;
    if(logical<1 || logical>RM_PATCH_SLOTS || n<RM_HEADER+84 || n>RM_HEADER+RM_IMAGE_MAX)return -2;
    scan_bank();
    // Four physical slots hold three logical heads and one rotating spare.
    // Never erase a selected head or the module needed for recovery.
    for(unsigned i=0;i<RM_PHYSICAL_SLOTS;++i){
        uint32_t candidate=RM_SLOT_A+i*RM_SLOT_BYTES;int used=candidate==slot_now;
        for(unsigned j=0;j<RM_PATCH_SLOTS;++j)if(heads[j]==candidate)used=1;
        if(!used){target=candidate;break;}
    }
    if(!target)return -7;
    uint32_t f=plat_lock();loader_busy=1;plat_unlock(f);
    if(active)active->panic();
    plat_host_patience(1000,120000);
    if(plat_host_read(0,head,64) || !rm_header_valid(head,n))goto done;
    for(unsigned off=0;off<RM_SLOT_BYTES;off+=4096)if(plat_data_erase(target+off))goto done;
    for(unsigned off=0;off<n;){
        unsigned k=n-off>512?512:n-off;
        if(plat_host_read(off,buf,k) || plat_data_write(target+64+off,buf,k))goto done;
        off+=k;plat_yield();
    }
    {
        const uint8_t *saved=plat_data(target+64);
        if(rm_crc(saved,n)!=expected_crc || !rm_header_valid(saved,n) || !rm_image_valid(saved,saved+64)){rc=-3;goto done;}
    }
    active=0;patch_id=0;
    if(!activate(target)){
        if(oldslot)activate(oldslot);
        rc=-4;goto done;
    }
    // New magic prevents a torn bank record being mistaken for a legacy
    // slot-1 record. Logical number is covered by the final CRC.
    rm_put32(buf,RM_BANK_COMMIT_MAGIC);rm_put32(buf+4,generation+1);rm_put32(buf+8,n);
    rm_put32(buf+12,logical);rm_put32(buf+16,rm_crc(buf,16));
    if(plat_data_write(target,buf,20)){
        active=0;patch_id=0;if(oldslot)activate(oldslot);rc=-5;goto done;
    }
    bank_record committed;
    if(!record_read(target,&committed)){
        active=0;patch_id=0;if(oldslot)activate(oldslot);rc=-5;goto done;
    }
    slot_now=target;logical_now=logical;scan_bank();rc=0;
done:
    if(rc){slot_now=oldslot;logical_now=oldlogical;}
    load_status=rc;return rc;
}
