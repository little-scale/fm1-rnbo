#!/bin/bash
# Compile/export only the patch, never the firmware. Optional first arg: .rnbopat path.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.." || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build.py" --patch "${1:-fm}" 2>&1 | tee "$rnbo_task_dir/build/patch-build.log"
rnbo_task_result=$?
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
