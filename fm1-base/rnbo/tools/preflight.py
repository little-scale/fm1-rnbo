#!/usr/bin/env python3
"""32-bit freestanding compile plus the actual JieLi maths-library closure.

ARM is an ABI/portability proxy only; it does not replace pi32v2 compilation.
"""
import json
import os
import re
import subprocess
from pathlib import Path
from build import APP,CPP_FLAGS
from linkcheck import Archive,closure,elf_symbols

workspace=APP.parents[1]
out=APP/'build/preflight';out.mkdir(parents=True,exist_ok=True)
flags=[os.environ.get('CXX','clang++'),'-target','armv7-none-eabi','-mcpu=cortex-m4',
       '-mfloat-abi=softfp','-mfpu=fpv4-sp-d16',*CPP_FLAGS,'-O2','-ffreestanding',
       '-fno-builtin','-ffp-contract=off','-I'+str(APP),'-I'+str(APP/'export/common')]
source=APP/'tools/layout.cpp';obj=out/'abi32.o';ir=out/'abi32.ll'
subprocess.run([*flags,'-c',str(source),'-o',str(obj)],check=True)
subprocess.run([*flags,'-S','-emit-llvm',str(source),'-o',str(ir)],check=True)
text=ir.read_text();m=re.search(r'@rnbo_fm1_layout\s*=.*?constant \[10 x i32\] \[(.*?)\]',text)
if not m:raise SystemExit('Could not read compile-time layout')
values=list(map(int,re.findall(r'i32 (\d+)',m[1])))
fields=['pointer_bytes','size_t_bytes','RNBO_Int_bytes','sample_bytes','timestamp_bytes',
        'patch_object_bytes','reserved_arena_bytes','output_buffers_bytes','scheduler_event_bytes','scheduler_bytes']
layout=dict(zip(fields,values))
lib=workspace/'dependencies/jieli/jieli-linux-toolchains-20260730.1/pi32v2/lib/r3'
archives=[Archive(lib/'libm.a'),Archive(lib/'libcompiler-rt.a')]
defined,undefined=elf_symbols(obj.read_bytes())
regular=sorted(n for n in undefined if not n.startswith('__aeabi_') and not n.startswith('__gnu_'))
# These are the actual software-double primitives used by RNBO's retained
# timestamp arithmetic. ARM helper names are not JieLi helper names.
double_helpers=['__adddf3','__subdf3','__muldf3','__divdf3','__extendsfdf2','__truncdfsf2',
                '__eqdf2','__nedf2','__ltdf2','__ledf2','__gtdf2','__gedf2']
unresolved,members=closure([*regular,*double_helpers],archives,provided=['memcpy','memset','memcmp','_rnbo_init_array_start','_rnbo_init_array_end','_rnbo_ctors_start','_rnbo_ctors_end'])
report={'kind':'32-bit ABI proxy and real JieLi archive preflight','proxy_cpu':'ARM Cortex-M4, float32 FPU',
        'is_fm1_machine_code':False,'layout':layout,'regular_c_dependencies':regular,
        'software_double_helpers_checked':double_helpers,'jieli_archive_members_needed':members,
        'unresolved_jieli_dependencies':unresolved,'pi32v2_compile_verified':False}
(out/'report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
if unresolved:raise SystemExit(1)
