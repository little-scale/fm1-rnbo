# FM1 RNBO Studio

Studio brings the permanent player, three patch slots, the complete 15-patch
collection and the local converter into one browser interface.

## Local/offline folder release

For daily use, follow [QUICKSTART.md](../QUICKSTART.md). The local kit has one
launcher and carries the converter source, pinned compiler archive, cached
Linux amd64 Docker image, reviewed player and all 15 patches. RNBO stays in
its installed Mac location. The first launch verifies/unpacks the compiler
and imports the image locally if missing, then opens the converter and library
together. No Git, Python packages, SDK downloads or original development
checkout are needed on the receiving Mac. Python 3.12+, Node.js 20+, Apple's
command-line tools, Docker Desktop, Chrome/Edge and authorized RNBO 1.4.4 must
be installed separately. A **Max 9 license** and a **separate RNBO license**
are required; install and authorize Max 9 and RNBO before offline use. Neither
license is supplied by this release. This is a folder release, not a bundled desktop app.

From the configured Mac project, cache the pinned image once while online:

```sh
source setup/env.sh
docker pull --platform linux/amd64 "$JIELI_DOCKER_IMAGE"
bash fm1-base/rnbo-loader/Build-Local-Studio.command
```

The builder checks existing caches before native builds and never downloads
dependencies itself. It produces `rnbo-loader/build/studio-local/` and its ZIP.
Use `--reuse` to package reviewed existing native builds, or `--output` for a
fresh destination. The existing static release builder below is unchanged.

The kit's `Check-Setup.command` inspects readiness without importing/extracting
anything. Its `Open-Studio.command` starts the local service and validates that
the compiler can execute. The compiler uses an immutable cached image ID,
`--pull=never`, `--network=none` and a separate container identity so a prior
network-enabled development container is not reused. Source conversion still
runs the same portability audits, host audio probe and native package checks.
The release retains source snapshots and component notices.

Validate a real kit on the intended Mac with the internet disconnected: build
a newly saved `.rnbopat`, check its layout status, upload it, then verify
PRESETS and per-slot SAVE/startup recall. Automated tests use synthetic
compiler/image artifacts and cannot replace that check.

## Build a release candidate on the Mac

Use the normal configured project folder: Setup.command completed, RNBO 1.4.4
installed and Docker Desktop running. From the repository root:

```sh
bash fm1-base/rnbo-loader/Build-Studio-Release.command
bash fm1-base/rnbo-loader/Open-Studio.command
```

The build produces `fm1-base/rnbo-loader/build/studio-release/` and its ZIP.
It compiles the player and all 15 patches, runs each patch's existing host
audition, then verifies native-build status, package reviews, current source
hashes, module settings and RNBO export provenance. Firmware identity remains
`FM-1_9400` for player/module compatibility; `release.json` separately records
the release version, optional source commit, source fingerprint and asset hashes.
Git is optional for building: a plain working folder uses the shipped list of
public source paths for its source archive and records no Git commit. The
fingerprint and artifact checks still apply. Git is needed only for publishing
source changes to GitHub.

Nothing is installed or uploaded by the release builder. Its native checks
do not prove FM1 CPU use or physical browser transfer. A failed build produces
no ready release directory. Outputs use a staging directory and are renamed
only after all assets and corresponding sources are collected.

To package already reviewed native artifacts, including a player built with
`RNBO_PLAYER_FONT=barlow`, use:

```sh
source setup/env.sh
python3 fm1-base/rnbo-loader/tools/release.py --reuse --version 0.1.0
```

Existing release directories are preserved. For a later build, choose a fresh
output directory and open that release explicitly:

```sh
bash fm1-base/rnbo-loader/Build-Studio-Release.command --version 0.1.1 --output /absolute/path/studio-0.1.1
source setup/env.sh
python3 fm1-base/rnbo-loader/tools/launch.py --release /absolute/path/studio-0.1.1/web
```

## Use Studio

1. For a first install or update, expand **Install or update RNBO Player
   firmware**, connect one FM1 by USB and click **Install Released Player**.
   Allow MIDI/SysEx. Keep USB connected until the player reconnects. The image
   is checked against the release hash, expected identity and update-loader
   marker before updater traffic starts. A downloaded copy of the exact same
   firmware can be selected instead of downloading it again.
2. Click **Find USB MIDI Device**, choose the FM1, then **Connect**. Firmware
   installation releases the patch uploader's ports first; reconnect afterward.
3. Choose a library instrument. This downloads and checks it but does not write
   anything to the FM1. Select a slot and click **Upload Patch**. That slot is
   replaced and the new instrument becomes active. Other slots remain stored.
4. Alternatively, choose a standalone `.rnbopat`, select its voice count and
   click **Build & Upload**, or **Build Only** to download a compiled `.rnbom`.
   These actions use the local source checkout's existing converter. Use a
   compiled `.rnbom` directly when no converter is available.
5. PRESETS cycles occupied slots. SAVE stores that slot's controls/octave and
   makes it the startup selection. A migrated single-patch bank occupies slot 1.

