/* SPDX-License-Identifier: MIT */
static void title_text(const char *s,char *out,unsigned size){
    unsigned i=0;int start=1;
    while(i+1<size && s[i]){
        char c=s[i];if(c>='A' && c<='Z')c+=32;
        if(c>='a' && c<='z'){out[i]=start?(char)(c-32):c;start=0;}
        else{out[i]=c;start=c==' '||c=='_'||c=='-'||c=='/';}
        ++i;
    }out[i]=0;
}
static void value_text(float value,char *out){
    unsigned k=0;if(value<0){out[k++]='-';value=-value;}
    if(!(value>=0) || value>999999999.f){out[0]='?';out[1]=0;return;}
    unsigned decimals=value<10?2:value<100?1:0;
    uint32_t scale=decimals==2?100:decimals==1?10:1;
    uint32_t v=(uint32_t)(value*scale+.5f);
    number_text(v/scale,out+k);while(out[k])++k;
    if(decimals){out[k++]='.';if(decimals==2)out[k++]=(char)('0'+v%100/10);out[k++]=(char)('0'+v%10);out[k]=0;}
}
static void overlay_contents(void){
    if(overlay_parameter<0)return;
    unsigned i=(unsigned)overlay_parameter;char name[32],value[32];
    title_text(param_name[i],name,sizeof name);
    while(text_w(&FONT_B,name)>204){unsigned n=0;while(name[n])++n;if(!n)break;name[n-1]=0;}
    uint32_t f=plat_lock();float actual=actual_value[i];plat_unlock(f);
    value_text(actual,value);
    const uint8_t *v=loader_visual();const char *unit="%";
    if(v && i<rm_u16(v+10))unit=(const char *)(v+16+24*rm_u16(v+6)+4*rm_u16(v+8)+12*i);
    cv_rect(7,52,226,64,C_WHITE);cv_rect(8,53,224,62,PLAYER_BG);
    cv_text(17,57,&FONT_B,name,C_GRAY);
    cv_text(17,78,&FONT_L,value,C_WHITE);
    int x=19+text_w(&FONT_L,value);if(x+text_w(&FONT_XS,unit)<222)cv_text(x,94,&FONT_XS,unit,C_GRAY);
    char knob[8]="K1";knob[1]=(char)('1'+i%4);cv_text(201,58,&FONT_T,knob,C_GRAY);
}
static void draw_parameter_overlay(int unused){
    (void)unused;cv_begin(240,64,PLAYER_BG);cv_oy=-52;overlay_contents();cv_blit(0,82);
}
static void draw_visual(void){
    const uint8_t *v=loader_visual();
    uint32_t nodes=rm_u16(v+6),lines=rm_u16(v+8);
    const uint8_t *segments=v+16+24*nodes;
    // Reuse the player's 64-row canvas; no extra framebuffer or DSP allocation.
    for(int top=0;top<166;top+=56){
        cv_begin(240,top+56>166?166-top:56,PLAYER_BG);cv_oy=-top;
        for(uint32_t i=0;i<lines;++i){const uint8_t *s=segments+4*i;cv_line(s[0],s[1],s[2],s[3],RGB(120,120,120));}
        for(uint32_t i=0;i<nodes;++i){
            const uint8_t *b=v+16+24*i;
            int selected=overlay_parameter>=0 && b[4]==overlay_parameter;
            int active=b[4]!=255 && b[4]/4==knob_bank;
            uint16_t border=selected?C_WHITE:active?RGB(205,205,205):RGB(125,125,125);
            cv_rect(b[0],b[1],b[2],b[3],border);
            cv_rect(b[0]+1,b[1]+1,b[2]-2,b[3]-2,selected?RGB(90,90,90):PLAYER_BG);
            char label[16];unsigned n=0;while(n<15 && b[8+n]){label[n]=(char)b[8+n];++n;}label[n]=0;
            while(n && text_w(&FONT_GRAPH,label)>b[2]-5)label[--n]=0;
            cv_text(b[0]+3,b[1]+1,&FONT_GRAPH,label,active||selected?C_WHITE:C_GRAY);
            if(b[5])cv_rect(b[0]+2,b[1],2,1,C_GRAY);
            if(b[6])cv_rect(b[0]+2,b[1]+b[3]-1,2,1,C_GRAY);
        }
        overlay_contents();cv_blit(0,30+(unsigned)top);
    }
}
