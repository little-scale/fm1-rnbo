#!/usr/bin/env python3
"""RNBO-only C++ build adapter. Leaves the pinned upstream builder untouched."""
import argparse
import importlib.util
import json
import os
import subprocess
import sys
from pathlib import Path

APP = Path(__file__).resolve().parents[1]
BASE = APP.parent
WORKSPACE = BASE.parent
CPP_FLAGS = ["-std=c++11", "-fno-exceptions", "-fno-rtti",
             "-fno-threadsafe-statics", "-fno-use-cxa-atexit", "-nostdinc++", "-fvisibility=hidden"]

def main():
    ap = argparse.ArgumentParser(description=__doc__)
    mode = ap.add_mutually_exclusive_group()
    mode.add_argument("--host", action="store_true", help="build the complete FM1 host simulator (default)")
    mode.add_argument("--device", action="store_true", help="attempt a JieLi device build; never installs firmware")
    ap.add_argument("--experimental-soft-double", action="store_true",
                    help="permit RNBO's software-double code in this experiment only; hardware timing is unverified")
    a = ap.parse_args()
    # Make the RNBO driver usable directly, without asking the user to source
    # environment variables or locate the enclosing workspace themselves.
    os.environ.setdefault("AC79_SDK",str(WORKSPACE/"dependencies/ac79-sdk"))
    os.environ.setdefault("JIELI_TOOLCHAIN",str(WORKSPACE/"dependencies/jieli/jieli-linux-toolchains-20260730.1"))
    image=WORKSPACE/"setup/docker-image.txt"
    if image.exists():os.environ.setdefault("JIELI_DOCKER_IMAGE",image.read_text().strip())
    if not (APP / "export/rnbo_source.h").exists():
        raise SystemExit("Export a patch first: node rnbo/tools/export.cjs")
    sys.path.insert(0, str(BASE / "tools"))
    spec = importlib.util.spec_from_file_location("fm1_upstream_build", BASE / "tools/build.py")
    upstream = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(upstream)
    original_tc = upstream.tc
    def tc(tool, *args):
        args = list(args)
        if tool == "cc" and any(str(p).endswith(".cpp") for p in args):
            args = [*CPP_FLAGS, "-x", "c++", *args]
        if tool == "pi32v2/bin/ld" and "--gc-sections" in args and any(str(p).endswith("bridge.o") for p in args):
            # The base startup is C-only. Keep RNBO's constructor table in XIP;
            # bridge.cpp walks it once, before patch construction/audio startup.
            at = args.index("-T")+1
            source = Path(args[at]).read_text()
            derived = upstream.OUT / "rnbo-app.ld"
            marker="*(.text*) *(.rodata*)"
            if source.count(marker)!=1:raise SystemExit("Upstream linker layout changed: review RNBO constructor insertion")
            constructor_table=(" . = ALIGN(4); _rnbo_init_array_start = .; KEEP(*(SORT(.init_array.*))) KEEP(*(.init_array)) _rnbo_init_array_end = .; "
                "_rnbo_ctors_start = .; KEEP(*(SORT(.ctors.*))) KEEP(*(.ctors)) _rnbo_ctors_end = .; ")
            derived.write_text(source.replace(marker,marker+constructor_table))
            args[at] = derived
            tcroot = Path("/opt/jieli") if upstream.use_docker() else upstream.toolchain()
            lib = tcroot / "pi32v2/lib/r3"
            args += ["--start-group", str(lib / "libm.a"), str(lib / "libcompiler-rt.a"), "--end-group"]
        return original_tc(tool, *args)
    upstream.tc = tc
    def host_objects(cc, flags, out):
        out.mkdir(parents=True, exist_ok=True)
        objects = []
        for source in upstream.o2_files():
            obj = out / ("_".join(source.relative_to(APP).with_suffix("").parts) + ".o")
            if source.suffix == ".cpp":
                compiler = os.environ.get("CXX", "clang++")
                more = CPP_FLAGS
                useflags = [f for f in flags if not f.startswith("-std=")]
            else:
                compiler, more, useflags = cc, [], flags
            subprocess.run([compiler, *useflags, *more, "-I" + str(source.parent), "-c", str(source), "-o", str(obj)], check=True)
            objects.append(str(obj))
        return objects
    upstream.o2_objects = host_objects
    original_check = upstream.check
    def check(*args):
        errors, notes = original_check(*args)
        soft = [e for e in errors if e.startswith("soft-double routines linked:")]
        if soft and a.experimental_soft_double:
            errors = [e for e in errors if e not in soft]
            notes += ["EXPERIMENTAL RNBO: " + e for e in soft]
            notes.append("Software-double code explicitly permitted for this RNBO build; target timing UNVERIFIED")
        return errors, notes
    upstream.check = check
    sys.argv = [str(BASE / "tools/build.py"), str(APP), "--no-ble"]
    if not a.device:
        sys.argv += ["--host"]
    else:
        subprocess.run([sys.executable,str(WORKSPACE/"setup/verify-sdk.py")],check=True)
        subprocess.run([sys.executable,str(APP/"tools/preflight.py")],check=True)
        subprocess.run([sys.executable,str(APP/"tools/audit.py")],check=True)
        subprocess.run([sys.executable,str(APP/"tools/audit.py"),"--abi32"],check=True)
        subprocess.run([sys.executable,str(APP/"tools/audit.py"),"--size32-long"],check=True)
    result = upstream.main()
    if a.device and result in (None, 0):
        subprocess.run([sys.executable, str(APP / "tools/review-device.py")], check=True)
    return result

if __name__ == "__main__":
    device_requested="--device" in sys.argv
    def record_device(success,error=None):
        if not device_requested:return
        out=APP/"build";out.mkdir(exist_ok=True)
        package=out/"rnbo.fwsc"
        (out/"device-status.json").write_text(json.dumps({"success":bool(success),"error":error,
            "package":str(package) if success and package.exists() else None,
            "installed":False,"target_timing_verified":False},indent=2)+'\n')
    try:
        result=main()
    except BaseException as error:
        record_device(False,str(error));raise
    else:
        record_device(result in (None,0));sys.exit(result)
