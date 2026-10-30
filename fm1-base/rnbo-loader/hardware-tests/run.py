#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Build the playable qualification collection. Does not upload to hardware."""
import argparse, concurrent.futures, hashlib, json, shutil, subprocess, sys, time
from pathlib import Path
ROOT = Path(__file__).resolve().parent
APP = ROOT.parent
OUT = APP / 'build/hardware-tests'

def build(job):
    case, native = job
    ident = case['id']
    folder = OUT / ident
    folder.mkdir(parents=True, exist_ok=True)
    shutil.copy2(ROOT / 'patches' / ident / 'module.json', folder / 'module.json')
    command = [sys.executable, str(APP / 'tools/build.py'), '--patch', str(ROOT / case['source']), '--module-dir', str(folder)]
    if not native:
        command.append('--host')
    start = time.monotonic()
    r = subprocess.run(command, capture_output=True, text=True, timeout=240)
    (folder / 'build.log').write_text(r.stdout + r.stderr)
    result = dict(id=ident, title=case['title'], bank=case['bank'], slot=case['slot'], build='pass' if r.returncode == 0 else 'fail', seconds=round(time.monotonic() - start, 2), source_sha256=hashlib.sha256((ROOT / case['source']).read_bytes()).hexdigest(), native_build=native, hardware_test=False)
    if r.returncode == 0:
        probe = subprocess.run([sys.executable, str(ROOT / 'probe.py'), str(folder / 'build' / f'{ident}.dylib'), '--id', ident], capture_output=True, text=True, timeout=90)
        (folder / 'audition.log').write_text(probe.stdout + probe.stderr)
        if probe.returncode:
            result.update(audition='fail', error=probe.stderr[-1800:])
        else:
            result.update(audition='pass', measurements=json.loads(probe.stdout))
    else:
        result['error'] = str((folder / 'build.log').relative_to(APP))
    (folder / 'result.json').write_text(json.dumps(result, indent=2) + '\n')
    print(ident + ': ' + result['build'] + ' / audition ' + result.get('audition', 'not run'), flush=True)
    return result

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--native', action='store_true')
    p.add_argument('--bank', type=int, choices=range(1, 6))
    p.add_argument('--only', default='')
    p.add_argument('--jobs', type=int, default=3)
    p.add_argument('--list', action='store_true')
    a = p.parse_args()
    cases = json.loads((ROOT / 'manifest.json').read_text())['patches']
    cases = [c for c in cases if (not a.bank or c['bank'] == a.bank) and (not a.only or a.only in c['id'])]
    if not cases:
        p.error('No matching patches')
    if a.list:
        for c in cases:
            print(f"{c['bank']}/{c['slot']} {c['id']}: {c['title']}")
        return
    if not 1 <= a.jobs <= 6:
        p.error('--jobs must be 1..6')
    OUT.mkdir(parents=True, exist_ok=True)
    with concurrent.futures.ThreadPoolExecutor(max_workers=a.jobs) as ex:
        rows = list(ex.map(build, [(c, a.native) for c in cases]))
    (OUT / 'latest-run.json').write_text(json.dumps({'native_build': a.native, 'hardware_test': False, 'patches': rows}, indent=2) + '\n')
    if any((r['build'] != 'pass' or r.get('audition') != 'pass' for r in rows)):
        sys.exit(1)
if __name__ == '__main__':
    main()
