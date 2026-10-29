/* SPDX-License-Identifier: MIT */
/* Standalone module libc subset. No import addresses from player firmware. */
#include <stddef.h>
void *memcpy(void *d,const void *s,size_t n){unsigned char *a=d;const unsigned char *b=s;for(size_t i=0;i<n;++i)a[i]=b[i];return d;}
void *memset(void *d,int v,size_t n){unsigned char *a=d;for(size_t i=0;i<n;++i)a[i]=(unsigned char)v;return d;}
void *memmove(void *d,const void *s,size_t n){unsigned char *a=d;const unsigned char *b=s;if(a<b)for(size_t i=0;i<n;++i)a[i]=b[i];else while(n){--n;a[n]=b[n];}return d;}
int memcmp(const void *d,const void *s,size_t n){const unsigned char *a=d,*b=s;for(size_t i=0;i<n;++i)if(a[i]!=b[i])return a[i]-b[i];return 0;}
