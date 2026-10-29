#!/bin/bash
set -euo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.."
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build.py" --patch saw_cutoff_delay 2>&1 | tee "$rnbo_task_dir/build/saw-device-build.log"
python3 "$rnbo_task_dir/tests/saw-delay.py" 2>&1 | tee "$rnbo_task_dir/build/saw-audio-check.log"
python3 "$rnbo_task_dir/tools/upload.py" "$rnbo_task_dir/modules/saw_cutoff_delay/build/saw_cutoff_delay.rnbom" --slot 1 2>&1 | tee "$rnbo_task_dir/build/upload-saw.log"
