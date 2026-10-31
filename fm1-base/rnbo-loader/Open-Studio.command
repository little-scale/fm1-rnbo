#!/bin/bash
# SPDX-License-Identifier: MIT
set -euo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.."
if [ ! -f .venv/bin/python3 ]; then
    echo "Run Setup.command from the repository root before converting RNBO patches."
    exit 1
fi
source setup/env.sh
exec python3 "$rnbo_task_dir/tools/launch.py"
