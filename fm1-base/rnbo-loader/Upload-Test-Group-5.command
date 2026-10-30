#!/bin/bash
# SPDX-License-Identifier: MIT
# Upload the reviewed Group 5 modules. Does not install firmware.
set -euo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.."
source setup/env.sh
if [ "$#" -gt 1 ] || { [ "$#" -eq 1 ] && [ "$1" != "--check" ]; }; then
    echo "Usage: $0 [--check]"
    exit 2
fi
python3 - "$rnbo_task_dir" <<'PY'
import hashlib, json, sys
from pathlib import Path
app = Path(sys.argv[1])
sys.path.insert(0, str(app / 'tools'))
from package import parse
for slot, ident in enumerate(('t13_fm2', 't14_fm4echo', 't15_hybrid'), 1):
    folder = app / 'build/hardware-tests' / ident
    result = json.loads((folder / 'result.json').read_text())
    status = json.loads((folder / 'build/device-build-status.json').read_text())
    source = app / 'hardware-tests/patches' / ident
    package = folder / 'build' / (ident + '.rnbom')
    review = json.loads((folder / 'build/review.json').read_text())
    data = package.read_bytes()
    checks = (
        result.get('native_build') is True,
        result.get('build') == 'pass' and result.get('audition') == 'pass',
        status.get('success') is True and status.get('host') is False,
        status.get('stages', {}).get(ident, {}).get('passed') is True,
        result.get('source_sha256') == hashlib.sha256((source / (ident + '.rnbopat')).read_bytes()).hexdigest(),
        json.loads((source / 'module.json').read_text()) == json.loads((folder / 'module.json').read_text()),
        review.get('sha256') == hashlib.sha256(data).hexdigest(),
        review.get('undefined_symbols') == [],
    )
    metadata = parse(data)
    if not all(checks) or metadata['title'] != ident.upper() or any(review.get(k) != v for k, v in metadata.items()):
        raise SystemExit(ident + ': build review mismatch; rebuild Group 5 before uploading')
    print(f"Checked slot {slot}: {ident} ({metadata['image_bytes']:,} image bytes)", flush=True)
PY
if [ "${1:-}" = "--check" ]; then exit 0; fi

rnbo_upload_finish() {
    rnbo_upload_status=$?
    if [ "$rnbo_upload_status" -ne 0 ]; then
        echo "Upload stopped. Earlier successful slots may already contain their new patches."
        echo "Logs: $rnbo_task_dir/build/hardware-tests/upload-group-5-*.log"
    fi
    if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_upload_answer || true; fi
    exit "$rnbo_upload_status"
}
trap rnbo_upload_finish EXIT
echo "Loading Group 5 into slots 1, 2 and 3; existing patches in those slots will be replaced."
rnbo_test_slot=1
for rnbo_test_id in t13_fm2 t14_fm4echo t15_hybrid; do
    python3 "$rnbo_task_dir/tools/upload.py" "$rnbo_task_dir/build/hardware-tests/$rnbo_test_id/build/$rnbo_test_id.rnbom" --slot "$rnbo_test_slot" 2>&1 | tee "$rnbo_task_dir/build/hardware-tests/upload-group-5-slot-$rnbo_test_slot.log"
    rnbo_test_slot=$((rnbo_test_slot + 1))
done
python3 "$rnbo_task_dir/tools/upload.py" --slots 2>&1 | tee "$rnbo_task_dir/build/hardware-tests/upload-group-5-bank.log"
echo "Group 5 uploaded. Use PRESETS to select T13_FM2 (Patch 1 / 3), then play a note."
