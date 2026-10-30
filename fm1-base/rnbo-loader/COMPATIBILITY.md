# RNBO / FM1 compatibility results

Updated 30 October 2026. Tested with installed RNBO 1.4.4, Node 26.7.0, Apple Clang 17.0.0 and Python 3.14.7 on Apple Silicon.

**Historical full-suite baseline:** the 222-patch host sweep has 212 normal-profile passes, five cases passing with phase optimization disabled, four expected bridge rejections and one visual-Gen integration gate.** All 212 passing artifact hashes match the report. All **56 regression stages pass in the Git checkout**.

Of the original 17 cases requiring work, **11 are fixed in the normal host profile**, **five have a tested conservative-profile route**, and **one still needs visual-Gen-to-GenExpr conversion**. Native FM1 execution is not claimed by these results.

**Gen update:** the visual-Gen gate in that historical sweep is now resolved for the supported subset. The subsequent expansion passes 165 dedicated fixtures covering 144 catalogue entries, plus the existing 58-stage player regression. See [GEN-SUPPORT.md](GEN-SUPPORT.md) for current coverage, limits and remaining forms; the complete 222-patch matrix below has not been rerun for this expansion.

## Original 17 cases

| Case | Current host result | Detail |
| --- | --- | --- |
| trunc~ | Pass with fast_phase: false | Native image/CPU qualification remains required. |
| wrap~ 0. 1. | Pass with fast_phase: false | Native image/CPU qualification remains required. |
| fold~ -0.5 0.5 | Pass with fast_phase: false | Native image/CPU qualification remains required. |
| downsamp~ 4 | Pass with fast_phase: false | Native image/CPU qualification remains required. |
| average~ 32 | Fixed: normal profile | Bounded 32-sample window: 132 history bytes; bit-identical comparison including resets. |
| average_rms~ 32 | Fixed: normal profile | Bounded 32-sample window: 132 history bytes; bit-identical comparison including resets. |
| peakamp~ 10 | Pass with fast_phase: false | Interval-change detection is outside the sample loop; varying-interval output is bit-identical. Strict optimized policy still rejects its int64 conversion. |
| snapshot~ 10 | Fixed: normal profile | Unchanged double-precision block-end timestamp calculated outside the sample loop. |
| scheduled line~ | Fixed: normal profile | Unchanged double-precision block-end timestamp calculated outside the sample loop. |
| allpass~ 16 0.5 | Fixed: normal profile | Bounded float32 rings: 8,192 data bytes at 16 ms. |
| comb~ 16 0.5 0.5 0.5 | Fixed: normal profile | Bounded float32 rings: 8,192 data bytes at 16 ms. |
| data memory 256 1 @external 0 none | Fixed: normal profile | Internal getters are audited recursively; float64 data access alone is not classified as double arithmetic. |
| data memory 256 1 @external 0 linear | Fixed: normal profile | Internal getters are audited recursively; float64 data access alone is not classified as double arithmetic. |
| data memory 256 1 @external 0 cubic | Fixed: normal profile | Internal getters are audited recursively; float64 data access alone is not classified as double arithmetic. |
| list copy capacity 32 | Fixed: normal profile | Corrected inline/overflow copying; list storage passes UBSAN. |
| list copy capacity 64 | Fixed: normal profile | Corrected inline/overflow copying; list storage passes UBSAN. |
| embedded Gen integration | Fixed for supported subset | Visual translation, History feedback, constants, state, local buffers and nested/codebox graphs pass focused checks; see GEN-SUPPORT.md. |

## Bounded buffer results

See [BOUNDED-FILTERS.md](BOUNDED-FILTERS.md) for configuration, automatic parameter bounds, explicit CLI caps, comparisons and limitations.

| Host test | Previous arena | Bounded arena | Bounded buffer data |
| --- | ---: | ---: | ---: |
| Either comb~/allpass~, 16 ms with sine source | 1,114,400 B | 74,016 B | 8,192 B |
| Either filter, parameter 0–32 ms | 1,114,400 B | 82,208 B | 16,384 B |
| Either mean/RMS, 32 samples with sine source | 418,544 B | 65,872 B | 132 B |
| Stereo mean 32 + RMS 64 | 771,456 B | 66,240 B | 392 B |

