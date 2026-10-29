#!/usr/bin/env python3
"""Compile the real RNBO export without libc++, then test the C ABI and audio."""
import os
import subprocess
import sys
from pathlib import Path

APP = Path(__file__).resolve().parents[1]
OUT = APP / "build"
OUT.mkdir(exist_ok=True)
sanitize = "--sanitize" in sys.argv
asan = "--asan" in sys.argv
suffix = "-asan" if asan else "-san" if sanitize else ""
common = ["-O1" if sanitize else "-O2", "-g", "-ffp-contract=off", "-I" + str(APP)]
if sanitize or asan:
    common += ["-fsanitize=address,undefined" if asan else "-fsanitize=undefined", "-fno-sanitize-recover=all", "-fno-omit-frame-pointer"]
cpp = [os.environ.get("CXX", "clang++"), *common, "-std=c++11",
       "-fvisibility=hidden", "-fno-exceptions", "-fno-rtti", "-fno-threadsafe-statics", "-fno-use-cxa-atexit", "-nostdinc++",
       "-DPLAT_HOST", "-I" + str(APP / "export/common")]
def run(args):
    print("Running", Path(str(args[0])).name, flush=True)
    subprocess.run(list(map(str, args)), check=True, timeout=60)
obj = OUT / ("bridge" + suffix + ".o")
testobj = OUT / ("audio" + suffix + ".o")
exe = OUT / ("audio-test" + suffix)
run([*cpp, "-c", APP / "bridge.cpp", "-o", obj])
run([os.environ.get("CC", "clang"), *common, "-std=c11", "-c", APP / "tests/audio.c", "-o", testobj])
# Deliberately use the C linker: no C++ standard library/runtime dependency.
run([os.environ.get("CC", "clang"), *common, obj, testobj, "-lm", "-o", exe])
run([exe, OUT / ("rnbo-audition" + suffix + ".wav")])
