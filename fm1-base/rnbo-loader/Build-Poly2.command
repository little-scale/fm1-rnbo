#!/bin/bash
# Builds the permanent firmware and the two-voice FM8 patch. Installs nothing.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
rnbo_task_workspace="$(cd "$rnbo_task_dir/../.." && pwd)"
cd "$rnbo_task_workspace" || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build.py" --poly2 2>&1 | tee "$rnbo_task_dir/build/poly2-build.log"
rnbo_task_result=$?
echo
echo "Build exit code: $rnbo_task_result. Nothing was installed."
if [ "$rnbo_task_result" -eq 0 ]; then echo "Player: $rnbo_task_dir/build/rnbo-player.fwsc";echo "Patch: modules/fm8poly2/build/fm8poly2.rnbom";fi
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer;fi
exit "$rnbo_task_result"
