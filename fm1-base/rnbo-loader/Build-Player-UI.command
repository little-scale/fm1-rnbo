#!/bin/bash
# Rebuild only the player for UI changes. Never installs or rebuilds patches.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.." || exit 1
source setup/env.sh
python3 "$rnbo_task_dir/tools/build.py" --player-only 2>&1 | tee "$rnbo_task_dir/build/device-build.log"
rnbo_task_result=$?
echo "Player build exit code: $rnbo_task_result. Nothing was installed."
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