Before measurements use oversized host-only reference arenas. Current bounded kernels pass the ordinary allocation limits. These are arena usage measurements, not total device RAM or native image size. Dynamic/unknown averaging windows keep the original storage; only positive compiled constants are inferred. Long declared delay limits can still exceed the combined memory budget.

## Validation and numerical limits

Passing patches underwent real RNBO code generation, host/ARM32/32-bit-size_t portability audits, host compilation and initialization, and a runtime probe covering MIDI, parameter endpoints, allocation stability, errors/invalid samples, signed 24-bit output, panic and reconstruction. Signal and exact list-length checks are used where appropriate.

Twelve filter comparisons cover impulses, sine waves, knob changes, explicit caps, signal-rate modulation and feedback 0.98 near resonance. Each compares 1,048,576 sample words. Smaller rings and float32 duration arithmetic produce small fractional-delay rounding changes: maximum observed difference 0.033104% of full scale and relative RMS difference 0.258144%. Explicit-cap references apply the same cap.

Three averaging comparisons, including stereo 32/64-sample windows and reset pulses, are bit-identical over 1,048,576 sample words each. The peakamp interval comparison is also bit-identical while changing intervals from 1 to 100 ms. Nested clock target dispatch now works with both phase settings; a dedicated conservative-profile nested scheduler test passes.

The earlier mixed-type float32 math and unused mtof-table fixes remain in place. The table reduction saved 262,128 aligned arena bytes per proven unread table and matched the original audio in focused tests. Original generated source/runtime headers and adaptation provenance are retained. The installed RNBO package is unchanged.

## Conservative profile

For the five listed cases, set `"fast_phase": false` in the selected module directory's `module.json`. The suite's `--reference-retry` makes and records that configuration separately. No automatic browser fallback is enabled. Other audits and runtime checks remain active; native CPU and image fit need qualification. Uploaded precompiled modules use the existing module ABI.

## Gen integration

See [GEN-SUPPORT.md](GEN-SUPPORT.md) for the current catalogue-based visual importer and 165 passing fixtures. Embedded visual graphs stay editable in Max; code-only GenExpr is preserved on serialization and accepted by browser request validation. External Gen dependencies and unreviewed forms remain rejected.

## Device verification

The local Docker API socket is denied in the agent session. **No new JieLi package, hardware CPU measurement or FM1 upload is claimed.** Host results and ARM/WASM ABI proxies do not establish native code generation or device timing. Run in a normal macOS Terminal with Docker Desktop, from the repository root:

```sh
bash fm1-base/rnbo-loader/Test-Compatibility.command --jobs 3
```

This builds and validates native packages where host stages pass and records conservative retries. It does not install or upload. Read the report: successful suite completion does not mean every case passed. Add `--require-complete` to require every selected production case to pass or reject as expected.

Host reproduction:

```sh
bash fm1-base/rnbo-loader/Test-Compatibility.command --host --jobs 3
python3 fm1-base/rnbo-loader/tools/verify.py
```

The recorded full run is `build/compatibility-final-buffers/{REPORT.md,report.json}`. Focused buffer results are in `build/bounded-filter-comparison/result.json`, `build/bounded-average-comparison/result.json` and `build/peak-interval-comparison/result.json`. Regression results are in `build/verification/summary.json`. Generated exports and binaries are ignored by Git.

Expected rejections are 17 parameters, one output, three outputs and an audio input. The bridge requires zero audio inputs, exactly two outputs and at most 16 parameters. Two knob banks expose the first eight. External files, host services and physical outgoing MIDI are outside this suite. Passing runtime checks does not establish every object algorithm or scheduler edge case.

## Complete case matrix

