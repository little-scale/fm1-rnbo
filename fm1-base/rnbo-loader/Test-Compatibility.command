#!/bin/bash
set -euo pipefail
compat_app_dir="$(cd "$(dirname "$0")" && pwd -P)"
cd "$compat_app_dir/../.."
source setup/env.sh
python3 "$compat_app_dir/tools/compatibility.py" --resume --reference-retry "$@"
