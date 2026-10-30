#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Exercise all five three-slot groups in the host player, without a device."""
import json, os, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent
APP = ROOT.parent
OUT = APP / 'build/hardware-tests'

def main():
    cases = json.loads((ROOT / 'manifest.json').read_text())['patches']
    results = []
    for bank in range(1, 6):
        group = [c for c in cases if c['bank'] == bank]
        folder = OUT / 'panels' / f'bank-{bank}'
        folder.mkdir(parents=True, exist_ok=True)
        commands = ['wait 100']
        for c in group:
            commands += [f"patchslot {c['slot']} {c['id']}", f"expect patch_slot {c['slot']}"]
        commands += ['expect patch_slots 7']
        for c in group:
            commands += ['spin PRESET 1', 'wait 80', f"expect patch_slot {c['slot']}", 'expect params 8', 'expect visual 1', 'expect battery 3', 'expect battery_usb 1', 'key 7 down', 'wait 350', 'expect meter_left 1', 'expect meter_right 1', f"shot {c['id']}-overview.png", 'spin K1 3', 'wait 60', 'expect overlay 0', f"shot {c['id']}-bank1.png", 'tap FX', 'wait 60', 'expect bank 1', 'spin K1 3', 'wait 60', 'expect overlay 4', f"shot {c['id']}-bank2.png", 'key 7 up', 'tap SAVE', 'wait 60', 'expect dirty 0']
        commands += ['reboot', 'wait 150', 'expect patch_slot 3', 'expect patch_slots 7', 'expect params 8', 'expect faults 0', 'expect drops 0']
        script = folder / 'script.txt'
        script.write_text('\n'.join(commands) + '\n')
        env = dict(os.environ, RNBO_HOST_MODULES=str(OUT), RNBO_HOST_PATCH=group[0]['id'], FMS_BATTERY_RAW='628', FMS_BATTERY_USB='1')
        r = subprocess.run([str(APP / 'build/host/rnbo-player_host'), str(script), str(folder)], env=env, capture_output=True, text=True, timeout=90)
        (folder / 'panel.log').write_text(r.stdout + r.stderr)
        results.append(dict(bank=bank, status='pass' if r.returncode == 0 else 'fail', hardware_test=False))
        print('bank', bank, results[-1]['status'], flush=True)
        if r.returncode:
            print(r.stdout + r.stderr)
    (OUT / 'panel-results.json').write_text(json.dumps(results, indent=2) + '\n')
    if any((r['status'] != 'pass' for r in results)):
        raise SystemExit(1)
if __name__ == '__main__':
    main()
