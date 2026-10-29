#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
python3 -m venv .venv
.venv/bin/python -m pip install -r setup/requirements-lock.txt -r setup/requirements-midi-lock.txt
bash setup/fetch-sdk.sh
bash setup/fetch-toolchain.sh
echo "Setup complete. Start Docker Desktop and install RNBO 1.4.4 in Max before building."
echo "Run: bash fm1-base/rnbo-loader/Build-and-Install-Visual-Player.command"
