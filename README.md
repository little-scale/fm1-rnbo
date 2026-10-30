# fm1-rnbo

Run compiled RNBO instruments on the M-VAVE FM1, with a permanent player and
three stored patch slots. Upload a new instrument without reinstalling firmware.

![FM1 patch overview, parameter popup and knob banks](docs/visual-player.png)

The player provides eight parameter controls, MIDI and keyboard input, stereo
output meters, a battery indicator, saved controls and a patch overview derived
from the original RNBO layout. Turning a knob shows the parameter name and its
actual value for 1.5 seconds, then returns to the overview.

## Controls

| Control | Action |
| --- | --- |
| K1–K4 | Adjust the current bank's four parameters |
| FX | Switch between parameters 1–4 and 5–8 |
| PRESETS | Cycle occupied patch slots |
| SAVE | Save this slot's controls/octave and select it for startup |
| Octave buttons | Transpose the keyboard |
| PLAY | Panic / silence the instrument |
| MASTER | Output volume |

The battery icon uses three coarse voltage-based bars. A plug indicates USB
host power; it does not indicate charging or estimate remaining runtime.

## Build environment

The tested workflow uses macOS, Apple's command-line development tools, Python
3.12 or newer, Node.js, Docker Desktop and a local installation of **RNBO 1.4.4**.
The RNBO exporter is intentionally pinned to that version's internal APIs.
Set `RNBO_DIR` if RNBO is outside the usual Max application/package locations.
Arial is rasterized from the Mac's installed fonts during the local build.

```sh
git clone https://github.com/little-scale/fm1-rnbo.git
cd fm1-rnbo
bash Setup.command
```

Setup installs the Python dependencies and retrieves the pinned SDK packaging
files and JieLi compiler. It does not install anything on the FM1. Start Docker
Desktop before compiling native firmware. The platform source is vendored;
there are no Git submodules to initialize. See [UPSTREAM.md](UPSTREAM.md).

## First install

With the FM1 connected by USB, run:

```sh
bash fm1-base/rnbo-loader/Build-and-Install-Visual-Player.command
```

This checkpoints existing local builds, builds and validates the player and
saw patch, checks host audio, asks before installing firmware, then uploads the
saw patch to **slot 1**. It stops on failure. Firmware installation uses the
upstream installer's normal confirmation; do not unplug while it writes.

Build only, without installing:

```sh
source setup/env.sh
python3 fm1-base/rnbo-loader/tools/build.py --player-only
python3 fm1-base/rnbo-loader/tools/build.py --patch saw_cutoff_delay
```

The player and patches have separate builds. The player package is
`fm1-base/rnbo-loader/build/rnbo-player.fwsc`; modules are
`fm1-base/rnbo-loader/modules/NAME/build/NAME.rnbom`.

## Build and upload your own patch

Save the patch from inside the RNBO editor as a standalone `.rnbopat`, rather
than saving only its surrounding Max patch. Use a filename starting with a
letter and containing at most 24 letters, digits, underscores or hyphens.

```sh
bash fm1-base/rnbo-loader/Open-Build-Uploader.command
```

Open the local uploader in Chrome or Edge, connect to the FM1, choose a slot,
select the `.rnbopat`, choose Mono / 2 voices / 4 voices, then **Build & Upload**.
Keep the launcher's Terminal window open. The service runs on localhost;
compilation uses the local RNBO installation and Docker. Web MIDI handles USB
transfer. **Build Only** works without a connected FM1. Already compiled
`.rnbom` files can also be uploaded directly.

The command-line equivalent, from this repository root:

```sh
source setup/env.sh
python3 fm1-base/rnbo-loader/tools/build.py --patch /absolute/path/my_patch.rnbopat
python3 fm1-base/rnbo-loader/tools/upload.py fm1-base/rnbo-loader/modules/my_patch/build/my_patch.rnbom --slot 1
python3 fm1-base/rnbo-loader/tools/upload.py --slots
```

