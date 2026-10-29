#!/bin/bash
# Build the optimized two-voice patch only. No firmware build or installation.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.." || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build.py" --patch fm8poly2fast 2>&1 | tee "$rnbo_task_dir/build/fast-poly2-build.log"
rnbo_task_result=$?
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
