/* SPDX-License-Identifier: MIT */
#include "platform.h"
#include "bridge.h"
#ifndef RNBO_FM1_PATCH_CONFIG
#define RNBO_FM1_PATCH_CONFIG "export/patch_config.h"
#define RNBO_FM1_PATCH_SOURCE "export/rnbo_source.h"
#endif
#include RNBO_FM1_PATCH_CONFIG
#include "RNBO_Common.h"
#if defined(RNBO_FM1_FAST_PHASE) && RNBO_FM1_FAST_PHASE
#include "RNBO_AudioSignal.h"
#include "phase.h"
#undef uint32_trunc
#define uint32_trunc(x) rnbo_fm1_phase_increment(x)
#endif
#ifdef PLAT_HOST
extern "C" long write(int,const void *,unsigned long);
#else
extern "C" {
typedef void (*rnbo_static_initializer)(void);
extern rnbo_static_initializer _rnbo_init_array_start[],_rnbo_init_array_end[];
extern rnbo_static_initializer _rnbo_ctors_start[],_rnbo_ctors_end[];
}
#endif

namespace {
#ifndef RNBO_FM1_POOL_BYTES
#define RNBO_FM1_POOL_BYTES (128u*1024u)
#endif
constexpr unsigned int POOL_BYTES=RNBO_FM1_POOL_BYTES;
#ifdef PLAT_HOST
#define RNBO_POOL
#else
#define RNBO_POOL __attribute__((section(".pool")))
#endif
alignas(16) unsigned char arena[POOL_BYTES] RNBO_POOL;
size_t used=0;
bool running=false;
#ifndef PLAT_HOST
bool static_initializers_done=false;
#endif
rnbo_fm1_stats stats={};
unsigned int seed=0x61234567u;
unsigned long ticks=0;
}
namespace rnbo_fm1_platform {
void report(const char *s) {
    ++stats.errors;
#ifdef PLAT_HOST
    write(2,s,RNBO::Platform::strlen(s));write(2,"\n",1);
#else
    (void)s;
#endif
}
[[noreturn]] void fail(const char *s) {
    report(s);
#ifdef PLAT_HOST
    __builtin_trap();
#else
    for(;;) {} // watchdog resets the device; never continue with a null allocation
#endif
}
void *allocate(size_t n) {
    const size_t header=16;
    if(n>POOL_BYTES-header-15u) fail("pool request too large");
    const size_t total=(n+header+15u)&~size_t(15u);
    if(total>POOL_BYTES-used) fail("pool exhausted");
    auto p=arena+used; *reinterpret_cast<size_t*>(p)=n;
    used+=total; ++stats.allocations;
    if(running) ++stats.late_allocations;
    stats.pool_used=static_cast<unsigned int>(used);
    return p+header;
}
void *resize(void *p,size_t n) {
    if(!p) return allocate(n);
    const size_t old=*reinterpret_cast<size_t*>(static_cast<unsigned char*>(p)-16);
    if(n<=old) return p;
    void *q=allocate(n); RNBO::Platform::memcpy(q,p,old); return q;
}
}
void *operator new(size_t n) throw() { return rnbo_fm1_platform::allocate(n); }
void *operator new[](size_t n) throw() { return rnbo_fm1_platform::allocate(n); }
void operator delete(void *) throw() {}
void operator delete[](void *) throw() {}
extern "C" void __cxa_pure_virtual() { rnbo_fm1_platform::fail("pure virtual"); }
#ifndef PLAT_HOST
extern "C" int rand(void) { seed^=seed<<13;seed^=seed>>17;seed^=seed<<5;return static_cast<int>(seed&0x7fffffffu); }
extern "C" unsigned long clock(void) { return ticks; }
#endif

namespace RNBO {
class Fm1Logger : public Logger {
public: void log(LogLevel,const char *s) override { Platform::printMessage(s); }
};
static Logger *console=nullptr;
}
#include RNBO_FM1_PATCH_SOURCE
// The generated header defines convenience macros which must not escape.
#undef trunc
#undef autoref

