# Embedded Gen support on FM1

Updated 30 October 2026. Tested with the installed RNBO 1.4.4 compiler on Apple Silicon. These are host and portability results; native JieLi compilation, FM1 timing and a hardware upload remain unverified for this expansion.

## Verified coverage

The visual-graph importer now uses the installed Gen operator catalogue to resolve aliases, constructor arguments, inlet defaults and attributes. It translates an embedded `dsp.gen` graph into GenExpr for compilation and preserves the editable visual patch in the generated Max document.

**165 fixtures pass**, exercising **144 of the installed catalogue's 155 entries** in the tested forms. The deterministic cases compare **21,495,808 signed 24-bit sample words** exactly against independently authored GenExpr patches, including reconstruction. Noise uses range, variation and mean checks because instances have independent seeds. This is coverage of tested constructors and graphs, not a guarantee for every combination of attributes, arguments or scheduling patterns.

Each fixture runs real RNBO export, host/ARM32/32-bit-size_t portability audits, compilation and runtime checks for allocation stability, errors and invalid audio. Artifact hashes and case names are recorded in `tests/compatibility/gen-results.json`; detailed generated output remains under `build/gen-expansion/`.

| Area | Verified examples |
| --- | --- |
| Constants | Numeric boxes, `constant`, `float`/`f`, `int`/`i`; pi, twopi, halfpi, invpi, e, phi, square-root/logarithmic/angle constants; samplerate and vectorsize |
| Parameters | Exposed `param`, initial values, min/max, changing normalized controls |
| Oscillators and state | Built-in sine `cycle` in frequency/phase mode, phasor, triangle, train, rate, noise, counter, accum/plusequals, mulequals, delta, change, latch, sah, slide, dcblock, elapsed |
| Feedback | History initial state and simultaneous updates; nested Gen feedback; History in codebox |
| Local buffers | Bounded Data, stereo peek/sample/nearest/lookup/wave, poke, splat, dim, channels; moving indices through a filled table |
| Delays and interpolation | Two fractional delay taps; none, linear, cosine, cubic and spline modes; standalone interp |
| Routing and maths | Selector, gate, switch, send/receive, mix, smoothstep, comparisons and Boolean operators; arithmetic including reversed operators; trig, hyperbolic, logarithmic, polar conversions and DSP unit conversions |

Five longer History/reference comparisons also pass, at 1,048,576 sample words each. The existing 58-stage player regression run passed after integration. Additional Gen serialization, browser validation and integer-conversion checks passed separately and are included in the updated regression runner.

## Memory limits

Visual Data and Delay declarations share a **24 KiB estimate budget per Gen graph**, including nested Gen graphs. The estimate conservatively reserves eight bytes per stored value and rounds delay capacity up to a power of two; runtime allocation checks still enforce the total module arena. This graph budget is not a measurement of all patch RAM: oscillator tables, object state, other RNBO objects and codebox allocations are additional.

A `delay` without an explicit size defaults to **2,048 samples**, about 46.4 ms at the fixed 44.1 kHz rate. Default changes and estimates are recorded as `gen_graph_buffers` in export provenance. An explicit delay size is retained if it fits. Data defaults to 512 frames and one channel. Oversized explicit allocations produce an error, rather than silently truncating sample tables.

For example, a 64-frame stereo Data table reserved 1,024 bytes in the conservative estimate and added 608 bytes to the measured host arena, including allocation overhead. The measured sine-driven test used 66,240 bytes overall.

Set limits in the selected module's `module.json`:

```json
{
  "fast_phase": true,
  "float32_delays": true,
  "gen_buffer_max_bytes": 24576,
  "gen_delay_max_samples": 2048
}
```

Equivalent exporter options are `--gen-buffer-max-bytes` and `--gen-delay-max-samples`. Larger settings do not expand the FM1's overall arena, image or state limits. Codebox/bare GenExpr allocation is checked by the compiled module's existing memory/runtime checks, not by the visual declaration estimate.

## Export adaptations

The exported copy repairs RNBO 1.4.4 Gen's missing modulo helper, routes an unqualified square root through float maths, and keeps sample-rate milliseconds conversion in float32 while leaving scheduler timestamps alone. The optimized truncation macro uses a binary32-to-int64 helper, preserving every defined finite cast result; 2,226,705 random defined conversions and boundary/overload checks passed under UBSan. NaN maps to zero and overflow saturates.

Unused Gen mtof lookup tables now receive the same guarded reduction as RNBO mtof objects: reduction is allowed only when all table references are recognized and no table read exists. Raw generated sources, runtime originals and adaptation provenance are retained. No installed RNBO files are modified.

## Remaining restrictions

- External `buffer` and external Gen files/abstractions are not loaded. Use embedded graphs and bounded local Data.
- `expr` boxes and `setparam` routing into nested Gen have not been integrated. Codebox and embedded GenExpr are supported alternatives for authored code; this does not imply identical parameter-routing semantics.
- `voice` is explicitly rejected pending a verified mapping between Gen and RNBO voice indices. RNBO 1.4.4 currently emits an undeclared identifier for a bare Gen voice expression.
- FFT host context, fftinfo and the four FFT constants are unavailable. The catalogue's `read` and `write` entries are internal/illegal standalone operators; Delay read/write methods are supported through the visual delay translation.
- `cycle` currently accepts the built-in sine table only. Named wavetable constructors need additional integration; local tables can already be read with the verified buffer operators.
- Delay uses `@feedback 1`, supports up to eight taps, and retains explicit sizes only within the configured budget. Param supports initial value, min and max. Unreviewed saved object attributes and ambiguous constructors fail explicitly.
- Tests compare imported graphs to the RNBO GenExpr backend, not directly to Max's native Gen audio engine. Max GUI behavior and on-device performance remain separate checks.

## Reproduce

From the repository root, with the local RNBO package available:

```sh
source setup/env.sh
python3 fm1-base/rnbo-loader/tests/compatibility/gen_expansion.py --family all --jobs 3
python3 fm1-base/rnbo-loader/tools/verify.py
```

Individual families are constants, operators, math, structures, buffers, extra and remaining. `--filter` selects a case-name substring. These commands do not upload or install anything. Docker is not needed for these host checks; a separate native build needs access to the Docker engine or the native toolchain.
