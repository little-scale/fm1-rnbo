# FM1 RNBO playable hardware test collection

Fifteen standalone patches, arranged into **five groups of three**. Load one group into the FM1’s three patch slots at a time. These groups are a test schedule; the instrument still has only three slots and runs one patch at a time.

**Current status (30 October 2026):** the archived RNBO 1.4.4 host report records all 15 exports, portability audits, host builds and auditions passing, with all five groups passing the player simulator checks. Native build output supplied by the maintainer confirms Groups 4 and 5 pass after adding the integer `abs()` runtime helper needed by T11. Groups 1–4 and T15 have positive user-reported FM1 playback results; T13 has no separate hardware confirmation in the recorded walkthrough. T14 plays, with a quiet-echo observation explained by its `1 - Feedback` input gain. The proposed echo gain revision was deferred and is not included. T08 Mix remains subtle and its hardware audibility is unconfirmed. See `HARDWARE-RESULTS.csv` for per-patch observations; unreported checklist items, CPU readings and package hashes remain blank. These records distinguish archived host evidence from user-reported device results; they do not claim a fresh complete compiler or hardware run.

## Start here

1. Open a file from `max/` in Max to inspect or play it. Audio starts off. The wrapper connects MIDI input and stereo output. Native Max GUI/audio audition has not been performed by this test run.
2. Use the matching `.rnbopat` in `patches/` as the reproducible RNBO source. Export edited source from inside the RNBO editor; saving only the outer Max wrapper will not update that source.
3. Start hardware qualification with **Group 1**. Run `../Build-Test-Group-1.command` from normal macOS Terminal with Docker Desktop running. It builds the player and three native modules, reruns auditions and collects verified upload files in a new `build/hardware-tests/group-1-ready-*` folder. Follow its `START-HERE.md` for installation and slot uploads. It does not install or upload automatically.
4. Use **PRESETS** to switch patches and **FX** to switch between K1–K4 and K5–K8. Every patch has eight controls, with Level on K1, Attack on K7 and Release on K8.
5. Record actual device observations in `HARDWARE-RESULTS.csv`. Its hardware fields intentionally start blank. Host execution speed and simulator CPU displays are not FM1 CPU measurements.

## Groups

| Group | Slot 1 | Slot 2 | Slot 3 |
| --- | --- | --- | --- |
| 1 — RNBO fundamentals | t01_keys — Keys And Eight Knobs | t02_clock — Clock Steps And Glide | t03_lists — Sixty Four Step List |
| 2 — Gen synthesis and feedback | t04_constants — Gen Constants Oscillator | t05_history — Gen History Lowpass | t06_nested — Nested Gen And Codebox |
| 3 — Gen buffers and delays | t07_hold — Gen Sample And Hold | t08_table — Gen Local Stereo Table | t09_gendelay — Gen Dual Tap Delay |
| 4 — Effects and signal processing | t10_comb — RNBO Comb And Allpass | t11_lofi — RNBO LoFi And Averages | t12_genmath — Gen Maths And Routing |
| 5 — Polyphony and integration | t13_fm2 — Two Voice FM Reference | t14_fm4echo — Four Voice Master Echo | t15_hybrid — Four Voice Gen Hybrid |

## Build and audition commands

For any group N = 1–5, run `Build-Test-Group-N.command`, then `Upload-Test-Group-N.command` from the rnbo-loader folder. Replace N with the group number. The build reruns export, audits, native compilation and host auditions and collects reviewed packages. The upload validates all three source hashes, module settings and native reviews before replacing slots 1–3. Use `Upload-Test-Group-N.command --check` for validation without transfer. An already installed compatible three-slot visual player needs no reinstall for a patch-only group change. Install a rebuilt player separately when applying player/UI changes. The equivalent preparation command from the repository root is `python3 fm1-base/rnbo-loader/hardware-tests/prepare.py --bank N` after sourcing `setup/env.sh`. Preparation rebuilds the player and does not install or upload.

From the repository root:

```sh
source setup/env.sh
# Source/config/Max and archived-evidence checks (no RNBO required):
python3 fm1-base/rnbo-loader/hardware-tests/check_sources.py
# Host builds, portability checks, knob/note stress and WAV previews:
python3 fm1-base/rnbo-loader/hardware-tests/run.py --jobs 3
# Native build for the first group, when Docker is accessible:
python3 fm1-base/rnbo-loader/hardware-tests/run.py --native --bank 1 --jobs 1
# One patch only:
python3 fm1-base/rnbo-loader/hardware-tests/run.py --only t09_gendelay
# Host-only screen/slot checks and the matched History comparison:
python3 fm1-base/rnbo-loader/hardware-tests/panel.py
python3 fm1-base/rnbo-loader/hardware-tests/compare.py
```

