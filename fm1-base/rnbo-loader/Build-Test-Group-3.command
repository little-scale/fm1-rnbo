#!/bin/bash
# SPDX-License-Identifier: MIT
set -euo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.."
source setup/env.sh
mkdir -p "$rnbo_task_dir/build/hardware-tests"
rnbo_test_finish() {
    rnbo_test_status=$?
    if [ "$rnbo_test_status" -ne 0 ]; then
        echo "Group 3 preparation failed. No firmware or patches were uploaded."
        echo "Log: $rnbo_task_dir/build/hardware-tests/prepare-group-3.log"
    fi
    if [ -t 0 ]; then read -r -p "Press Return to close this window. " rnbo_test_answer || true; fi
    exit "$rnbo_test_status"
}
trap rnbo_test_finish EXIT
python3 "$rnbo_task_dir/hardware-tests/prepare.py" --bank 3 2>&1 | tee "$rnbo_task_dir/build/hardware-tests/prepare-group-3.log"
