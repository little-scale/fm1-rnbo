#!/usr/bin/env python3
"""Build and verify the visual player and saw module; no hardware writes."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
from package import parse
APP=Path(__file__).resolve().parents[1]


def main():
    checkpoint=APP/'build/checkpoints/before-visual-overview'
    if not checkpoint.exists():
        checkpoint.mkdir(parents=True)
        for name in ['rnbo-player.fwsc','rnbo-player.bin','rnbo-player.elf','player-review.json']:
            source=APP/'build'/name
            if source.exists():shutil.copy2(source,checkpoint/name)
        for source in (APP/'modules').glob('*/build/*.rnbom'):
            shutil.copy2(source,checkpoint/source.name)
    subprocess.run([sys.executable,APP/'tools/build.py','--player-only'],check=True)
    subprocess.run([sys.executable,APP/'tools/build.py','--patch','saw_cutoff_delay'],check=True)
    subprocess.run([sys.executable,APP/'tests/saw-delay.py'],check=True)
    player=json.loads((APP/'build/player-review.json').read_text())
    assert player.get('visual_overview') and player.get('battery_indicator') and player.get('parameter_overlay_ms')==1500
    assert player['sha256']==hashlib.sha256((APP/'build/rnbo-player.fwsc').read_bytes()).hexdigest()
    module=APP/'modules/saw_cutoff_delay'
    package=(module/'build/saw_cutoff_delay.rnbom').read_bytes()
    parse(package)
    review=json.loads((module/'build/review.json').read_text())
    assert review.get('visual_overview') and review.get('visual_bytes',0)>0
    assert review['sha256']==hashlib.sha256(package).hexdigest()
    print('PASS native visual player, battery, 1500 ms overlay, saw layout, package integrity and host audio; ready for installation.',flush=True)


if __name__=='__main__':main()