Slot buttons show a patch title after an upload has been acknowledged and its
destination slot confirmed. Names are remembered per MIDI device in this
browser and Studio address. Reconnected/cached names say **Last known**, since
the current firmware reports occupancy rather than titles. Refresh removes a
remembered title if the active patch ID changed, and empty slots clear their
names. Uploads made with other tools can leave inactive cached names out of
date; those names remain explicitly marked as remembered.

Studio uses a black background with white text, borders, controls and progress
bars. Disabled buttons use dotted borders; keyboard focus retains a white
outline. No firmware change is required for this browser presentation.

After loading or building a compiled patch, Studio shows **Screen: patch
overview** and its object count when the module contains a checked visual
layout. Otherwise it shows **Screen: parameter list**; new builds include the
fallback reason. Layout generation keeps every top-level object and connection
(comments and panels are omitted), with subpatches represented by one box.
When compressed labels collide, a second placement pass uses free space above
and left as well as below and right. The source patch is never rearranged.
The existing limits remain 96 objects and 384 wire segments; patches that
cannot fit legibly use the parameter list. Rebuild and upload existing modules
to embed a newly generated layout. Updating Studio alone does not change
patches already stored on the FM1.

For audio-modulated `comb~`/`allpass~` delay times, expand **Build Settings**
and declare their maximum in milliseconds before building. This activates the
existing bounded float32 filter adaptation. Blank retains automatic inference
for constants/direct bounded parameters; the setting caps these filter inputs
and does not enlarge the patch arena. See [bounded filters](../fm1-base/rnbo-loader/BOUNDED-FILTERS.md).

Only one firmware update, patch transfer or local build can run in this page
at a time. Firmware interruption leaves the upstream updater's recovery path:
reconnect and install the same release again. Resumed writes check that the
RNBO Player returns before reporting success. M-VAVE Open firmware retains the
upstream requirement to return to stock before installing this player.
See the upstream [recovery tools](https://github.com/hugelton/felucca-bsp/tree/main/tools).

## Portable bundle and hosted website

The generated release folder contains:

| File | Purpose |
| --- | --- |
| `Open-Studio.command` | Start/reuse the background static server; requires Python 3 |
| `web/index.html` | Entry point for HTTPS hosting |
| `web/firmware/rnbo-player.fwsc` | Reviewed permanent player |
| `web/patches/*.rnbom` | All 15 compiled instruments; the FM1 stores three at a time |
| `web/release.json` | Version, identity, sizes, SHA-256 hashes and patch descriptions |
| `web/sources.zip` | Working source snapshot, named Studio integration files and all 15 generated RNBO exports/reviews |
| `web/LICENSES/`, `web/LICENSING.md`, `web/Barlow-OFL.txt` | Licensing and component notices |

Serve the contents of `web/` over HTTPS for browser MIDI permission support.
Relative asset URLs also work beneath a path such as `/fm1-rnbo/`. Keep the
manifest and binaries from the same release together. The converter's API is
loopback-only and authenticated; an HTTPS site does not reach into the local
compiler. To compile, open Studio from the configured source checkout instead.

The portable launcher intentionally serves static assets only. It does not
need RNBO, Node, Docker or Python MIDI packages. If hosting over HTTPS, users
need no local server at all. A direct `file://` opening is not the supported
workflow. An existing unrelated service or old uploader is left running; the
launcher selects another local port. The matching Studio service is reused.

## Source and fonts

Release builds rasterize the vendored Barlow fonts at full black/white coverage.
Normal developer builds retain their existing Arial default. The source ZIP
contains Git-indexed project files (or existing files from the shipped source
inventory in a plain folder), the named Studio integration files and the explicit generated export/
review files; unrelated untracked documents, logs, credentials, toolchain
binaries and SDK downloads are excluded. Generated source retains RNBO's
notices. Dependencies are retrieved with the pinned setup scripts.

The combined player retains the existing GPL-3.0-or-later terms and component
notices. See [LICENSING.md](../LICENSING.md). The release builder makes a local
candidate; it does not upload binaries or publish a GitHub release.

## Automated checks without RNBO or hardware

```sh
node fm1-base/rnbo-loader/tests/studio.cjs
node fm1-base/rnbo-loader/tests/studio-ui.cjs
python3 fm1-base/rnbo-loader/tests/studio-release.py
node fm1-base/rnbo-loader/tests/browser-flow.cjs
python3 fm1-base/rnbo-loader/tests/build-service.py
python3 fm1-base/rnbo-loader/tests/offline.py
```

These cover manifest bounds and asset paths, checked downloads, firmware
resume/identity verification, cleanup on failure, mutual exclusion, selection
without upload, static hosting, isolated build-service boundaries, exact
source packaging and background-service reuse/shutdown. MIDI and native
compiler results are simulated in these checks. The complete compiler-dependent
suite includes the Studio tests through `tools/verify.py`.

Before calling the first candidate device-tested, check firmware installation,
one interrupted-update recovery, browser uploads into all three slots, PRESETS,
per-slot SAVE/startup recall and conversion of a new `.rnbopat` on the Mac/FM1.
