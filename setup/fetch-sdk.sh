#!/bin/bash
# Recreate the minimal, no-radio SDK checkout from JieLi's official repository.
set -euo pipefail
source "$(dirname "$0")/env.sh"
revision=d179b4484759423312073f5fbb232501aa491047
mkdir -p "$AC79_SDK"
cd "$AC79_SDK"
if [[ ! -d .git ]]; then
    git init -q
    git remote add origin https://gitee.com/Jieli-Tech/fw-AC79_AIoT_SDK.git
fi
git fetch --depth 1 --filter=blob:none https://gitee.com/Jieli-Tech/fw-AC79_AIoT_SDK.git "$revision"
git sparse-checkout set --no-cone /LICENSE /README.md /.gitignore \
    /cpu/wl82/tools/uboot.boot /cpu/wl82/tools/cfg_tool.bin /cpu/wl82/tools/cfg/eq_cfg_hw.bin
git checkout --detach "$revision"
python3 "$FM1_WORKSPACE/setup/verify-sdk.py"
