#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Check actual prepared RNBO list storage and copying with UBSAN."""
import argparse,subprocess,tempfile
from pathlib import Path
CPP='\n#include "platform.h"\n#include "RNBO_Debug.h"\n#include "RNBO_List.h"\nextern "C" void *malloc(size_t);\nextern "C" void *realloc(void*,size_t);\nextern "C" void abort(void);\nnamespace rnbo_fm1_platform {\nvoid *allocate(size_t n){return malloc(n);}\nvoid *resize(void*p,size_t n){return realloc(p,n);}\nvoid report(const char*){}\n[[noreturn]] void fail(const char*){abort();__builtin_unreachable();}\n}\nint main(){\n RNBO::list original;original.fill(0,0,64);\n for(unsigned i=0;i<64;++i)original[i]=i;\n RNBO::list copy(original),assigned;assigned=original;\n RNBO::listbase<float,8> converted(original);\n for(unsigned i=0;i<64;++i)if(copy[i]!=i||assigned[i]!=i||converted[i]!=i)return 1;\n RNBO::list variadic(0.f,1.f,2.f,3.f,4.f,5.f,6.f,7.f,8.f,9.f,10.f,11.f,12.f,13.f,14.f,15.f,16.f,17.f,18.f,19.f,20.f,21.f,22.f,23.f,24.f,25.f,26.f,27.f,28.f,29.f,30.f,31.f,32.f);\n for(unsigned i=0;i<33;++i)if(variadic[i]!=i)return 2;\n return 0;\n}\n'
def main():
 p=argparse.ArgumentParser();p.add_argument('--export',type=Path,required=True);a=p.parse_args()
 app=Path(__file__).resolve().parents[3]/'rnbo'
 with tempfile.TemporaryDirectory() as directory:
  root=Path(directory);source=root/'lists.cpp';source.write_text(CPP);obj=root/'lists.o';exe=root/'lists'
  flags=['-fsanitize=undefined','-fno-sanitize-recover=all']
  subprocess.run(['clang++','-std=c++11','-fno-exceptions','-nostdinc++','-O1',*flags,'-I'+str(a.export.resolve()/'common'),'-I'+str(app),'-c',str(source),'-o',str(obj)],check=True)
  subprocess.run(['clang',*flags,str(obj),'-lm','-o',str(exe)],check=True)
  subprocess.run([str(exe)],check=True)
 print('PASS RNBO 64-element same/cross-capacity copies and assignment; 33-element construction (UBSAN)')
if __name__=='__main__':main()
