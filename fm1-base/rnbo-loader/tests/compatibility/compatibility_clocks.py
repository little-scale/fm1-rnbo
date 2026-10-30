#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Nested clock targets must work with the conservative phase profile too."""
import json,subprocess,sys
from pathlib import Path
HERE=Path(__file__).resolve().parent;APP=HERE.parents[1]
sys.path.insert(0,str(HERE))
from fixtures import make_cases
def main():
    case=next(c for c in make_cases() if c.name=='nested scheduler target')
    out=APP/'build/compatibility-profile-clocks';out.mkdir(exist_ok=True)
    source=out/'nested_clock.rnbopat';source.write_text(json.dumps(case.patch));module=out/'module';module.mkdir(exist_ok=True)
    (module/'module.json').write_text(json.dumps(dict(case.config,fast_phase=False)))
    r=subprocess.run([sys.executable,str(APP/'tools/build.py'),'--host','--patch',str(source),'--module-dir',str(module)],text=True,capture_output=True)
    (out/'build.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
    r=subprocess.run([sys.executable,str(HERE/'probe.py'),str(module/'build/nested_clock.dylib'),'--assertion','audible'],text=True,capture_output=True)
    (out/'runtime.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr
    print('PASS nested scheduler target with phase optimization disabled')
if __name__=='__main__':main()
