/* SPDX-License-Identifier: MIT */
#include "bridge.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
static int lr[RNBO_FM1_BLOCK*2];
static unsigned checks;
#define CHECK(x) do { ++checks; if(!(x)){fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#x);exit(1);} } while(0)
static double rms(void) {
    double s=0;for(unsigned i=0;i<RNBO_FM1_BLOCK;++i){double v=lr[2*i]/8388607.0;s+=v*v;CHECK(lr[2*i]==lr[2*i+1]);CHECK(abs(lr[2*i])<=8388607);}return sqrt(s/RNBO_FM1_BLOCK);
}
static int param(const char *s){for(unsigned i=0;i<rnbo_fm1_param_count();++i)if(!strcmp(s,rnbo_fm1_param_name(i)))return (int)i;return -1;}
static void render(unsigned blocks){for(unsigned i=0;i<blocks;++i)rnbo_fm1_render(lr,RNBO_FM1_BLOCK,4096);}
static void u16(FILE *f,unsigned v){fputc(v&255,f);fputc((v>>8)&255,f);}
static void u32(FILE *f,unsigned v){u16(f,v&65535);u16(f,v>>16);}
int main(int argc,char **argv){
    CHECK(rnbo_fm1_init());CHECK(rnbo_fm1_param_count()==3);
    int level=param("level"),attack=param("attack"),release=param("release");CHECK(level>=0 && attack>=0 && release>=0);
    rnbo_fm1_stats before,after;rnbo_fm1_get_stats(&before);
    CHECK(before.pool_used<before.pool_capacity);CHECK(before.late_allocations==0);CHECK(before.errors==0);
    render(20);CHECK(rms()==0);
    rnbo_fm1_midi(0x90,69,127);render(30);CHECK(rms()>.05 && rms()<.3);
    unsigned crossings=0,frames=0;int last=lr[2*(RNBO_FM1_BLOCK-1)];
    for(unsigned b=0;b<173;++b){render(1);for(unsigned i=0;i<RNBO_FM1_BLOCK;++i){int v=lr[2*i];if(last<=0 && v>0)++crossings;last=v;++frames;}}
    double hz=crossings*44100.0/frames;CHECK(fabs(hz-440.0)<1.5);
    rnbo_fm1_midi(0x80,69,0);render(50);CHECK(rms()==0);
    rnbo_fm1_midi(0x90,69,64);render(40);double low=rms();
    rnbo_fm1_midi(0x90,69,0);render(50);CHECK(rms()==0);
    rnbo_fm1_midi(0x90,69,127);render(40);double high=rms();CHECK(high>low*1.8 && high<low*2.2);
    rnbo_fm1_set_param((unsigned)level,0);render(2);CHECK(rms()==0);
    rnbo_fm1_set_param((unsigned)level,0.2f);render(2);CHECK(rms()>.05);
    rnbo_fm1_set_param((unsigned)release,0);rnbo_fm1_midi(0x80,69,0);render(3);CHECK(rms()==0);
    rnbo_fm1_set_param((unsigned)level,NAN);CHECK(isfinite(rnbo_fm1_param_normalized((unsigned)level)));
    rnbo_fm1_set_param((unsigned)level,5);CHECK(rnbo_fm1_param_normalized((unsigned)level)==1);
    rnbo_fm1_set_param((unsigned)level,0.2f);
    // A saved stereo audition: MIDI note changes, different velocities, release.
    if(argc>1){
        const unsigned blocks=690,bytes=blocks*RNBO_FM1_BLOCK*4;FILE *f=fopen(argv[1],"wb");CHECK(f!=NULL);
        fwrite("RIFF",1,4,f);u32(f,36+bytes);fwrite("WAVEfmt ",1,8,f);u32(f,16);u16(f,1);u16(f,2);u32(f,44100);u32(f,176400);u16(f,4);u16(f,16);fwrite("data",1,4,f);u32(f,bytes);
        for(unsigned b=0;b<blocks;++b){
            if(b%172==0 && b<516)rnbo_fm1_midi(0x90,60+(b/172)*4,127-(b/172)*20);
            if(b%172==120 || b==516)rnbo_fm1_midi(0x80,60+(b/172)*4,0);
            render(1);for(unsigned i=0;i<2*RNBO_FM1_BLOCK;++i)u16(f,(unsigned)(lr[i]/256)&65535);
        }CHECK(fclose(f)==0);
    }
    // Sustain and repeated notes exercise the allocator, scheduler and envelope.
    struct timespec t0,t1;clock_gettime(CLOCK_MONOTONIC,&t0);
    for(unsigned b=0;b<20000;++b){if(b%80==0)rnbo_fm1_midi(0x90,48+(b/80)%36,100);if(b%80==60)rnbo_fm1_midi(0x80,48+(b/80)%36,0);render(1);}
    clock_gettime(CLOCK_MONOTONIC,&t1);
    rnbo_fm1_midi(0x90,69,127);render(10);CHECK(rms()>.05);
    rnbo_fm1_panic();render(1);CHECK(rms()==0);
    rnbo_fm1_midi(0x90,69,127);render(10);CHECK(rms()>.05);
    rnbo_fm1_midi(0x80,69,0);render(400);CHECK(rms()==0);
    rnbo_fm1_get_stats(&after);CHECK(after.errors==0);CHECK(after.bad_samples==0);CHECK(after.late_allocations==0);CHECK(after.pool_used==before.pool_used);
    // Invalid block lengths must fail silent, without touching the guard words.
    int guarded[12];for(unsigned i=0;i<12;++i)guarded[i]=12345;rnbo_fm1_render(guarded+2,4,4096);CHECK(guarded[1]==12345 && guarded[10]==12345);for(unsigned i=2;i<10;++i)CHECK(guarded[i]==0);
    // Explicit reconstruction must reclaim the arena and restore defaults.
    CHECK(rnbo_fm1_init());rnbo_fm1_get_stats(&after);CHECK(after.pool_used==before.pool_used);CHECK(fabs(rnbo_fm1_param_normalized((unsigned)level)-.2)<.00001);
    double seconds=(t1.tv_sec-t0.tv_sec)+(t1.tv_nsec-t0.tv_nsec)*1e-9;
    printf("PASS %u checks; MIDI frequency %.2f Hz; pool %u/%u B, %u allocations; zero late allocations/errors; 116.1 s audio in %.3f s HOST time\n",checks,hz,after.pool_used,after.pool_capacity,after.allocations,seconds);
    return 0;
}
