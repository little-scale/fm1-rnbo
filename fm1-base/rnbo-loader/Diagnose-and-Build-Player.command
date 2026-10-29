#!/bin/bash
# Read crash evidence first, then build only the corrected player. No install/reboot.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.." || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build/diagnostics-2026-10-29"
echo "Reading the saved crash report. This does not retry or reboot the patch."
python3 fm1-base/tools/fm1_remote.py log 2>&1 | tee "$rnbo_task_dir/build/diagnostics-2026-10-29/device-crash.log"
echo
echo "Building the corrected player. Existing patch modules are retained."
python3 "$rnbo_task_dir/tools/build.py" --player-only 2>&1 | tee "$rnbo_task_dir/build/device-build.log"
rnbo_task_result=$?
echo "Player build exit code: $rnbo_task_result. Nothing was installed."
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