An upload replaces the chosen logical slot. PRESETS selects stored instruments;
one instrument runs at a time. SAVE remembers each slot's controls separately.
Unsaved control changes are discarded when changing slots.

## Patch conventions and limits

- Use `notein` for pitch/velocity MIDI events and `out~ 1` / `out~ 2` for stereo
  output. The player forwards its keyboard and incoming MIDI to the patch.
- Parameters follow RNBO's exported parameter indices. Use `@displayorder`
  to establish the intended order and `@displayname` for readable labels, then
  check the generated parameter description. The first eight map to the knobs.
  `@unit` supplies popup units; numeric values use RNBO's own conversion.
- The adapter allows up to 16 exported controls, with the first eight exposed
  by the current UI. Audio input patches are not supported by this revision.
- Mono, two-voice and four-voice builds are supported. FM4Echo demonstrates
  voice stealing with one shared master effect, rather than duplicating the
  delay for each voice. The browser recognizes this embedded voice group.
- Self-contained patches are supported. Embedded Gen graphs and GenExpr are supported within the documented
  [Gen limits](fm1-base/rnbo-loader/GEN-SUPPORT.md). External abstractions,
  sample files and external Gen dependencies require additional integration.
- Native code, data and optional layout metadata share a **64 KiB image**
  budget; module state has **176 KiB**. Builds reject exceeded limits.
- Layouts retain object arrangement and cords, shorten labels and separate
  overlapping boxes. Embedded subpatches remain boxes. Layouts beyond 96
  objects / 384 wire segments, or too dense to fit, use the parameter list.
  Old modules without metadata also retain the list and percentage popup.

## Supported RNBO objects, operations and structures

This is the **tested support inventory for this FM1 adapter with RNBO 1.4.4**, not a guarantee for every RNBO object, constructor or combination. The exporter delegates to the pinned RNBO compiler and audits the generated DSP; it does not implement a universal object whitelist. An unlisted object is unqualified, rather than necessarily unsupported. A listed name still has to pass the allocation, float32, image/state and native-build checks for the patch that uses it.

Evidence comes from the [RNBO compatibility matrix](fm1-base/rnbo-loader/COMPATIBILITY.md), [Gen expansion report](fm1-base/rnbo-loader/tests/compatibility/gen-results.json), [Gen support notes](fm1-base/rnbo-loader/GEN-SUPPORT.md) and [15 playable test patches](fm1-base/rnbo-loader/hardware-tests/README.md). The full object matrix and Gen expansion are host/portability evidence; selected playable patches also have separately recorded FM1 results. Passing an object fixture is not a native CPU or worst-case timing guarantee.

### RNBO objects and operations

The table includes the tested main objects plus the initialization, routing and voice helpers exercised by those graphs and the playable collection. `~` denotes the signal-rate form; unsuffixed names are event/control forms unless otherwise noted. Some names below have profile or constructor restrictions in the following table.

