#!/bin/bash
# Double-click in Finder to BUILD ONLY. This never flashes a device.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
rnbo_task_workspace="$(cd "$rnbo_task_dir/../.." && pwd)"
cd "$rnbo_task_workspace" || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/build.py" --device --experimental-soft-double 2>&1 | tee "$rnbo_task_dir/build/device-attempt.log"
rnbo_task_result=$?
echo
echo "Device build exit code: $rnbo_task_result"
if [ "$rnbo_task_result" -eq 0 ]; then
    echo "Built: $rnbo_task_dir/build/rnbo.fwsc"
    echo "Nothing was installed. Target timing remains unverified."
else
    echo "No successful device build. See $rnbo_task_dir/build/device-attempt.log"
fi
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer; fi
exit "$rnbo_task_result"
