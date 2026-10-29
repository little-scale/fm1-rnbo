#!/bin/bash
# Double-click in Finder. Uses the existing local workspace and Python setup.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
rnbo_task_workspace="$(cd "$rnbo_task_dir/../.." && pwd)"
cd "$rnbo_task_workspace" || exit 1
source setup/env.sh
python3 "$rnbo_task_dir/tools/verify.py"
rnbo_task_result=$?
echo
echo "Verification exit code: $rnbo_task_result"
echo "Logs: $rnbo_task_dir/build/verification"
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer; fi
exit "$rnbo_task_result"
