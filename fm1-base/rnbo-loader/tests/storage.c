/* SPDX-License-Identifier: MIT */
/* Exercise the real transaction/boot code with NOR and USB fault injection.
 * Native instruction execution is replaced by a deliberately small stub. */
#include "loader.h"
#include "app.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static unsigned char flash[0x100000],upload[1088];
static int fail_read=-1,read_count,fail_erase,fail_write,fail_commit;
static unsigned fail_patch;
static int torn_commit=-1;
void rm_test_reset(void);
uint32_t plat_lock(void){return 0;}
void plat_unlock(uint32_t f){(void)f;}
void plat_yield(void){}
void plat_host_patience(uint32_t a,uint32_t b){(void)a;(void)b;}
const uint8_t *plat_data(uint32_t off){assert(PLAT_DATA_OK(off,1));return flash+off;}
int plat_data_erase(uint32_t off){assert(!(off&4095) && off>=RM_SLOT_A && off+4096<=RM_BANK_END);if(fail_erase)return -1;memset(flash+off,255,4096);return 0;}
int plat_data_write(uint32_t off,const void *src,uint32_t n){
    assert(off>=RM_SLOT_A && off+n<=RM_BANK_END);int commit=(off-RM_SLOT_A)%RM_SLOT_BYTES==0;
    if(fail_write || (fail_commit && commit))return -1;
    unsigned written=commit && torn_commit>=0 && (unsigned)torn_commit<n?(unsigned)torn_commit:n;
    for(unsigned i=0;i<written;++i)flash[off+i]&=((const unsigned char *)src)[i];
    return written==n?0:-1;
}
int plat_host_read(uint32_t off,uint8_t *dst,uint32_t n){if(read_count++==fail_read)return -1;assert(off+n<=sizeof upload);memcpy(dst,upload+off,n);return 0;}
static void panic_stub(void){}
static rm_api api={.panic=panic_stub};
const rm_api *rm_test_activate(uint32_t slot){if(rm_u32(flash+slot+64+44)==fail_patch)return 0;api.abi=rm_u32(flash+slot+72);return &api;}
static void make(unsigned id){
    memset(upload,0,sizeof upload);uint32_t h[]={RM_MAGIC,1,1,241,44100,256,RM_TEXT,RM_STATE,1024,140000,0,id,0,0,0,0};
    for(unsigned i=0;i<16;++i)rm_put32(upload+4*i,h[i]);
    uint8_t *p=upload+64;rm_put32(p,RM_API_MAGIC);rm_put32(p+4,1);rm_put32(p+8,84);rm_put32(p+12,id);memcpy(p+16,"TEST",5);
    for(unsigned i=48;i<84;i+=4)rm_put32(p+i,RM_TEXT+84);
    rm_put32(upload+40,rm_crc(p,1024));rm_put32(upload+48,rm_crc(upload,48));
    assert(rm_header_valid(upload,sizeof upload));assert(rm_image_valid(upload,p));read_count=0;
}
static int receive(unsigned id){make(id);int rc=loader_receive(sizeof upload,rm_crc(upload,sizeof upload));loader_resume();return rc;}
static int receive_to(unsigned id,unsigned logical){make(id);int rc=loader_receive_slot(sizeof upload,rm_crc(upload,sizeof upload),logical);loader_resume();return rc;}
static void select_patch(unsigned n,unsigned id){assert(loader_select(n)==1);loader_resume();assert(loader_slot_number()==n && loader_patch_id()==id);}
static void legacy(uint32_t address,unsigned id,uint32_t gen){
    make(id);memcpy(flash+address+64,upload,sizeof upload);
    rm_put32(flash+address,RM_COMMIT_MAGIC);rm_put32(flash+address+4,gen);rm_put32(flash+address+8,sizeof upload);
    rm_put32(flash+address+12,rm_crc(flash+address,12));
}
int main(void){
    memset(flash,255,sizeof flash);rm_test_reset();assert(!loader_boot());
    assert(receive(101)==0);uint32_t gen;assert(loader_slot_valid(RM_SLOT_A,&gen) && gen==1);assert(loader_patch_id()==101);
    unsigned char original[RM_SLOT_BYTES];memcpy(original,flash+RM_SLOT_A,sizeof original);
    for(int i=0;i<4;++i){fail_read=i;assert(receive(102)!=0);assert(!memcmp(original,flash+RM_SLOT_A,sizeof original));assert(loader_slot_valid(RM_SLOT_A,&gen) && gen==1);assert(loader_patch_id()==101);}fail_read=-1;
    fail_erase=1;assert(receive(102)!=0);fail_erase=0;
    fail_write=1;assert(receive(102)!=0);fail_write=0;
    fail_patch=102;assert(receive(102)!=0);assert(loader_patch_id()==101);fail_patch=0;
    fail_commit=1;assert(receive(102)!=0);assert(loader_patch_id()==101);fail_commit=0;
    assert(!memcmp(original,flash+RM_SLOT_A,sizeof original));
    assert(receive(102)==0);assert(loader_slot_valid(RM_SLOT_B,&gen) && gen==2);assert(loader_patch_id()==102);
    rm_test_reset();assert(loader_boot() && loader_patch_id()==102);
    // Bad new payload falls back to the other committed slot after a reboot.
    flash[RM_SLOT_B+128+100]^=1;rm_test_reset();assert(loader_boot() && loader_patch_id()==101);
    // Initialization failure also falls back without committing a bad slot.
    assert(receive(103)==0);fail_patch=103;rm_test_reset();assert(loader_boot() && loader_patch_id()==101);fail_patch=0;
    // Header/descriptor corruption and arithmetic overflow are rejected.
    make(104);for(unsigned i=0;i<64;++i){upload[i]^=1;assert(!rm_header_valid(upload,sizeof upload));upload[i]^=1;}
    assert(!rm_header_valid(upload,0xffffffffu));upload[64+48]=0;assert(!rm_image_valid(upload,upload+64));
    // ABI 2 is opt-in raw MIDI, with the same table bounds and CRC checks.
    make(105);rm_put32(upload+8,2);rm_put32(upload+68,2);
    rm_put32(upload+40,rm_crc(upload+64,1024));rm_put32(upload+48,rm_crc(upload,48));
    assert(rm_header_valid(upload,sizeof upload) && rm_image_valid(upload,upload+64));
    assert(loader_receive(sizeof upload,rm_crc(upload,sizeof upload))==0);loader_resume();
    assert(loader_raw_midi());rm_test_reset();assert(loader_boot() && loader_raw_midi());
    rm_put32(upload+8,1);rm_put32(upload+48,rm_crc(upload,48));
    assert(rm_header_valid(upload,sizeof upload) && !rm_image_valid(upload,upload+64));
    rm_put32(upload+8,3);rm_put32(upload+48,rm_crc(upload,48));assert(!rm_header_valid(upload,sizeof upload));
    // Legacy A/B copies are versions of slot 1, never two user instruments.
    memset(flash,255,sizeof flash);legacy(RM_SLOT_A,201,30);legacy(RM_SLOT_B,202,31);
    memset(flash+RM_BANK_END,0xa5,4096);memset(flash+0xfc000,0x5a,4096);
    rm_test_reset();assert(loader_boot());assert(loader_patch_id()==202 && loader_slot_number()==1 && loader_slot_mask()==1);
    assert(receive_to(301,2)==0);assert(loader_slot_number()==2 && loader_slot_mask()==3);
    assert(receive_to(401,3)==0);assert(loader_slot_number()==3 && loader_slot_mask()==7);
    select_patch(1,202);assert(loader_cycle(-1)==1);loader_resume();assert(loader_slot_number()==3);
    assert(loader_cycle(1)==1);loader_resume();assert(loader_slot_number()==1);
    assert(loader_cycle(3)==0);assert(loader_select(0)==0 && loader_select(4)==0);
    assert(receive_to(999,0)==-2 && receive_to(999,4)==-2);
    // Replacing one logical patch preserves every other logical head.
    assert(receive_to(203,1)==0);assert(loader_slot_mask()==7);
    for(unsigned i=0;i<12;++i){assert(receive_to(500+i,2)==0);select_patch(1,203);select_patch(3,401);select_patch(2,500+i);}
    // Every possible torn bank-commit prefix remains uncommitted on reboot.
    for(int i=0;i<20;++i){
        torn_commit=i;assert(receive_to(600,2)!=0);torn_commit=-1;
        rm_test_reset();loader_prefer_slot(2);assert(loader_boot());assert(loader_slot_number()==2 && loader_patch_id()==511);
        select_patch(1,203);select_patch(3,401);select_patch(2,511);
    }
    fail_patch=600;assert(receive_to(600,2)==-4);assert(loader_patch_id()==511);fail_patch=0;
    fail_erase=1;assert(receive_to(600,2)!=0);fail_erase=0;
    fail_write=1;assert(receive_to(600,2)!=0);fail_write=0;
    for(int i=0;i<4;++i){fail_read=i;assert(receive_to(600,2)!=0);assert(loader_patch_id()==511);}fail_read=-1;
    assert(loader_slot_mask()==7);select_patch(1,203);select_patch(3,401);
    // Explicit saved startup selection wins over upload recency.
    rm_test_reset();loader_prefer_slot(1);assert(loader_boot() && loader_patch_id()==203);
    rm_test_reset();loader_prefer_slot(3);assert(loader_boot() && loader_patch_id()==401);
    // Initialization failure on selection returns to the previous patch.
    fail_patch=203;assert(loader_select(1)==-1);loader_resume();assert(loader_patch_id()==401 && loader_slot_number()==3);fail_patch=0;
    select_patch(1,203);assert(receive_to(204,1)==0);
    fail_patch=204;rm_test_reset();loader_prefer_slot(1);assert(loader_boot() && loader_patch_id()==203);
    // A rejected newer copy must not consume the spare and block recovery.
    assert(receive_to(205,1)==0);fail_patch=0;assert(loader_patch_id()==205 && loader_slot_mask()==7);
    for(unsigned i=0;i<4096;++i){assert(flash[RM_BANK_END+i]==0xa5);assert(flash[0xfc000+i]==0x5a);}
    // Empty slots are skipped in both directions, including large turns.
    memset(flash,255,sizeof flash);rm_test_reset();assert(!loader_boot());assert(receive_to(701,1)==0);assert(receive_to(703,3)==0);
    assert(loader_slot_mask()==5);assert(loader_cycle(1)==1);loader_resume();assert(loader_slot_number()==1);
    assert(loader_cycle(-1)==1);loader_resume();assert(loader_slot_number()==3);assert(loader_cycle(200)==0);
    // Serial comparison handles the generation counter wrapping at uint32.
    memset(flash,255,sizeof flash);legacy(RM_SLOT_A,801,0xfffffffeu);rm_test_reset();assert(loader_boot());
    assert(receive_to(802,1)==0);assert(receive_to(803,1)==0);rm_test_reset();assert(loader_boot() && loader_patch_id()==803);
    puts("PASS three-slot bank: legacy migration, rotating spare, failed/torn uploads, selection, reboot, wrap, recovery and calibration/settings bounds");
}