For a native build, the resulting upload candidate is `fm1-base/rnbo-loader/build/hardware-tests/<id>/build/<id>.rnbom`. Require a passing native build and its `review.json` before uploading. The per-patch `module.json` is copied into the isolated build directory by the runner, including polyphony, shared-effect topology and memory caps. Use the runner for these test builds so those settings are retained.

Host WAV previews are at `build/hardware-tests/<id>/audition.wav`; the preview page is `build/hardware-tests/auditions.html`. The WAVs play four notes and, for polyphonic patches, a six-note stealing sequence. They are synthetic host output, not recordings from the FM1.

## Hardware procedure for every group

- Load its three native `.rnbom` files into slots 1, 2 and 3 and confirm the patch IDs on screen.
- Play soft and hard notes, low and high keys, and fast repeated notes. Check stereo output and metering.
- Test K1–K4, press FX, then test K5–K8. Confirm both the temporary name/value overlay and the audible result. Some controls need another control enabled; see each card.
- Turn PRESETS while a note is held. A patch change may mute and clear effect tails; release and press the key again. No stuck note or crash should remain.
- Change several controls, press SAVE, switch away and return. Power-cycle and check the saved values and startup slot. Repeat this for each slot.
- Press PLAY for panic while notes or an effect tail are sounding. Confirm silence, then play a new note.
- Record idle and held-note CPU, glitches and any resets. For the polyphonic group, include two-note and four-note measurements.
- Watch the battery indicator and connect/disconnect USB during an ordinary playing check.
- Keep default settings for the first pass, then sweep controls. High-feedback echoes can ring for many seconds; compare with feedback zero and use panic to distinguish an intended tail from a stuck note.

## Test cards

### Group 1, slot 1: t01_keys — Keys And Eight Knobs

Start with single notes. Shape blends sine/saw; detune affects the saw. Pan must reach each speaker separately.

**Coverage:** notein, velocity, mtof expression, ADSR, filters; All eight knobs and FX banking; pan and patch graphics.

