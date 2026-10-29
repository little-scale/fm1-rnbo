#!/bin/bash
# Builds the permanent firmware and the three separate patches. Installs nothing.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
rnbo_task_workspace="$(cd "$rnbo_task_dir/../.." && pwd)"
cd "$rnbo_task_workspace" || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build.py" 2>&1 | tee "$rnbo_task_dir/build/device-build.log"
rnbo_task_result=$?
echo
echo "Build exit code: $rnbo_task_result. Nothing was installed."
if [ "$rnbo_task_result" -eq 0 ]; then echo "Player: $rnbo_task_dir/build/rnbo-player.fwsc";echo "Patches: modules/mono/build/mono.rnbom, modules/fm/build/fm.rnbom and modules/fm8/build/fm8.rnbom";fi
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
