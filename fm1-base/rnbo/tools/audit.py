#!/usr/bin/env python3
"""Check host LLVM IR for double arithmetic in DSP loops and their callees.

This is a portability check, not target disassembly or a CPU benchmark.
"""
import json
import os
import re
import subprocess
import sys
from pathlib import Path
from build import APP, CPP_FLAGS

OUT = APP / "build"
export_at=sys.argv.index('--export')+1 if '--export' in sys.argv else 0
export=Path(sys.argv[export_at]).resolve() if export_at else APP/'export'
if export_at:OUT=export.parent/'build'
OUT.mkdir(exist_ok=True)
abi32 = "--abi32" in sys.argv
size32long = "--size32-long" in sys.argv
ir = OUT / ("bridge-size32-long.ll" if size32long else "bridge-audit32.ll" if abi32 else "bridge-audit.ll")
profile = ["-target","wasm32-unknown-unknown","-ffreestanding","-fno-builtin"] if size32long else ["-target", "armv7-none-eabi", "-mcpu=cortex-m4", "-mfloat-abi=softfp", "-mfpu=fpv4-sp-d16",
           "-ffreestanding", "-fno-builtin"] if abi32 else ["-DPLAT_HOST"]
pool_bytes=int(sys.argv[sys.argv.index('--pool-bytes')+1]) if '--pool-bytes' in sys.argv else 98304
custom=[f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{export}/rnbo_source.h"',f'-DRNBO_FM1_POOL_BYTES={pool_bytes}'] if export_at else []
subprocess.run([os.environ.get("CXX", "clang++"), *CPP_FLAGS, *profile, *custom, "-O1", "-fno-inline",
                "-ffp-contract=off", "-I"+str(APP), "-I"+str(export/"common"), "-S", "-emit-llvm",
                str(APP/"bridge.cpp"), "-o", str(ir)], check=True)
functions = {}
for match in re.finditer(r'^define[^\n]*@([^\s(]+)\([^\n]*\)[^\n]*\{\n(.*?)^}', ir.read_text(), re.M|re.S):
    functions[match[1]] = match[2]
double = re.compile(r'\b(?:fadd|fsub|fmul|fdiv|frem|fcmp)\b[^\n]*\bdouble\b')
call = re.compile(r'\bcall\b[^@\n]*@([^\s(]+)')
violations = []
fast_phase=bool(re.search(r"#define RNBO_FM1_FAST_PHASE 1\b",(export/"patch_config.h").read_text()))
wide_conversion=re.compile(r"\bfpto(?:si|ui)\b[^\n]*\bto i64\b")
wide_dsp_functions=[name for name,body in functions.items() if "_perform" in name and wide_conversion.search(body)]
if fast_phase and wide_dsp_functions:violations.append({"reason":"64-bit float-to-integer conversion remains in optimized DSP","functions":wide_dsp_functions})
loops_checked = 0
callees_checked = set()

def unknown_double_call(body):
    # Internal getters may return stored float64 data without doing arithmetic.
    # Their bodies are audited recursively; external/indirect calls stay unsafe.
    for line in body.splitlines():
        if re.search(r'\bcall\s+double\b',line):
            target=call.search(line)
            if target is None or target[1] not in functions:return True
    return False

def visit(name, seen):
    if name in seen or name not in functions:
        return
    seen.add(name);callees_checked.add(name)
    body = functions[name]
    if double.search(body):violations.append({"function":name,"reason":"double arithmetic in a DSP-loop callee"})
    if unknown_double_call(body):violations.append({"function":name,"reason":"double-returning math call in a DSP-loop callee"})
    for other in call.findall(body):visit(other,seen)

for name, body in functions.items():
    if "_perform" not in name:
        continue
    blocks={};current="entry";blocks[current]=[]
    for line in body.splitlines():
        m=re.match(r'^([\w.]+):',line)
        if m:current=m[1];blocks[current]=[]
        else:blocks[current].append(line)
    edges={b:set(re.findall(r'label %([\w.]+)',"\n".join(lines))) for b,lines in blocks.items()}
    def reaches(start,target,seen):
        if start==target:return True
        if start in seen:return False
        seen.add(start)
        return any(reaches(n,target,seen) for n in edges.get(start,()))
    for block, lines in blocks.items():
        if not any(reaches(n,block,set()) for n in edges[block]):continue
        loops_checked+=1;text="\n".join(lines)
        if double.search(text):violations.append({"function":name,"block":block,"reason":"double arithmetic inside DSP loop"})
        if unknown_double_call(text):violations.append({"function":name,"block":block,"reason":"double-returning math call inside DSP loop"})
        for other in call.findall(text):visit(other,set())

initializers=[]
for name, body in functions.items():
    if name.startswith('__cxx_global_var_init'):
        initializers+=call.findall(body)
unhandled=[n for n in initializers if 'RNBO12GlobalRandom' not in n and n!='exp2f' and not n.startswith('llvm.invariant.start.')]
if unhandled:violations.append({"reason":"unhandled C++ global constructor","calls":unhandled})
result={"kind":"32-bit unsigned-long size_t ABI proxy" if size32long else "32-bit ABI proxy LLVM IR audit" if abi32 else "host LLVM IR portability audit", "sample_loop_blocks_checked":loops_checked,
        "loop_callees_checked":len(callees_checked),"explicitly_initialized_RNBO_PRNG":bool(initializers),
        "reviewed_global_initializer_calls":initializers,
        "fast_phase":fast_phase,"wide_dsp_conversion_functions":wide_dsp_functions,
        "violations":violations,"target_timing_verified":False}
(OUT/("size32-long.json" if size32long else "audit32.json" if abi32 else "audit.json")).write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
if not loops_checked or violations:raise SystemExit(1)
