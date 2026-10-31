# FM1 Studio — local/offline quickstart

Keep the whole release folder together in **Documents**. Open
**Open-Studio.command** whenever you want to use Studio.

## Install once on the Mac

- A **Max 9 license**.
- A **separate RNBO license**.
- **Max 9** and **RNBO 1.4.4**, installed and authorized before going offline.
- **Chrome or Edge**, **Python 3.12+**, **Node.js 20+**, **Docker Desktop** and
  Apple's command-line tools (`xcode-select --install`).

Both licenses are required. Installing the RNBO package alone is insufficient;
the release does not include either license.

The release includes the converter, compiler caches, player and all 15 test
instruments. It needs no Git, `pip`, virtual environment, SDK download or
original development folder. The applications above remain separate installs.

## Open and play

1. Start **Docker Desktop** and wait until it is running.
2. Double-click **Open-Studio.command**. First launch prepares the cached
   compiler locally; allow it to finish. Studio opens in Chrome/Edge.
3. Connect the FM1 with a USB data cable. Click **Find USB MIDI Device**, choose
   the FM1, then **Connect**. Allow **MIDI including SysEx**.
4. If needed, expand **Install or update RNBO Player firmware** and click
   **Install Released Player**. Keep USB connected, then reconnect Studio after
   the device restarts. This replaces the firmware; do it once.
5. Choose a library instrument, select **Slot 1, 2 or 3**, then **Upload Patch**.
   The upload replaces that slot and makes it active.

**PRESETS** switches occupied slots. **SAVE** stores this slot's controls and
startup selection. **FX** switches the two banks of four knobs.

## Build your own patch

1. Save from **inside the RNBO editor** as a standalone `.rnbopat`. Embed
   subpatchers/Gen and use stereo `out~ 1` / `out~ 2`.
2. Drop it into Studio and choose **Mono, 2 voices or 4 voices**.
3. Choose a slot and click **Build & Upload**. **Build Only** creates a
   downloadable `.rnbom` without an FM1 connected.

Expose knobs with RNBO `param` objects and `@displayorder 1` through `8`.
If modulated `comb~`/`allpass~` bounds cannot be inferred, enter their maximum
delay in **Build Settings**. Studio reports whether the module contains a
**patch overview** or uses the **parameter list**. Rebuild/upload after editing.

When finished, use **Stop Local Service** and close the tab. The launcher's
Terminal window can close once Studio opens. Reopen the launcher after moving
the release folder.

## Troubleshooting

Run **Check-Setup.command** for a readiness report. It does not download,
extract or import anything.

- Missing tools: install the named prerequisite, then reopen Studio.
- No device: check the data cable, close other MIDI uploaders and confirm the
  RNBO Player is installed.
- Custom RNBO location: `RNBO_DIR="/path/to/RNBO" bash "/path/to/Open-Studio.command"`.
- macOS blocks a downloaded launcher: use Finder's Open action, or type `bash `
  in Terminal and drag the launcher into the window, then press Return.

Before relying on offline use, disconnect the internet, build a new patch,
upload it and check PRESETS/SAVE on the FM1.

## Preparing the release — maintainer only

From the configured development folder, cache the image once while online:

```sh
source setup/env.sh
docker pull --platform linux/amd64 "$JIELI_DOCKER_IMAGE"
bash fm1-base/rnbo-loader/Build-Local-Studio.command
```

Output: `fm1-base/rnbo-loader/build/studio-local/` and `studio-local.zip`.
Append `--reuse` to package reviewed existing builds; choose a fresh
`--output /absolute/path/FM1-Studio` for later releases. Nothing is uploaded
by this command. See [the full guide](converter/docs/STUDIO.md) inside a local
release, or [the repository guide](docs/STUDIO.md) in the development folder.