| Fixture | Production host result | Conservative retry |
| --- | --- | --- |
| cycle~ | pass |  |
| phasor~ | pass |  |
| saw~ | pass |  |
| tri~ | pass |  |
| rect~ | pass |  |
| noise~ | pass |  |
| pink~ | pass |  |
| +~ 0.2 | pass |  |
| -~ 0.2 | pass |  |
| *~ 0.5 | pass |  |
| /~ 2. | pass |  |
| %~ 2. | pass |  |
| abs~ | pass |  |
| acos~ | pass |  |
| asin~ | pass |  |
| atan~ | pass |  |
| atan2~ 1. | pass |  |
| cos~ | pass |  |
| sin~ | pass |  |
| tan~ | pass |  |
| cosh~ | pass |  |
| sinh~ | pass |  |
| tanh~ | pass |  |
| exp~ | pass |  |
| log~ | pass |  |
| log2~ | pass |  |
| log10~ | pass |  |
| pow~ 2. | pass |  |
| sqrt~ | pass |  |
| ceil~ | pass |  |
| floor~ | pass |  |
| round~ | pass |  |
| trunc~ | portability_audit_failure | pass |
| min~ 0.5 | pass |  |
| max~ 0.5 | pass |  |
| clip~ -0.5 0.5 | pass |  |
| wrap~ 0. 1. | portability_audit_failure | pass |
| fold~ -0.5 0.5 | portability_audit_failure | pass |
| scale~ -1. 1. 0. 1. | pass |  |
| >~ 0. | pass |  |
| >=~ 0. | pass |  |
| <~ 0. | pass |  |
| <=~ 0. | pass |  |
| ==~ 0. | pass |  |
| !=~ 0. | pass |  |
| !~ | pass |  |
| &&~ | pass |  |
| \|\|~ | pass |  |
| delta~ | pass |  |
| change~ | pass |  |
| dcblock~ | pass |  |
| slide~ 5 10 | pass |  |
| rampsmooth~ 20 40 | pass |  |
| sah~ 0. | pass |  |
| downsamp~ 4 | portability_audit_failure | pass |
| latch~ | pass |  |
| onepole~ 1000 | pass |  |
| butterworth~ 1000 | pass |  |
| lores~ 1000 0.5 | pass |  |
| svf~ 1000 0.5 | pass |  |
| biquad~ 0.5 0. 0. 0. 0. | pass |  |
| reson~ 1000 10. | pass |  |
| average~ 32 | pass |  |
| average_rms~ 32 | pass |  |
| peakamp~ 10 | portability_audit_failure | pass |
| snapshot~ 10 | pass |  |
| zerox~ | pass |  |
| mtof~ | pass |  |
| ftom~ | pass |  |
| dbtoa~ | pass |  |
| atodb~ | pass |  |
| mstosamps~ | pass |  |
| sampstoms~ | pass |  |
| sah~ | pass |  |
| + 0.2 | pass |  |
| - 0.2 | pass |  |
| * 0.5 | pass |  |
| / 2. | pass |  |
| % 2. | pass |  |
| abs | pass |  |
| acos | pass |  |
| asin | pass |  |
| atan | pass |  |
| atan2 1. | pass |  |
| cos | pass |  |
| sin | pass |  |
| tan | pass |  |
| cosh | pass |  |
| sinh | pass |  |
| tanh | pass |  |
| exp | pass |  |
| log | pass |  |
| log2 | pass |  |
| log10 | pass |  |
| pow 2. | pass |  |
| sqrt | pass |  |
| ceil | pass |  |
| floor | pass |  |
| round | pass |  |
| trunc | pass |  |
| min 0.5 | pass |  |
| max 0.5 | pass |  |
| clip 0.1 0.7 | pass |  |
| wrap 0. 1. | pass |  |
| fold 0. 1. | pass |  |
| scale 0. 1. 0. 0.5 | pass |  |
| > 0.5 | pass |  |
| >= 0.5 | pass |  |
| < 0.5 | pass |  |
| <= 0.5 | pass |  |
| == 0.5 | pass |  |
| != 0.5 | pass |  |
| ! | pass |  |
| && 1 | pass |  |
| \|\| 1 | pass |  |
| and 1 | pass |  |
| or 1 | pass |  |
| xor 1 | pass |  |
| fixnan | pass |  |
| fixdenorm | pass |  |
| mtof | pass |  |
| ftom | pass |  |
| dbtoa | pass |  |
| atodb | pass |  |
| mstosamps | pass |  |
| sampstoms | pass |  |
| mstosamps 44100 | pass |  |
| expr in1 * 0.5 + 0.1 | pass |  |
| expr sin(in1) + cos(in1) * 0.1 | pass |  |
| float 0.2 | pass |  |
| int 2 | pass |  |
| change | pass |  |
| accum 0. | pass |  |
| counter 0 15 | pass |  |
| gate 1 1 | pass |  |
| switch 1 1 | pass |  |
| select 1 | pass |  |
| split 0.2 0.7 | pass |  |
| clip 0.2 0.7 | pass |  |
| trigger f f | pass |  |
| t f f | pass |  |
| route 1 2 | pass |  |
| prepend 1 | pass |  |
| append 1 | pass |  |
| pack 0. 1. | pass |  |
| unpack 0. 1. | pass |  |
| list.len | pass |  |
| list.sum | pass |  |
| list.median | pass |  |
| list.thin | pass |  |
| list.unique | pass |  |
| list.rev | pass |  |
| list.sort | pass |  |
| list.slice 2 | pass |  |
| list.reg 1 2 3 | pass |  |
| list.join | pass |  |
| list.nth 1 | pass |  |
| scheduled metro | pass |  |
| scheduled delay | pass |  |
| scheduled pipe | pass |  |
| scheduled line | pass |  |
| scheduled line~ | pass |  |
| scheduled timer | pass |  |
| delay 64 | pass |  |
| delay 256 | pass |  |
| delay 1024 | pass |  |
| delay 4096 | pass |  |
| delay~ 2048 128 @interp none | pass |  |
| allpass~ 16 0.5 | pass |  |
| comb~ 16 0.5 0.5 0.5 | pass |  |
| parameters 0 | pass |  |
| parameters 1 | pass |  |
| parameters 8 | pass |  |
| parameters 16 | pass |  |
| parameters 17 | expected_reject |  |
| param cutoff 1000 @min 40 @max 12000 @exponent 2 @unit Hz | pass |  |
| param mode 1 @enum off on auto | pass |  |
| param steps 0.5 @min 0 @max 1 @steps 5 | pass |  |
| param~ level 0.25 @min 0 @max 1 | pass |  |
| nested 1 branch False | pass |  |
| nested 2 branch False | pass |  |
| nested 3 branch False | pass |  |
| nested 1 branch True | pass |  |
| nested 3 branch True | pass |  |
| polyphony 1 | pass |  |
| polyphony 2 | pass |  |
| polyphony 4 | pass |  |
| codebox arithmetic | pass |  |
| codebox functions | pass |  |
| codebox branch | pass |  |
| codebox bounded loop | pass |  |
| codebox history | pass |  |
| internal event routing | pass |  |
| internal signal routing | pass |  |
| fanout fanin | pass |  |
| feedback loop | pass |  |
| notein | pass |  |
| ctlin | pass |  |
| bendin | pass |  |
| touchin | pass |  |
| polyin | pass |  |
| pgmin | pass |  |
| data memory 256 1 @external 0 none | pass |  |
| data memory 256 1 @external 0 linear | pass |  |
| data memory 256 1 @external 0 cubic | pass |  |
| buffer~ memory 256 1 none | pass |  |
| buffer~ memory 256 1 linear | pass |  |
| buffer~ memory 256 1 cubic | pass |  |
| list capacity 16 | pass |  |
| list copy capacity 16 | pass |  |
| list capacity 17 | pass |  |
| list copy capacity 17 | pass |  |
| list capacity 32 | pass |  |
| list copy capacity 32 | pass |  |
| list capacity 64 | pass |  |
| list copy capacity 64 | pass |  |
| event codebox | pass |  |
| nested scheduler target | pass |  |
| embedded Gen integration | adapter_integration_gap |  |
| output channels 1 | expected_reject |  |
| output channels 3 | expected_reject |  |
| audio input boundary | expected_reject |  |

Recorded source fingerprint: `a19ae623c4f6e8e90bb878715d590e325ecc766df66cb7121768aa0f0e7bd154`.
