#!/usr/bin/env python3
"""Reproduce the bundled patch export, audio checks, IR audit and panel scenario."""
import json
import os
import subprocess
import sys
from pathlib import Path

APP = Path(__file__).resolve().parents[1]
OUT = APP / "build"
LOGS = OUT / "verification"
LOGS.mkdir(parents=True,exist_ok=True)
(OUT/"panel").mkdir(exist_ok=True)
steps=[
    ("export",["node",APP/"tools/export.cjs"]),
    ("float32",["node",APP/"tests/float32.cjs"]),
    ("audio",[sys.executable,APP/"tools/test.py"]),
    ("ubsan",[sys.executable,APP/"tools/test.py","--sanitize"]),
    ("ir-audit",[sys.executable,APP/"tools/audit.py"]),
    ("abi32-preflight",[sys.executable,APP/"tools/preflight.py"]),
    ("ir-audit32",[sys.executable,APP/"tools/audit.py","--abi32"]),
    ("size32-long",[sys.executable,APP/"tools/audit.py","--size32-long"]),
    ("host-build",[sys.executable,APP/"tools/build.py","--host"]),
    ("panel",[APP/"build/host/rnbo_host",APP/"tests/panel.txt",OUT/"panel"])
]
device_status=OUT/"device-status.json"
report={"stages":{},"device_build":"not run by this host verifier",
        "last_device_attempt":json.loads(device_status.read_text()) if device_status.exists() else None,
        "device_installed":False,"target_timing_verified":False,
        "address_sanitizer":"unverified: even an empty ASan program timed out in this execution environment"}
env=dict(os.environ,PYTHON="python3")
for name,command in steps:
    result=subprocess.run(list(map(str,command)),capture_output=True,text=True,env=env,timeout=60)
    output=result.stdout+result.stderr
    (LOGS/(name+".log")).write_text(output)
    report["stages"][name]={"passed":result.returncode==0,"log":name+".log"}
    print(name+": "+("PASS" if result.returncode==0 else "FAIL"),flush=True)
    if result.returncode:
        print(output);(LOGS/"summary.json").write_text(json.dumps(report,indent=2)+'\n');raise SystemExit(result.returncode)
(LOGS/"summary.json").write_text(json.dumps(report,indent=2)+'\n')
print("Host verification complete. No device installation was attempted.")