| Area | Tested objects / operations |
| --- | --- |
| Oscillators, noise and envelopes | `cycle~`, `phasor~`, `saw~`, `tri~`, `rect~`, `noise~`, `pink~`, `adsr~` |
| Signal arithmetic | `+~`, `-~`, `*~`, `/~`, `%~`, `abs~`, `min~`, `max~`, `clip~`, `scale~` |
| Signal powers, logs and rounding | `exp~`, `log~`, `log2~`, `log10~`, `pow~`, `sqrt~`, `ceil~`, `floor~`, `round~`, `trunc~` |
| Signal trigonometry | `sin~`, `cos~`, `tan~`, `asin~`, `acos~`, `atan~`, `atan2~`, `sinh~`, `cosh~`, `tanh~` |
| Signal comparison and logic | `>~`, `>=~`, `<~`, `<=~`, `==~`, `!=~`, `!~`, `&&~`, `\|\|~` |
| Signal state and smoothing | `delta~`, `change~`, `dcblock~`, `slide~`, `rampsmooth~`, `sah~`, `latch~`, `downsamp~` |
| Filters and measurements | `onepole~`, `butterworth~`, `lores~`, `svf~`, `biquad~`, `reson~`, `average~`, `average_rms~`, `peakamp~`, `snapshot~`, `zerox~` |
| Delays and signal feedback | `delay~`, `feedback~`, `comb~`, `allpass~` |
| Wrapping and folding | `wrap~`, `fold~` |
| Signal conversions | `mtof~`, `ftom~`, `dbtoa~`, `atodb~`, `mstosamps~`, `sampstoms~` |
| Event arithmetic and shaping | `+`, `-`, `*`, `/`, `%`, `abs`, `min`, `max`, `clip`, `wrap`, `fold`, `scale`, `fixnan`, `fixdenorm` |
| Event powers, logs and rounding | `exp`, `log`, `log2`, `log10`, `pow`, `sqrt`, `ceil`, `floor`, `round`, `trunc` |
| Event trigonometry | `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `atan2`, `sinh`, `cosh`, `tanh` |
| Event comparison and logic | `>`, `>=`, `<`, `<=`, `==`, `!=`, `!`, `&&`, `\|\|`, `and`, `or`, `xor` |
| Event conversions | `mtof`, `ftom`, `dbtoa`, `atodb`, `mstosamps`, `sampstoms` |
| Event storage, selection and lists | `float`, `int`, `change`, `accum`, `counter`, `gate`, `switch`, `select`, `split`, `trigger`, `t`, `route`, `prepend`, `append`, `pack`, `unpack`, `list.len`, `list.sum`, `list.median`, `list.thin`, `list.unique`, `list.rev`, `list.sort`, `list.slice`, `list.reg`, `list.join`, `list.nth`, `list.lookup` |
| Scheduling, initialization and messages | `metro`, `delay`, `pipe`, `line`, `line~`, `timer`, `loadbang`, `message`, `set` |
| Internal routing and signal/event ports | `send`, `receive`, `send~`, `receive~`, `sig~`, `in`, `in~`, `out~` |
| Local data and buffers | `data`, `buffer~`, `poke~`, `peek~` |
| Parameters and code | `param`, `param~`, `expr`, `codebox`, `codebox~` |
| MIDI input and voices | `midiin`, `notein`, `ctlin`, `bendin`, `touchin`, `polyin`, `pgmin`, `voice` |
| Containers | `p`, `gen~` |

### RNBO qualifications and limits

| Object / form | Qualification |
| --- | --- |
| `trunc~`, `wrap~`, `fold~`, `peakamp~ 10` | The recorded RNBO matrix passes these with `"fast_phase": false`. Set this in the selected build’s `module.json`; the browser does not automatically retry a conservative profile. Native image fit and CPU cost still need qualification. This restriction concerns these RNBO signal objects, not the separately tested Gen operators with similar names. |
| `downsamp~ 4` | The historical matrix needed the conservative profile. The later guarded counter adaptation supports a proven fixed positive integral factor, and T11 subsequently passed native build/playback with `fast_phase: true`. Dynamic, fractional or unrecognized forms are not covered by that adaptation and must pass their own audits. |
| `comb~`, `allpass~` | Use bounded delay rings. Tested examples include 16 ms, parameter bounds up to 32 ms and an explicit `filter_delay_max_ms` cap; sufficiently long/unknown declarations can still exceed the total arena. See [bounded-filter settings](fm1-base/rnbo-loader/BOUNDED-FILTERS.md). |
| `average~`, `average_rms~` | Positive compiled-constant windows have bounded history; 32-sample and stereo 32/64-sample cases were compared with the references. Dynamic/unknown windows retain their original storage and may not fit. |
| `list.*`, `pack`, `unpack` | Sixteen values is the inline capacity, not a universal maximum. The suite checks selected 17/32/64-value storage/copy cases. Allocating during audio processing remains forbidden. In particular, repeated `list.nth` reads of a 64-item list allocate temporary copies; T03 uses `list.lookup` instead. |
| `data`, `buffer~`, `poke~`, `peek~` | Tested as bounded, internally generated local buffers; examples use 256 frames, one channel and none/linear/cubic reads. This does not add external sample-file loading or host-owned buffers. |
| `expr`, `codebox`, `codebox~` | Tested RNBO expressions plus event/audio codeboxes: arithmetic, functions, conditionals, bounded loops and retained `@state`. This is RNBO’s language, not arbitrary JavaScript, C++ or external code execution. |
| `message`, `set` | Embedded messages and supported object-attribute updates are used by the tested patches, including delay clear/reset and voice mute. This does not imply arbitrary host messages or every attribute. |
| `in`, `in~`, `out~` | Subpatch wiring can use internal ports. The module’s top-level contract remains **zero audio inputs and exactly two audio outputs**; mono sound can feed both outputs. |
| MIDI input | Keyboard/MIDI note, velocity, controller, pitch-bend, pressure and program-change input paths are exercised. Physical outgoing MIDI and external host services are not qualified by these tests. |
| Parameters | `param` / `param~`; tested min/max, exponent, enum, steps and declared units. `@displayorder` sets exported order and `@displayname` supplies the UI label. The module accepts at most 16 parameters; the current two knob banks expose the first eight. |

### Supported patch structures

| Structure | Supported form / boundary |
| --- | --- |
| Standalone source | Self-contained `.rnbopat` files saved from inside RNBO. Editable `.maxpat` wrappers are provided for the examples; the surrounding Max UI is not executed on the FM1. |
| RNBO subpatches | Embedded `p` graphs, nested and branched subpatches, fan-out/fan-in, event-to-signal control and internal named `send`/`receive` or `send~`/`receive~`. External abstractions/files need additional integration. |
| Polyphony | Mono, two-voice and four-voice builds; incoming raw MIDI, allocation/stealing, sustain/release, voice sleep and parameter broadcast. Polyphony must match `module.json`; arbitrary voice counts are not supported. |
| Shared master effects | One embedded polyphonic synth group with an outer shared effect, as in four-voice T14/T15. This avoids duplicating the master delay for each voice. The builder validates this particular topology; it is not unrestricted nested polyphony. |
| Scheduling | Initialization, metro, delay/pipe, ramps/timers and clocks addressed to nested patchers are exercised. Scheduler timestamps retain their required precision; that does not permit software-double arithmetic in sample loops. |
| Feedback and state | RNBO feedback cycles broken by `feedback~`/delays; Gen one-sample `History` feedback, initial states and simultaneous state updates. RNBO `feedback~` contributes one 256-sample vector of feedback latency. |
| Embedded Gen | Visual `gen~` (`dsp.gen`) graphs, nested `gen`, codeboxes inside Gen and embedded GenExpr. The importer preserves editable graphs and compiles a translated copy; supported forms are listed below. |
| Device / resource contract | Fixed 44.1 kHz, 256-frame blocks, stereo output, bounded initialization-time allocation and no late audio-thread allocation. Native image plus layout metadata must fit 64 KiB; module state must fit 176 KiB. Host arena usage is not total device RAM or a CPU measurement. |

### Gen operations — all 144 exercised catalogue entries

These are the canonical entries recorded by the 165 passing Gen fixtures. Common spellings tested separately include numeric boxes, `f` / `i`, arithmetic/comparison symbols, `accum` for `plusequals`, and reversed `!-`, `!/`, `!%` forms. The installed catalogue resolves aliases; this list does not claim every alias or constructor has been exercised. `codebox` is a supported visual structure and is not one of the 144 catalogue entries below.

| Area | Exercised Gen entries |
| --- | --- |
| Constants | `INVPI`, `LN2`, `SAMPLERATE`, `TWOPI`, `VECTORSIZE`, `degtorad`, `e`, `halfpi`, `ln10`, `log10e`, `log2e`, `phi`, `pi`, `radtodeg`, `sqrt1_2`, `sqrt2` |
| Numeric boxes and casts | `constant`, `float`, `int` |
| Oscillators and phase | `cycle`, `phasor`, `triangle`, `train`, `rate`, `noise`, `phasewrap` |
| History, counters and state | `history`, `counter`, `plusequals`, `mulequals`, `delta`, `change`, `elapsed`, `latch`, `sah`, `slide`, `dcblock` |
| Arithmetic and shaping | `add`, `sub`, `mul`, `div`, `rsub`, `rdiv`, `mod`, `rmod`, `abs`, `absdiff`, `neg`, `sign`, `min`, `max`, `clamp`, `wrap`, `fold`, `scale`, `mix`, `smoothstep`, `step` |
| Rounding | `floor`, `ceil`, `round`, `trunc`, `fract` |
| Comparison | `eq`, `neq`, `lt`, `lte`, `gt`, `gte`, `eqp`, `neqp`, `ltp`, `ltep`, `gtp`, `gtep` |
| Logic | `bool`, `not`, `and`, `or`, `xor` |
| Trigonometry and hyperbolic maths | `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `atan2`, `sinh`, `cosh`, `tanh`, `asinh`, `acosh`, `atanh` |
| Powers and logarithms | `exp`, `exp2`, `pow`, `sqrt`, `log`, `log2`, `log10` |
| Fast approximations | `fastsin`, `fastcos`, `fasttan`, `fastexp`, `fastpow` |
| Coordinates and units | `hypot`, `cartopol`, `poltocar`, `radians`, `degrees`, `mtof`, `ftom`, `dbtoa`, `atodb`, `mstosamps`, `sampstoms`, `t60`, `t60time` |
| Numeric hygiene | `fixnan`, `fixdenorm`, `isnan`, `isdenorm` |
| Ports, parameters and routing | `in`, `out`, `gen`, `param`, `gate`, `selector`, `switch`, `send`, `receive`, `pass` |
| Local data and interpolation | `data`, `peek`, `poke`, `sample`, `nearest`, `lookup`, `wave`, `splat`, `dim`, `channels`, `interp` |
| Delay | `delay` |

