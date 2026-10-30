# RNBO/FM1 compatibility sweep

This suite generates **222 connected test patches** and runs each through the
existing player builder, without installing firmware or opening a MIDI port.
Candidate names are not a claim that the pinned RNBO compiler accepts every
operator spelling or argument combination. Export errors remain fixture/export
failures until reviewed; they are not automatically labeled unsupported objects.

From the repository root on the Mac that already has Max/RNBO installed:

```sh
bash fm1-base/rnbo-loader/Test-Compatibility.command
```

`--jobs 1..8` runs isolated builds concurrently; reports retain source order.

The normal build performs RNBO 1.4.4 code generation, host/ARM32/32-bit-size_t
portability audits, host compilation and initialization, then native JieLi
compilation/linking/package validation. The sweep adds a separate real-module
runtime probe: note/chord/channel MIDI bursts, sustain/controller/bend input,
parameter endpoints, delayed processing, allocation and numerical checks,
non-silence where expected, panic, and explicit reconstruction. Scheduling
fixtures generate measurable output; this is not a full timing-accuracy proof.
No host benchmark is presented as device CPU or hardware validation.

Every fixture is isolated under `build/compatibility/`. The suite writes
`REPORT.md` and `report.json` after each completed case, with stage logs and
reviewed artifacts in its run directory. It continues after failures. Resume
requires matching source/configuration fingerprints and a matching compiled
artifact hash; it cannot turn a missing compiler into a cached pass.

```sh
# First test a manageable family or subset.
bash fm1-base/rnbo-loader/Test-Compatibility.command --limit 10
bash fm1-base/rnbo-loader/Test-Compatibility.command --filter 'oscillators'
# Host code generation/audits/audio only, without a device compiler.
bash fm1-base/rnbo-loader/Test-Compatibility.command --host --jobs 3
# Generate connected JSON fixtures without asserting compilation success.
bash fm1-base/rnbo-loader/Test-Compatibility.command --generate-only
```

The launcher retries portability/compile/runtime failures with phase
optimizations disabled and records that outcome separately. A reference retry
is diagnostic; it does not silently change the normal uploader's compiler
profile or bypass its validation. Source-name/fixture errors are not retried as
if removing phase optimization could fix them.

Coverage includes oscillators, signal/event arithmetic, comparisons,
conversions, filters/state, bounded delays, lists, scheduled events, parameters,
internal send/receive, local data/peek/poke buffers, codebox/event codebox,
branching/loops/state, nested and branched subpatches, nested clocks, MIDI,
mono/2/4 voices, fan-in/fan-out and feedback with an explicit delay break.
Boundary patches check the exact lengths of static and copied lists around
the inline storage threshold, 0/1/8/16/17 controls,
wrong output counts and audio inputs. Embedded Gen has a dedicated probe for
the existing adapter integration gate; it is not called an RNBO limitation.

## Reading results

- `pass`: all selected compiler/audit/runtime stages succeeded. Native versus
  host-only mode is recorded in the report. Neither result proves hardware.
- `expected_reject`: the existing bridge rejected an intentionally invalid
  audio-channel/parameter-count fixture at initialization.
- `resource_limit`: an explicit memory/image/state limit was reached.
- `fixture_or_export_failure`: review syntax, aliases, attributes, wiring and
  exporter support before attributing failure to an RNBO object.
- `adapter_integration_gap`: an explicit known exporter gate, currently Gen.
- Other failures identify audit, compilation, validation or runtime stages.
- `generated_not_compiled` / `blocked_environment`: **no compatibility result**.

## Adapter areas to investigate from actual results

The current source has a 16-entry inline list setting (larger lists can allocate
additional storage), a specialized float32
conversion for `delay~` buffers, fast phase conversion plus a `saw~` truncation
adapter, and an explicit embedded-Gen rejection. These are source observations,
not new benchmark results. The sweep is designed to reveal whether standard
objects encounter these restrictions and which fixes preserve their semantics.
External sample files, host UI/OS/network services and physical MIDI output
are outside this test. Arbitrary external inport/outport messages need a player
API; internal named routing is tested separately.

## Tester verification

```sh
python3 fm1-base/rnbo-loader/tests/compatibility/test_suite.py
```

Seven harness tests check connected coverage, unique case names, failure
classification, isolation, honest reports, and runtime detection of bad module
contracts. Controlled C modules used by those tests are **not RNBO objects**
and are not counted as RNBO compatibility passes. The production pipeline still
needs the installed RNBO 1.4.4 package, Apple fonts for the full player, and the
native toolchain/Docker for target builds.

## Focused regression checks

```sh
# Compare actual RNBO mtof/mtof~ output with the original 65536-sample allocation.
python3 fm1-base/rnbo-loader/tests/compatibility/mtof.py
node fm1-base/rnbo-loader/tests/mtof-table.cjs \
  fm1-base/rnbo-loader/build/compatibility-mtof-comparison/mtof/export/rnbo_source.h.reference
# Check prepared mixed float/integer maths against float32 libm.
python3 fm1-base/rnbo-loader/tests/compatibility/mixed_math.py --export PATH_TO_A_SUITE_EXPORT
```

The table adapter retains the original generated code and checks all table
consumers. An unexpected reader, alias or changed allocation pattern keeps the
original allocation. It never reduces a table that generated DSP reads. The
player does not expose the otherwise unused desktop data reference to a host.

The float32 runtime adapters retain the double-precision branch of the original
math wrappers. Scheduler timeline types remain double precision. Remaining
audit failures are reported without disabling checks.

The buffer, reset and conservative-clock regression helpers are described in
[BOUNDED-FILTERS.md](../../BOUNDED-FILTERS.md).
