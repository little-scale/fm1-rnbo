# Bounded RNBO buffers on FM1

The exporter now sizes comb~/allpass~ buffers from proven delay bounds and fixed
averaging histories from their positive constant window size. The installed
RNBO package is unchanged. These adaptations use the existing `float32_delays`
module setting, which the browser builder already enables.

## Measured memory

These are host arena measurements, including the test patch's sine lookup table
and allocation metadata. They are not total firmware RAM or native code size.
The previous exports were measured with a separate large host-only arena.

| Test patch | Previous arena | Bounded arena | Bounded buffer data |
| --- | ---: | ---: | ---: |
| Either comb~ or allpass~, fixed 16 ms | 1,114,400 B | 74,016 B | 8,192 B |
| Either filter, parameter 0–32 ms | 1,114,400 B | 82,208 B | 16,384 B |
| Either mean or RMS, window 32 samples | 418,544 B | 65,872 B | 132 B |
| Stereo mean 32 + RMS 64 | 771,456 B | 66,240 B | 392 B |

A 16 ms filter needs roughly 706 samples. Each of its two rings is rounded to
1,024 float32 samples. The same sine-based test patch fits the existing 96 KiB
arena. The sine table itself accounts for 65,536 data bytes, so the complete
patch's arena use is larger than the filter storage alone.

## Automatic delay bounds

A fixed nonnegative comb~/allpass~ delay is inferred from the generated constant.
A directly connected, unwired-at-input numeric host parameter can also provide
a bound. For example, connect this parameter to the filter's delay-time inlet:

```text
param Time 16 @min 0 @max 32
```

Time is in milliseconds. The parameter remains adjustable over its declared
range. For multiple dynamic filters, the exporter conservatively uses the
largest proven range; fixed filters retain their own smaller bound. Inferred
allocations include a small sample margin before power-of-two rounding.

If any relevant dynamic input cannot be proven, automatic parameter-range
inference is declined. Enum controls are excluded because RNBO can replace their
numeric bounds with label indices. Arithmetic, routes, subpatch inputs and
arbitrary audio-rate modulation require an explicit maximum. Fixed filters can
still be inferred independently.

## Explicit maximum for other modulation

For CLI module builds, set the selected module directory's `module.json`:

```json
{
  "voices": 1,
  "fast_phase": true,
  "float32_delays": true,
  "filter_delay_max_ms": 16
}
```

This caps all comb~/allpass~ delay inputs in that module at 16 ms, including
signal-rate modulation. Inputs above the cap are clipped before conversion to
samples. Values inside the cap still modulate normally. Shorter proven constants
retain their smaller allocation. The cap is positive, finite and at most
1,000 ms; combined memory limits still determine whether a patch fits.

The explicit setting is currently a CLI module option. In the browser, use
fixed delays or direct bounded numeric parameters for automatic inference.
Cap settings apply to comb~/allpass~; ordinary delay~ keeps its own source-defined
maximum. Parameter display ranges follow the source patch, so choose matching
source ranges when a knob should stop at the effective maximum.

## Averaging histories

For a compiled positive constant window such as `average~ 32` or
`average_rms~ 32`, the exporter retains exactly that averaging window and
allocates window + 1 float32 samples. Window sizes are samples, not milliseconds.
Unknown/dynamic windows and the special zero/default-window case retain the
original allocation. The DSP setup path is bounded too, preventing it from
expanding the history back to one second during initialization.

## Audio and runtime validation

Twelve filter comparisons cover sine waves, impulse trains, parameter changes,
explicit caps, audio-rate delay modulation and feedback/gain 0.98 near a delay
resonance. Each compares 1,048,576 stereo sample words with the previous FM1
export. Explicit-cap references apply the same input cap. Original large-buffer
references are host diagnostics and cannot produce FM1 packages.

Smaller rings change fractional-delay index rounding, and duration conversion
uses float32 DSP arithmetic. Filter output is therefore not bit-identical.
The largest observed full-scale sample difference was 0.033104%; the largest relative RMS difference was 0.258144%.

The two averaging tests and the combined stereo averaging test are bit-identical
to the previous implementation over 1,048,576 sample words each, including reset
pulses. No runtime errors, invalid samples or late allocations were observed.

The transforms check the reviewed RNBO 1.4.4 generated layouts and preserve
original generated headers. Adaptations are recorded in `provenance.json` under
`bounded_filter_buffers` and `bounded_average_buffers`. Unexpected constructor
or reference layouts stop the build for review.

```sh
python3 fm1-base/rnbo-loader/tests/compatibility/bounded_filters.py
python3 fm1-base/rnbo-loader/tests/compatibility/bounded_averages.py
python3 fm1-base/rnbo-loader/tools/verify.py
```

## Other compatibility progress

peakamp~ interval-change detection now runs once before its sample loop. Its
conservative `fast_phase: false` profile passes the audits and matches the
original over 1,048,576 sample words while changing intervals between 1 and
100 ms. The strict optimized profile still rejects its float-to-int64 conversion.
Nested clock dispatch now works independently of the phase optimization setting;
a dedicated conservative-profile nested scheduler test passes.

## Native validation

The agent session cannot access Docker's Unix socket. These are host/proxy
results; native JieLi image fit, device CPU load and hardware sound remain to be
checked. From a normal macOS Terminal at the repository root, with Docker running:

```sh
bash fm1-base/rnbo-loader/Test-Compatibility.command --jobs 3
```

That compiles and validates packages where host checks pass and records the
phase-disabled retries. It does not install or upload. Use `--host` for host-only
reproduction. The fixed module image/state limits and allocation checks remain
in force.

## Final suite result

212 of 222 patches pass the normal host profile. Five additional cases pass with
phase optimization disabled; four bridge-boundary tests reject as expected.
The remaining visual-Gen graph needs conversion to GenExpr. All 56 regression
stages pass. Native device qualification remains outstanding.