### Gen structures and remaining restrictions

- **Parameters/state:** numeric constants, Gen `param` with initial value/min/max, `History` and independent per-instance state; exposed/named parameters are exercised in the supported forms. This does not establish arbitrary nested `setparam` routing.
- **Local memory:** bounded `Data`, multichannel reads/writes and interpolation. Visual Data/Delay declarations share a default **24 KiB conservative estimate per Gen graph**, including its nested Gen; the compiled module still enforces the total arena. A visual `data` defaults to 512 frames and one channel. Codebox/GenExpr allocations rely on compiled-module checks rather than that visual estimate.
- **Delay:** a visual `delay` with no explicit size defaults to **2,048 samples** (about 46.4 ms). Explicit sizes must fit the configured graph budget. Up to eight taps and the supported `@feedback 1` form are accepted; none/linear/cosine/cubic/spline interpolation have comparison fixtures. `gen_buffer_max_bytes` and `gen_delay_max_samples` configure the visual bounds; they do not enlarge the device’s total memory.
- **Routing/code:** nested Gen graphs, named internal send/receive, selectors/gates/switches and Gen codeboxes with declared ports are supported. Unconnected inlets use the catalogue’s defaults; ambiguous constructors and unreviewed saved attributes are rejected.
- **Not integrated:** external Gen files/abstractions, external `buffer`, Gen `expr` boxes, nested `setparam`, Gen `voice` indexing, FFT host context/`fftinfo`/FFT constants, and named-wavetable `cycle` constructors. The supported Gen `cycle` uses its built-in sine table; local Data can instead be read with the listed buffer operators. Catalogue `read`/`write` entries are not standalone operators; Delay read/write methods are handled by the importer.
- **Qualification:** Gen fixtures compare the importer with RNBO’s GenExpr backend. They are not a direct equivalence test against Max’s native Gen audio engine, and do not certify all parameter combinations or FM1 timing.

