/* SPDX-License-Identifier: MIT */
/* Freestanding RNBO platform. Exported runtime ABI adaptations are recorded in provenance.json. */
#pragma once
#define RNBO_USE_FLOAT32
#define RNBO_NOSTDLIB
#define RNBO_NOSTL
#define RNBO_NOTHROW
#define RNBO_USECUSTOMPLATFORM
#define RNBO_NO_PATCHERFACTORY
#define RNBO_FIXEDLISTSIZE 16
/* Replace the desktop logger, which otherwise needs a global constructor. */
#define RNBO_LoggerImpl_h
#include "RNBO_Types.h"

namespace rnbo_fm1_platform {
void *allocate(size_t size);
void *resize(void *ptr, size_t size);
void report(const char *message);
[[noreturn]] void fail(const char *message);
}
namespace RNBO { namespace Platform {
inline void *memcpy(void *dest, const void *src, size_t n) {
    auto d=static_cast<unsigned char*>(dest); auto s=static_cast<const unsigned char*>(src);
    for(size_t i=0;i<n;++i) d[i]=s[i]; return dest;
}
inline void *memmove(void *dest, const void *src, size_t n) {
    auto d=static_cast<unsigned char*>(dest); auto s=static_cast<const unsigned char*>(src);
    if(d<s) for(size_t i=0;i<n;++i) d[i]=s[i];
    else for(size_t i=n;i;--i) d[i-1]=s[i-1]; return dest;
}
inline void *memset(void *dest,int c,size_t n) {
    auto d=static_cast<unsigned char*>(dest); for(size_t i=0;i<n;++i) d[i]=static_cast<unsigned char>(c); return dest;
}
inline size_t strlen(const char *s) { size_t n=0; while(s[n]) ++n; return n; }
inline int strcmp(const char *a,const char *b) { while(*a && *a==*b){++a;++b;} return static_cast<unsigned char>(*a)-static_cast<unsigned char>(*b); }
inline void *malloc(size_t n) { return rnbo_fm1_platform::allocate(n); }
inline void free(void *) {} // monotonic arena: reclaimed as a whole on reinitialisation
inline void *realloc(void *p,size_t n) { return rnbo_fm1_platform::resize(p,n); }
inline void *calloc(size_t n,size_t size) {
    if(size && n>SIZE_MAX/size) rnbo_fm1_platform::fail("allocation overflow");
    return memset(malloc(n*size),0,n*size);
}
inline void printMessage(const char *s) { rnbo_fm1_platform::report(s); }
inline void printErrorMessage(const char *s) { rnbo_fm1_platform::report(s); }
[[noreturn]] inline void abort() { rnbo_fm1_platform::fail("RNBO abort"); }
template<class T> inline T errorOrDefault(RuntimeError,const char *s,T value) { printErrorMessage(s); return value; }
template<class T> inline T assertTrueOrDefault(bool ok,const char *s,T value) { if(!ok) printErrorMessage(s); return value; }
inline void error(RuntimeError,const char *s) { printErrorMessage(s); }
inline void assertTrue(bool ok,const char *s) { if(!ok) printErrorMessage(s); }
template<class T> inline void toString(char *str,size_t n,T) {
    const char *s="<value>"; size_t i=0; if(!n)return;
    while(i+1<n && s[i]){str[i]=s[i];++i;}str[i]=0;
}
}}
inline void *operator new(size_t,void *p) noexcept { return p; }
inline void operator delete(void *,void *) noexcept {}
