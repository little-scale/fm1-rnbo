#!/bin/bash
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.." || exit 1
source setup/env.sh
python3 "$rnbo_task_dir/tools/install.py" 2>&1 | tee "$rnbo_task_dir/build/install-player.log"
rnbo_task_result=$?
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
