#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Measure oversized baseline objects in a diagnostic host-only 2 MiB arena.
This deliberately bypasses the DSP audit to measure allocation. It cannot
produce an FM1 package and never changes the production memory allowance.
"""
import argparse,ctypes as C,importlib.util,json,subprocess
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
spec=importlib.util.spec_from_file_location('resource_api',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)
def main():
    parser=argparse.ArgumentParser();parser.add_argument('--report',type=Path,default=APP/'build/compatibility/report.json');args=parser.parse_args()
    root=args.report.resolve().parent;rows=json.loads(args.report.read_text())['cases'];results=[]
    for name in ['average~ 32','average_rms~ 32','allpass~ 16 0.5','comb~ 16 0.5 0.5 0.5']:
        row=next(c for c in rows if c['name']==name);export=root/'runs'/row['id']/'production/module/export'
        header=export/('rnbo_source.unbounded-average.h' if name.startswith('average') else 'rnbo_source.unbounded.h')
        if not header.exists():header=export/'rnbo_source.h'
        out=APP/'build/compatibility-resources'/row['id'];out.mkdir(parents=True,exist_ok=True);obj=out/'resource.o';lib=out/'resource.dylib'
        flags=['-std=c++11','-fno-exceptions','-fno-rtti','-fno-threadsafe-statics','-fno-use-cxa-atexit','-nostdinc++','-fvisibility=hidden','-DPLAT_HOST','-O2','-ffp-contract=off','-DRNBO_FM1_POOL_BYTES=2097152','-I'+str(export/'common'),f'-DRNBO_FM1_PATCH_CONFIG="{export}/patch_config.h"',f'-DRNBO_FM1_PATCH_SOURCE="{header}"']
        subprocess.run(['clang++',*flags,'-c',str(APP/'modules/entry.cpp'),'-o',str(obj)],check=True)
        subprocess.run(['clang','-dynamiclib',str(obj),'-lm','-o',str(lib)],check=True)
        handle=C.CDLL(str(lib));api=probe.Api.in_dll(handle,'rnbo_module');assert C.CFUNCTYPE(C.c_int)(api.init)()==1
        stats=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(stats))
        assert stats.pool_used>131072 and not(stats.errors or stats.bad_samples)
        results.append(dict(case=name,host_arena_used=stats.pool_used,diagnostic_arena_capacity=stats.pool_capacity,production_arena_max=131072,hardware_test=False,compatibility_pass=False))
    path=APP/'build/compatibility-resources/result.json';path.write_text(json.dumps(results,indent=2)+'\n');print(json.dumps(results,indent=2))
if __name__=='__main__':main()
