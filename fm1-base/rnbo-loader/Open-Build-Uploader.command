#!/bin/bash
set -euo pipefail
rnbo_task_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$rnbo_task_dir/../.."
source setup/env.sh
python3 "$rnbo_task_dir/tools/serve.py"
