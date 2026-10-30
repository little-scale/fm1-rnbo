#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Build the native player and one test group, then collect reviewed upload files."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
APP = ROOT.parent
OUT = APP / 'build/hardware-tests'
sys.path.insert(0, str(APP / 'tools'))
from package import parse


def read_json(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def collect(bank):
    cases = [c for c in read_json(ROOT / 'manifest.json')['patches'] if c['bank'] == bank]
    require(sorted(c['slot'] for c in cases) == [1, 2, 3], 'Expected three distinct slots')
    player = APP / 'build/rnbo-player.fwsc'
    player_review = read_json(APP / 'build/player-review.json')
    status = read_json(APP / 'build/device-build-status.json')
    require(status.get('success') and not status.get('host') and status['stages'].get('player', {}).get('passed'), 'Player native build did not pass')
    require(player_review['sha256'] == digest(player), 'Player differs from reviewed build')
    require(player_review['identity'] == 'FM-1_9400' and player_review.get('patch_slots') == 3, 'Expected the three-slot RNBO player')
    require(all(player_review.get(k) for k in ('module_pc_guard_extension', 'raw_midi_abi2', 'presets_patch_selection', 'visual_overview')), 'Missing player features')
    packages = []
    for case in cases:
        ident = case['id']
        folder = OUT / ident
        result = read_json(folder / 'result.json')
        status = read_json(folder / 'build/device-build-status.json')
        require(result.get('native_build') is True and result.get('build') == 'pass' and result.get('audition') == 'pass', f'{ident}: native build/audition did not pass')
        require(status.get('success') and not status.get('host') and status['stages'].get(ident, {}).get('passed'), f'{ident}: target build did not pass')
        require(result['source_sha256'] == digest(ROOT / case['source']), f'{ident}: source changed after build')
        require(read_json(folder / 'module.json') == read_json(ROOT / 'patches' / ident / 'module.json'), f'{ident}: module settings changed')
        package = folder / 'build' / f'{ident}.rnbom'
        metadata = parse(package.read_bytes())
        review = read_json(folder / 'build/review.json')
        require(review['sha256'] == digest(package), f'{ident}: package differs from reviewed build')
        require(metadata['title'] == ident.upper() and all(review.get(k) == v for k, v in metadata.items()), f'{ident}: package identity mismatch')
        require(review.get('undefined_symbols') == [], f'{ident}: unresolved target symbols')
        packages.append((case, package, review))

    # Create a fresh folder only after every candidate passes; preserve older results.
    destination = Path(tempfile.mkdtemp(prefix=f'group-{bank}-ready-', dir=OUT))
    shutil.copy2(player, destination / player.name)
    shutil.copy2(APP / 'build/player-review.json', destination / 'player-review.json')
    rows = [f'# FM1 RNBO hardware test group {bank}', '',
            'Native builds and host auditions passed. Physical playback and FM1 CPU use remain untested.', '',
            '1. If the FM1 is running another project or an older player, install this RNBO player using `Install-Player.command` in the rnbo-loader folder. This changes the device firmware; its existing installer provides the normal confirmation.',
            '2. Run `Open-Build-Uploader.command` in the same folder, connect the FM1 and choose the three-slot destinations below.',
            '3. Select the compiled `.rnbom` files from this folder for upload. These preserve the tested module settings.',
            '4. Use PRESETS for patches and FX for K1–K4 / K5–K8. K1 is Level, K7 Attack, K8 Release.',
            '5. Test notes/velocity, both knob pages, stereo/meters, SAVE and power-cycle recall. PLAY should silence notes and effect tails. Record CPU and any glitches in HARDWARE-RESULTS.csv.', '',
            '| Slot | File | Image bytes | State bytes |', '| --- | --- | --- | --- |']
    for case, package, review in packages:
        shutil.copy2(package, destination / package.name)
        shutil.copy2(package.parent / 'review.json', destination / f"{case['id']}-review.json")
        rows.append(f"| {case['slot']} | {package.name} | {review['image_bytes']:,} | {review['state_bytes']:,} |")
    for case, _, _ in packages:
        rows.extend(['', f"## Slot {case['slot']}: {case['title']}", '', case['listen'], '',
                     '| Knob | Parameter | Range | Default |', '| --- | --- | --- | --- |'])
        for index, param in enumerate(case['parameters'], 1):
            rows.append(f"| K{index} | {param['label']} | {param['min']}–{param['max']} {param['unit']} | {param['default']} |")
        if case['id'] == 't03_lists':
            rows.extend(['', 'Set Step to 63 to hear the First control: the stored list is reversed.'])
        if case['id'] == 't08_table':
            rows.extend(['', 'Use stereo monitoring. The 256-frame stereo table is generated inside the patch; no sample file is required. The right channel reads an inverted table, so summing to mono at Offset 0 can cancel. Mix compares nearest and linear reads on the left channel. The difference is subtle with this 256-frame table; pan left to isolate it.'])
        if case['id'] == 't09_gendelay':
            rows.extend(['', 'Both taps share a 2,048-sample delay. The right tap clamps at that limit when Time × Spread exceeds it. Compare Mix 0 and Mix 1 with short notes; Mix 1 removes the immediate dry signal.'])
    (destination / 'START-HERE.md').write_text('\n'.join(rows) + '\n')
    with (ROOT / 'HARDWARE-RESULTS.csv').open(newline='') as source:
        columns = next(csv.reader(source))
    with (destination / 'HARDWARE-RESULTS.csv').open('w', newline='') as target:
        writer = csv.DictWriter(target, fieldnames=columns)
        writer.writeheader()
        for case, _, review in packages:
            writer.writerow(dict(group=bank, slot=case['slot'], patch=case['id'], native_package_sha256=review['sha256'], player_firmware_sha256=player_review['sha256'], native_build='pass'))
    return destination


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bank', type=int, choices=range(1, 6), default=1)
    args = parser.parse_args()
    check = subprocess.run(['docker', 'info', '--format', '{{.ServerVersion}}'], capture_output=True, text=True, timeout=20)
    if check.returncode:
        raise RuntimeError('Docker is unavailable. Run this launcher from normal macOS Terminal with Docker Desktop running.\n' + check.stderr.strip())
    print('Docker ' + check.stdout.strip(), flush=True)
    print('Building the three-slot visual RNBO player...', flush=True)
    subprocess.run([sys.executable, str(APP / 'tools/build.py'), '--player-only'], check=True)
    print(f'Building and auditioning group {args.bank} (three patches)...', flush=True)
    subprocess.run([sys.executable, str(ROOT / 'run.py'), '--native', '--bank', str(args.bank), '--jobs', '1'], check=True)
    destination = collect(args.bank)
    print(f'\nREADY: {destination}\nRead START-HERE.md in that folder. No firmware or patches have been uploaded.', flush=True)
    if sys.platform == 'darwin':
        subprocess.run(['open', str(destination)], check=False)


if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, RuntimeError, subprocess.SubprocessError) as error:
        print(f'Preparation stopped: {error}', file=sys.stderr)
        sys.exit(1)