## Included instruments

| Source in `fm1-base/rnbo-loader/patches/` | Instrument |
| --- | --- |
| `saw_cutoff_delay.rnbopat` | Saw, resonant filter, ADSR and feedback echo; eight controls |
| `fm4echo.rnbopat` | Four-voice FM with voice stealing and shared stereo echo |
| `fm8poly2fast.rnbopat` | Optimized two-voice FM |
| `fm8poly2.rnbopat` | Earlier two-voice reference |
| `fm8.rnbopat` | Eight-control mono FM |
| `fm.rnbopat` | Four-control FM |
| `mono.rnbopat` | Basic sine instrument |

Max wrappers under `modules/NAME/NAME.maxpat` allow opening the examples in
Max. Build from the `.rnbopat` source after making edits. `fm1-base/rnbo/`
contains the shared adapter/exporter and the original standalone prototype;
`fm1-base/rnbo-loader/` is the current permanent player.

## Playable test collection

The [15-patch test guide](fm1-base/rnbo-loader/hardware-tests/README.md)
includes standalone RNBO sources, editable Max wrappers, eight mapped controls,
listening checks and a hardware results sheet. Load one group into the three
slots at a time; the FM1 runs one selected patch.

| Group | Slot 1 | Slot 2 | Slot 3 |
| --- | --- | --- | --- |
| 1 — RNBO fundamentals | Keyboard synth | Clock/glide sequencer | 64-step list |
| 2 — Gen synthesis | Constants oscillator | History feedback filter | Nested Gen/codebox |
| 3 — Gen memory | Sample-and-hold | Stereo data table | Dual-tap delay |
| 4 — Effects | Comb/allpass | Lo-fi/averages | Gen maths/routing |
| 5 — Polyphony | Two-voice FM | Four-voice FM/echo | Four-voice Gen hybrid |

