#!/usr/bin/env python3
"""Check the completed build, then use the normal firmware install confirmation."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
APP=Path(__file__).resolve().parents[1]
p=APP/'build/rnbo-player.fwsc';review=json.loads((APP/'build/player-review.json').read_text())
if not review.get('module_pc_guard_extension'):raise SystemExit('Rebuild the player with the RAM execution-guard fix before installing.')
if not review.get('raw_midi_abi2'):raise SystemExit('Rebuild the player with polyphonic MIDI support before installing this revision.')
if review.get('patch_slots')!=3 or not review.get('presets_patch_selection'):raise SystemExit('Rebuild the player with three-slot PRESETS support before installing this revision.')
if review['identity']!='FM-1_9400' or hashlib.sha256(p.read_bytes()).hexdigest()!=review['sha256']:raise SystemExit('Player package differs from reviewed build')
print('Install the three-slot RNBO Player. Existing stored patches migrate to patch slot 1.',flush=True)
print('Use PRESETS to cycle occupied slots. SAVE stores this slot’s controls and startup selection. Use Open-Patch-Loader.command to upload from a browser.',flush=True)
raise SystemExit(subprocess.call([sys.executable,str(APP.parent/'tools/fm1_install.py'),str(p)]))
