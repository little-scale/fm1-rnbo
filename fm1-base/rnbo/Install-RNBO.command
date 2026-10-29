#!/bin/bash
# Review the existing package, then use the upstream installer's confirmation.
set -uo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
rnbo_task_workspace="$(cd "$rnbo_task_dir/../.." && pwd)"
cd "$rnbo_task_workspace" || exit 1
source setup/env.sh
mkdir -p "$rnbo_task_dir/build"
python3 "$rnbo_task_dir/tools/review-device.py" > "$rnbo_task_dir/build/install-review.log" 2>&1
rnbo_task_result=$?
if [ "$rnbo_task_result" -eq 0 ]; then
    echo "RNBO experimental instrument: hardware audio timing is unverified."
    echo "This replaces the current firmware. Keep USB connected during the update."
    echo "After installation: lower the volume, play a key, then try K1/K2/K3."
    python3 fm1-base/tools/fm1_install.py "$rnbo_task_dir/build/rnbo.fwsc" 2>&1 | tee "$rnbo_task_dir/build/install.log"
    rnbo_task_result=$?
else
    cat "$rnbo_task_dir/build/install-review.log"
fi
echo
echo "Install exit code: $rnbo_task_result"
if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_task_answer; fi
exit "$rnbo_task_result"