namespace {
using GeneratedPatch=RNBO::RNBO_FM1_CLASS<>;
#if defined(PLAT_HOST) && defined(RNBO_FM1_POLYPHONY) && RNBO_FM1_POLYPHONY > 1
// Host-only observation of the generator's mute state, without changing DSP.
class Patch : public GeneratedPatch {
public: unsigned int activeVoicesForTest(){return (unsigned int)this->RNBO_FM1_VOICE_COUNT_METHOD();}
};
#else
using Patch=GeneratedPatch;
#endif
alignas(Patch) unsigned char patch_storage[sizeof(Patch)] RNBO_POOL;
alignas(RNBO::Fm1Logger) unsigned char logger_storage[sizeof(RNBO::Fm1Logger)];
Patch *patch=nullptr;
float left[RNBO_FM1_BLOCK],right[RNBO_FM1_BLOCK];
float *outputs[]={left,right};
bool ready=false;
bool panic_muted=false;
float gain_now=0;
unsigned int held[16][4]={};
}
static_assert(sizeof(RNBO::SampleValue)==4,"float32 DSP required");
static_assert(sizeof(RNBO::MillisecondTime)==8,"retain long-running scheduler precision");
static_assert(sizeof(int)==4,"FM1 audio words must be 32 bits");

extern "C" int rnbo_fm1_init(void) {
    running=false;ready=false;
    if(patch) patch->~Patch();
    used=0;stats={};stats.pool_capacity=POOL_BYTES;ticks=0;seed=0x61234567u;
    panic_muted=false;gain_now=0;
    RNBO::Platform::memset(held,0,sizeof held);
    // The base firmware has C startup. Run the constructor table ourselves:
    // with -fno-builtin, RNBO's EXP2_NEG23 also needs dynamic initialization.
#ifndef PLAT_HOST
    if(!static_initializers_done){
        // JieLi Clang 4 emits legacy .ctors. Its order is reverse, unlike
        // .init_array; skip the optional legacy null/-1 sentinels.
        for(auto p=_rnbo_ctors_end;p!=_rnbo_ctors_start;){
            auto ctor=*--p;
            if(ctor && reinterpret_cast<__UINTPTR_TYPE__>(ctor)!=~static_cast<__UINTPTR_TYPE__>(0))ctor();
        }
        for(auto p=_rnbo_init_array_start;p!=_rnbo_init_array_end;++p)(*p)();
        static_initializers_done=true;
    }
#endif
    // Re-seed on explicit patch reconstruction, on the host and the device.
    new(&RNBO::s_globalRandom) RNBO::GlobalRandom();
    RNBO::console=new(logger_storage) RNBO::Fm1Logger();
    patch=new(patch_storage) Patch();
    patch->initialize();patch->prepareToProcess(RNBO_FM1_RATE,RNBO_FM1_BLOCK,true);
    if(patch->getNumInputChannels()!=0 || patch->getNumOutputChannels()!=2 || patch->getNumParameters()>RNBO_FM1_PARAMS) {
        ++stats.errors;return 0;
    }
    // Run initial parameter/clock events while allocation is still permitted.
    patch->process(nullptr,0,outputs,2,RNBO_FM1_BLOCK);
    ready=stats.errors==0;running=true;
    return ready ? 1:0;
}
extern "C" void rnbo_fm1_render(int *lr,unsigned int n,unsigned int gain) {
    if(!lr)return;
    if(stats.errors || stats.late_allocations || stats.bad_samples)ready=false;
    if(!ready || n!=RNBO_FM1_BLOCK) {
        for(unsigned int i=0;i<2*n;++i) lr[i]=0;
        if(n!=RNBO_FM1_BLOCK) ++stats.errors;
        return;
    }
    const unsigned int late=stats.late_allocations, errors=stats.errors;
    patch->process(nullptr,0,outputs,2,n);
    ticks+=5805u; // clock() seed helper only; RNBO owns the precise double timeline
    const float scale=8388607.0f*static_cast<float>(gain>4096?4096:gain)*(1.0f/4096.0f);
    if(stats.late_allocations!=late || stats.errors!=errors) ready=false;
    for(unsigned int i=0;i<n;++i) {
        float a=left[i],b=right[i];
        if(!(a==a) || a>3.4028234e38f || a< -3.4028234e38f){a=0;++stats.bad_samples;ready=false;}
        if(!(b==b) || b>3.4028234e38f || b< -3.4028234e38f){b=0;++stats.bad_samples;ready=false;}
        a=a>1?1:a< -1?-1:a;b=b>1?1:b< -1?-1:b;
        gain_now+=(scale-gain_now)*.004f;
        lr[2*i]=ready && !panic_muted?static_cast<int>(a*gain_now):0;
        lr[2*i+1]=ready && !panic_muted?static_cast<int>(b*gain_now):0;
    }
    ++stats.blocks;
}
extern "C" void rnbo_fm1_midi(unsigned int st,unsigned int a,unsigned int b) {
    if(!ready || st<0x80 || st>=0xf0 || a>127 || b>127)return;
    const unsigned char data[]={static_cast<unsigned char>(st),static_cast<unsigned char>(a),static_cast<unsigned char>(b)};
    const unsigned int length=((st&0xf0)==0xc0 || (st&0xf0)==0xd0)?2:3;
    if((st&0xf0)==0x90 && b){panic_muted=false;held[st&15][a/32]|=1u<<(a%32);}
    else if((st&0xf0)==0x80 || (st&0xf0)==0x90)held[st&15][a/32]&=~(1u<<(a%32));
    patch->processMidiEvent(RNBO::TimeNow,0,data,length);
}
extern "C" void rnbo_fm1_panic(void) {
    if(!ready)return;
#if defined(RNBO_FM1_POLYPHONY) && RNBO_FM1_POLYPHONY > 1
    // Release sustained notes even after their note-off cleared the held bitmap.
    for(unsigned int ch=0;ch<16;++ch)rnbo_fm1_midi(0xb0u|ch,64,0);
#endif
    // Only send note-offs for held notes: a 2048-event burst could miss the
    // hardware audio deadline. Also works when a patch ignores all-notes-off CC.
    for(unsigned int ch=0;ch<16;++ch)
        for(unsigned int n=0;n<128;++n)if(held[ch][n/32]&(1u<<(n%32)))rnbo_fm1_midi(0x80u|ch,n,0);
#if defined(RNBO_FM1_SHARED_FX) && RNBO_FM1_SHARED_FX
    rnbo_fm1_midi(0xb0,120,0); // master-effect patch clears its delay buffers
#endif
    panic_muted=true;
}
extern "C" unsigned int rnbo_fm1_param_count(void){
    if(!ready)return 0;
#ifdef RNBO_FM1_EXPOSED_PARAMS
    return RNBO_FM1_EXPOSED_PARAMS;
#else
    return patch->getNumParameters();
#endif
}
extern "C" const char *rnbo_fm1_param_name(unsigned int i){
    if(!ready || i>=rnbo_fm1_param_count())return "";
    RNBO::ParameterInfo info={};patch->getParameterInfo(i,&info);
    return info.displayName && info.displayName[0]?info.displayName:patch->getParameterName(i);
}
extern "C" float rnbo_fm1_param_normalized(unsigned int i){
    if(!ready || i>=patch->getNumParameters())return 0;
    return patch->convertToNormalizedParameterValue(i,patch->getParameterValue(i));
}
extern "C" void rnbo_fm1_set_param(unsigned int i,float n){
    if(!ready || i>=patch->getNumParameters() || !(n==n))return;
    patch->setParameterValueNormalized(i,n<0?0:n>1?1:n,RNBO::TimeNow);
}
extern "C" void rnbo_fm1_get_stats(rnbo_fm1_stats *s){if(s)*s=stats;}

#if defined(PLAT_HOST) && defined(RNBO_FM1_POLYPHONY) && RNBO_FM1_POLYPHONY > 1
extern "C" __attribute__((visibility("default"))) unsigned int rnbo_fm1_host_active_voices(void){return ready?patch->activeVoicesForTest():0;}
#endif
