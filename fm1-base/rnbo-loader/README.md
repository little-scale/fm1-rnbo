# RNBO Player

The current player, patch sources, module builder, browser uploader and tests.
See the [project README](../../README.md) for setup, controls and installation.

- `app.c`: audio-owner command queue, keyboard/MIDI routing, knob banks and UI.
- `engine.c`, `format.c`: three-slot bank, transaction recovery, module validation.
- `module.h`, `loader.h`: module and player interfaces; ABI 1 mono / ABI 2 raw MIDI.
- `visual.h`, `visual-ui.h`, `battery.h`: bounded overview metadata, popup and sensor.
- `tools/layout.py`: build-time parser of original RNBO object coordinates/cords.
- `tools/build.py`: code generation, host/audio/portability checks, native packaging.
- `tools/build_visual.py`: checkpoint and validate the visual player/saw builds.
- `tools/upload.py`: patch transfer, activation and destination verification.
- `tools/serve.py`, `tools/build_service.py`, `web/`: localhost build/uploader UI.
- `tests/`: audio, UI, battery, storage, protocol and browser regression checks.

The 64 KiB module image and 176 KiB state reservations are checked at build
and upload time. Optional layout metadata leaves the original ABI 1/2 table
intact: old modules use the parameter list, and old players ignore the layout.
The graph reuses the existing small canvas. Audio publishes converted values;
the UI never accesses the running RNBO patch directly.

Generated exports, local logs, packages and other build outputs are excluded
from Git. Module output reviews and export provenance are generated locally.
See [validation](../../docs/validation.md) for the tested hardware snapshot and
[licensing](../../LICENSING.md) for the battery adapter and platform terms.