**Measured host allocation arena:** 65,632 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t01_keys.maxpat) · [RNBO source](patches/t01_keys/t01_keys.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Shape | 0–1  | 0.2 |
| K3 | Detune | -12–12 semitones | 0 |
| K4 | Cutoff | 100–9000 Hz | 2500 |
| K5 | Resonance | 0–0.8  | 0.15 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

### Group 1, slot 2: t02_clock — Clock Steps And Glide

Hold one key for an eight-step staircase. Release stops the clock; another key resumes the step position. Glide should smooth the jumps.

**Coverage:** RNBO metro, event counter, hot arithmetic and scheduled line~; Clock stop/start and changing period without stuck notes.

**Measured host allocation arena:** 65,632 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t02_clock.maxpat) · [RNBO source](patches/t02_clock/t02_clock.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Period | 60–700 ms | 180 |
| K3 | Interval | 0–12 semitones | 2 |
| K4 | Glide | 0–120 ms | 25 |
| K5 | Rotate | 0–7 steps | 0 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

### Group 1, slot 3: t03_lists — Sixty Four Step List

Hold a note and scan Step through the stored melody. First changes the last step after reversal. Transpose shifts the whole melody.

**Coverage:** 64-item pack, list.reg copy, list.rev and read-only list.lookup; Repeated list updates after initialization without allocation growth.

**Measured host allocation arena:** 1,200 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t03_lists.maxpat) · [RNBO source](patches/t03_lists/t03_lists.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Step | 0–63 index | 0 |
| K3 | First | -12–12 semitones | 0 |
| K4 | Transpose | -12–12 semitones | 0 |
| K5 | Brightness | 100–8000 Hz | 2000 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

Set Step to 63 before testing First. The source list is reversed, so the first stored item appears at the last selector position. Step 0 and Step 63 differ by two semitones at defaults; the host test checks that relationship.

### Group 2, slot 1: t04_constants — Gen Constants Oscillator

A sine oscillator with a second harmonic blend. Ratio 1 follows the keyboard. A sharp discontinuity while moving Phase is expected.

**Coverage:** Visual Gen numeric/named constants, phasor, samplerate, twopi, pi, sin; RNBO controls sent to named Gen Param attributes, frequency ratios and phase wrapping.

**Measured host allocation arena:** 0 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t04_constants.maxpat) · [RNBO source](patches/t04_constants/t04_constants.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Ratio | 0.25–4  | 1 |
| K3 | Phase | 0–1 cycles | 0 |
| K4 | Harmonic | 1–8  | 1 |
| K5 | Blend | 0–1  | 0 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

Set Blend above zero to hear Harmonic. Phase 0 and Phase 1 are the same phase; move through intermediate values. Ratio is a named Gen Param updated by RNBO messages, and its two endpoints were checked to change frequency by 16×.

### Group 2, slot 2: t05_history — Gen History Lowpass

Feedback darkens the sound smoothly. At 0.98 it should remain stable. Mix 0 is the dry reference; Mix 1 is fully filtered.

**Coverage:** One-sample History feedback, old-state reads, stability at 0.98; DC blocking, nonlinear drive and live smoothing coefficient.

**Measured host allocation arena:** 0 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t05_history.maxpat) · [RNBO source](patches/t05_history/t05_history.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Feedback | 0–0.98  | 0.8 |
| K3 | Drive | 1–8  | 1 |
| K4 | Mix | 0–1  | 1 |
| K5 | Cutoff | 300–9000 Hz | 6500 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

For the A/B comparison, set both patches to the same values, including Feedback (their initial feedback differs). The host comparison matched 327,680 sample words exactly while changing feedback and notes.

### Group 2, slot 3: t06_nested — Nested Gen And Codebox

This uses the same filter equation through nested Gen and codebox. Match controls with History Lowpass for an A/B check.

**Coverage:** Nested visual Gen boundaries, scoped History, codebox state; Cross-check behavior against History Lowpass with matched settings.

**Measured host allocation arena:** 0 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t06_nested.maxpat) · [RNBO source](patches/t06_nested/t06_nested.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Feedback | 0–0.98  | 0.7 |
| K3 | Drive | 1–8  | 1 |
| K4 | Mix | 0–1  | 1 |
| K5 | Cutoff | 300–9000 Hz | 6500 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

For the A/B comparison, set both patches to the same values, including Feedback (their initial feedback differs). The host comparison matched 327,680 sample words exactly while changing feedback and notes.

### Group 3, slot 1: t07_hold — Gen Sample And Hold

Hold a note for random stepped pitch. Rate sets the steps per second; Smooth softens transitions. Depth 0 returns to a steady pitch.

**Coverage:** Gen noise, sah, phasor, comparisons, int, slide and cycle; Sample-rate state with predictable step-rate control.

**Measured host allocation arena:** 65,632 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t07_hold.maxpat) · [RNBO source](patches/t07_hold/t07_hold.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Rate | 0.5–25 Hz | 5 |
| K3 | Depth | 0–1  | 0.6 |
| K4 | Steps | 1–12  | 4 |
| K5 | Smooth | 1–500 samples | 20 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

### Group 3, slot 2: t08_table — Gen Local Stereo Table

A locally generated wavetable. Shape blends sine and saw; Offset changes the right-channel phase. Mix compares nearest and linear reads.

**Coverage:** Local Data 256x2, counter, poke, sample, nearest, dim, channels; Table rewrites, phase indexing and stereo channel addressing.

**Measured host allocation arena:** 2,144 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t08_table.maxpat) · [RNBO source](patches/t08_table/t08_table.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Ratio | 0.25–4  | 1 |
| K3 | Shape | 0–1  | 0.5 |
| K4 | Offset | 0–1 cycles | 0.25 |
| K5 | Mix | 0–1  | 1 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

The 256-frame stereo table is generated inside the patch; no sample file is required. It fills in roughly 5.8 ms. The right channel reads the inverted table at the Offset phase, so mono summing at Offset 0 can cancel. Mix affects the left channel only. With 256 frames, nearest and linear reads are close: the default-setting host endpoint difference measured about 32 dB below the left signal. Pan left to isolate it, but a dramatic audible change is not expected.

### Group 3, slot 3: t09_gendelay — Gen Dual Tap Delay

Short stereo echoes become comb/flange tones on held notes. Play short notes to hear the tail. Mix 1 must remove the immediate dry sound.

**Coverage:** Bounded 2048-sample Gen delay, two fractional taps and feedback; Dry/wet endpoints and stable high feedback.

**Measured host allocation arena:** 16,480 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t09_gendelay.maxpat) · [RNBO source](patches/t09_gendelay/t09_gendelay.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Time | 1–40 ms | 16 |
| K3 | Feedback | 0–0.98  | 0.45 |
| K4 | Mix | 0–1  | 0.5 |
| K5 | Spread | 0.5–1.8  | 1.3 |
| K6 | Brightness | 300–9000 Hz | 5000 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

The two taps share one 2,048-sample delay. The right tap clamps at 2,048 samples when Time × Spread exceeds that limit. Compare Mix 0 and Mix 1 with short notes to verify dry/wet endpoints.

### Group 4, slot 1: t10_comb — RNBO Comb And Allpass

Time changes a metallic resonance. Diffuse blends the comb with its allpass stage. Feedback 0 gives a useful short-delay reference.

**Coverage:** Bounded comb~/allpass~ rings and signal-rate audio through both; Declared duration cap and phase coloration at small memory cost.

**Measured host allocation arena:** 16,768 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t10_comb.maxpat) · [RNBO source](patches/t10_comb/t10_comb.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Time | 1–16 ms | 8 |
| K3 | Feedback | 0–0.9  | 0.45 |
| K4 | Mix | 0–1  | 0.5 |
| K5 | Diffuse | 0–1  | 0.5 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

### Group 4, slot 2: t11_lofi — RNBO LoFi And Averages

Crush blends sample holding; Smooth blends a 32-sample moving average. Drive adds saturation. Listen for clean parameter changes and no lasting DC.

**Coverage:** Fixed downsamp~ 4, average~ 32 and average_rms~ 32; Bounded averaging history and float32 audio path.

**Measured host allocation arena:** 480 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t11_lofi.maxpat) · [RNBO source](patches/t11_lofi/t11_lofi.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Crush | 0–1  | 0.5 |
| K3 | Smooth | 0–1  | 0.5 |
| K4 | Drive | 1–6  | 1 |
| K5 | Cutoff | 100–9000 Hz | 5000 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

### Group 4, slot 3: t12_genmath — Gen Maths And Routing

Mode selects fold, wrap or tanh shaping. Mix 0 is the dry reference. Symmetry shifts the shape; the DC blocker should prevent a persistent offset.

**Coverage:** Gen wrap, fold, tanh, selector, named send/receive, dcblock; Reverse operators, variable selector and bounded nonlinear paths.

**Measured host allocation arena:** 0 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t12_genmath.maxpat) · [RNBO source](patches/t12_genmath/t12_genmath.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.12 |
| K2 | Drive | 1–8  | 2 |
| K3 | Mode | 1–3  | 1 |
| K4 | Symmetry | -0.5–0.5  | 0 |
| K5 | Mix | 0–1  | 0.5 |
| K6 | Pan | 0–1  | 0.5 |
| K7 | Attack | 1–250 ms | 8 |
| K8 | Release | 10–1500 ms | 180 |

### Group 5, slot 1: t13_fm2 — Two Voice FM Reference

Play a chord, then add another note to force stealing. Old note-offs must not kill a newer voice. Release all keys and observe idle CPU.

**Coverage:** RNBO voice allocation, stealing, voice sleep, MIDI release and parameter broadcast.

**Measured host allocation arena:** 65,872 / 98,304 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t13_fm2.maxpat) · [RNBO source](patches/t13_fm2/t13_fm2.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.25  | 0.1 |
| K2 | Ratio | 0.25–8  | 2 |
| K3 | Depth | 0–8  | 1.5 |
| K4 | Pan | 0–1  | 0.5 |
| K5 | Decay | 1–1000  | 20 |
| K6 | Sustain | 0–1  | 0.8 |
| K7 | Attack | 1–1000  | 10 |
| K8 | Release | 1–2000  | 150 |

Hold two notes, add a third, then release the oldest key while the newer notes remain held. The stolen voice should not return and its old note-off should not silence the replacement.

### Group 5, slot 2: t14_fm4echo — Four Voice Master Echo

Play a chord, then add another note to force stealing. Old note-offs must not kill a newer voice. Release all keys and observe idle CPU. Echo tails must continue after releasing the chord.

**Coverage:** RNBO voice allocation, stealing, voice sleep, MIDI release and parameter broadcast; One shared master echo, feedback 0.98, fully wet mix, panic and effect reset.

**Measured host allocation arena:** 100,176 / 114,688 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t14_fm4echo.maxpat) · [RNBO source](patches/t14_fm4echo/t14_fm4echo.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.125  | 0.075 |
| K2 | Ratio | 0.25–8  | 2 |
| K3 | Depth | 0–8  | 1.5 |
| K4 | Echo Time | 40–170  | 120 |
| K5 | Echo Feedback | 0–0.98  | 0.45 |
| K6 | Echo Mix | 0–1  | 0.28 |
| K7 | Attack | 1–1000  | 10 |
| K8 | Release | 1–2000  | 150 |

Repeat the stealing check with four held notes and a fifth/sixth note. Echo is one shared master effect. At Mix 1 a new short note should arrive through the delay without an immediate dry component.

The shared echo intentionally scales fresh input by `1 - Feedback`, then applies the dry/wet crossfade. At actual Feedback 0.90, a new short note enters the echo at -20 dB; at 0.98, about -34 dB. Mix 1 removes dry sound but does not recover that input attenuation. This explains T14’s quiet-echo observation. The unity-send/limited-loop revision was deferred; this repository retains the tested original gain design in T14 and T15.

### Group 5, slot 3: t15_hybrid — Four Voice Gen Hybrid

Play a chord, then add another note to force stealing. Old note-offs must not kill a newer voice. Release all keys and observe idle CPU. Echo tails must continue after releasing the chord. Compare against Four Voice Master Echo for tuning, allocation and CPU; oscillator starting phase can differ.

**Coverage:** RNBO voice allocation, stealing, voice sleep, MIDI release and parameter broadcast; One shared master echo, feedback 0.98, fully wet mix, panic and effect reset; Embedded visual Gen inside four RNBO voices; constants and separate oscillator state.

**Measured host allocation arena:** 99,856 / 114,688 bytes. This excludes the patch object, stack and other state; zero arena allocation does not mean zero RAM. Native qualification is recorded separately in HARDWARE-RESULTS.csv; the arena figures are host measurements.

[Editable Max patch](max/t15_hybrid.maxpat) · [RNBO source](patches/t15_hybrid/t15_hybrid.rnbopat)

| Knob | Parameter | Range | Default |
| --- | --- | --- | --- |
| K1 | Level | 0–0.125  | 0.075 |
| K2 | Ratio | 0.25–8  | 2 |
| K3 | Depth | 0–8  | 1.5 |
| K4 | Echo Time | 40–170  | 120 |
| K5 | Echo Feedback | 0–0.98  | 0.45 |
| K6 | Echo Mix | 0–1  | 0.28 |
| K7 | Attack | 1–1000  | 10 |
| K8 | Release | 1–2000  | 150 |

Repeat the stealing check with four held notes and a fifth/sixth note. Echo is one shared master effect. At Mix 1 a new short note should arrive through the delay without an immediate dry component.

The shared echo intentionally scales fresh input by `1 - Feedback`, then applies the dry/wet crossfade. At actual Feedback 0.90, a new short note enters the echo at -20 dB; at 0.98, about -34 dB. Mix 1 removes dry sound but does not recover that input attenuation. This explains T14’s quiet-echo observation. The unity-send/limited-loop revision was deferred; this repository retains the tested original gain design in T14 and T15.

## Limits and findings

- Gen buffers stay small: the table is 256 frames × 2 channels; the dual-tap delay is 2,048 samples. The RNBO comb/allpass test has an explicit 16 ms cap. The averaging test uses fixed 32-sample windows.
- The four-voice echo and hybrid use the established 114,688-byte arena configuration; the other patches use their supplied settings. Do not infer native CPU or total RAM from the host arena figures.
- The list patch uses `list.lookup` intentionally. RNBO 1.4.4 `list.nth` creates a temporary large-list copy on each call; with 64 items this violates the player’s no-late-allocation policy. That general `list.nth` limitation is not claimed fixed by this collection.
- No FFT host context, external files, external audio input, Gen `voice`, `setparam` or unsupported wavetable `cycle` constructors are used. This is a practical hardware collection, not a replacement for the exhaustive compatibility fixtures.
- The mono test patches have an output clamp at ±0.8; the polyphonic references retain their established gain structure. Listen for distortion at extreme settings rather than treating bounded output alone as proof of correct sound.
- `design.py` regenerates the authored sources and overwrites edits to those generated files. Make a copy for personal experiments. `document.py` regenerates the guide, Max wrappers, reports and preview page; it preserves an existing hardware results CSV.