From the repository root, build and then upload a group (replace `1` with `1`–`5`):

```sh
bash fm1-base/rnbo-loader/Build-Test-Group-1.command
bash fm1-base/rnbo-loader/Upload-Test-Group-1.command --check
bash fm1-base/rnbo-loader/Upload-Test-Group-1.command
```

Builds do not install firmware or upload patches. Uploads verify source hashes,
settings and native package reviews before replacing slots 1–3. The guide records
hardware observations separately from the archived host results, including
T08’s subtle Mix control and T14’s intentionally attenuated high-feedback echo.
The deferred echo gain revision is not included.

## Validation

Check all 15 source/configuration pairs, editable Max graph topology, archived
host hashes and five upload-bank mappings without RNBO or hardware:

```sh
python3 fm1-base/rnbo-loader/hardware-tests/check_sources.py
```

Run the complete compiler-dependent suite on the supported Mac environment:

```sh
source setup/env.sh
python3 fm1-base/rnbo-loader/tools/verify.py
```

The local suite checks audio, polyphony, voice sleep, echo feedback, knob banks,
meters, parameter popups, battery ADC ownership, storage/recovery, module
validation, browser flow and 32-bit portability. It requires the local RNBO
package and Mac fonts, but does not upload firmware. Browser transfer is mocked
in these tests; successful local tests do not prove hardware timing.

The visual player and saw patch were built for the native target, installed and
activated in slot 1 on 29 October 2026. The FM1 reported 2% CPU and zero xruns at
that status reading; this is not a worst-case CPU figure. The owner confirmed
the result. See [docs/validation.md](docs/validation.md) for provenance and
remaining hardware checks. Browser Web MIDI transfer remains separately
unverified on the device.

## Licensing

Original integration code and patch designs remain **MIT**, except files with
their own notices. The battery adapter retains **GPL-3.0-or-later**, so the
combined player containing it is distributed under GPL-3.0-or-later. Vendored
platform files retain MPL-2.0 and their other notices. RNBO-generated code and
runtime retain their own terms when produced locally.

See [LICENSING.md](LICENSING.md) and [LICENSE](LICENSE). SDK/compiler downloads,
the installed RNBO package, generated exports, private device logs, system
fonts and prebuilt firmware are not bundled in this source repository.
