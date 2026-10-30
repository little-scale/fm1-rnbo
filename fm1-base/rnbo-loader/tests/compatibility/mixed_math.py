#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Numerically check prepared RNBO mixed-type math against float32 libm."""
import argparse,ctypes as C,math,subprocess,tempfile
from pathlib import Path

def main():
    p=argparse.ArgumentParser();p.add_argument('--export',type=Path,required=True);a=p.parse_args()
    common=a.export.resolve()/'common'
    source='''
#define RNBO_USE_FLOAT32
#define RNBO_NOSTDLIB
#define RNBO_NOSTL
#include "RNBO_Types.h"
#include "RNBO_Math.h"
extern "C" {
float mixed_atan2(float y,int x){return RNBO_Math::rnbo_atan2(y,x);}
float mixed_pow(float x,int y){return RNBO_Math::rnbo_pow(x,y);}
float mixed_pow_reverse(int x,float y){return RNBO_Math::rnbo_pow(x,y);}
float integral_floor(long long x){return RNBO_Math::rnbo_floor(x);}
}
'''
    checks=0
    with tempfile.TemporaryDirectory() as directory:
        root=Path(directory);cpp=root/'math.cpp';cpp.write_text(source);lib=root/'math.dylib'
        subprocess.run(['clang++','-std=c++11','-fno-exceptions','-nostdinc++','-O2','-ffp-contract=off','-I'+str(common),'-c',str(cpp),'-o',str(root/'math.o')],check=True)
        subprocess.run(['clang','-dynamiclib',str(root/'math.o'),'-lm','-o',str(lib)],check=True)
        m=C.CDLL(str(lib));m.mixed_atan2.argtypes=[C.c_float,C.c_int];m.mixed_pow.argtypes=[C.c_float,C.c_int];m.mixed_pow_reverse.argtypes=[C.c_int,C.c_float];m.integral_floor.argtypes=[C.c_longlong]
        for name in ['mixed_atan2','mixed_pow','mixed_pow_reverse','integral_floor']:getattr(m,name).restype=C.c_float
        def same(actual,reference):
            nonlocal checks
            expected=C.c_float(reference).value
            assert math.isclose(actual,expected,rel_tol=3e-6,abs_tol=1e-37),(actual,expected)
            checks+=1
        for y in [-1000,-1,-.001,0,.001,1,1000]:
            for x in [-20,-1,0,1,20]:same(m.mixed_atan2(y,x),math.atan2(C.c_float(y).value,x))
        for x in [-10,-1,-.25,.25,1,10]:
            for y in [-3,-1,0,1,2,3]:same(m.mixed_pow(x,y),math.pow(C.c_float(x).value,y))
        for x in [1,2,3,10]:
            for y in [-2.5,-1,0,.25,.5,2.5]:same(m.mixed_pow_reverse(x,y),math.pow(x,C.c_float(y).value))
        for x in [-(1<<60),-(1<<31),-100,-1,0,1,100,(1<<24)+1,(1<<31),(1<<60)]:same(m.integral_floor(x),float(C.c_float(x).value))
    print('PASS',checks,'prepared RNBO float32 math comparisons')

if __name__=='__main__':main()
