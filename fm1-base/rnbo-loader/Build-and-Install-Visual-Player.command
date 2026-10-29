#!/bin/bash
set -euo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.."
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build_visual.py" 2>&1 | tee "$rnbo_task_dir/build/visual-device-build.log"
python3 "$rnbo_task_dir/tools/install.py" 2>&1 | tee "$rnbo_task_dir/build/install-visual-player.log"
python3 "$rnbo_task_dir/tools/upload.py" "$rnbo_task_dir/modules/saw_cutoff_delay/build/saw_cutoff_delay.rnbom" --slot 1 2>&1 | tee "$rnbo_task_dir/build/upload-visual-saw.log"
