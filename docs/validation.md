# Validation snapshot — 29 October 2026

The visual player's original 43 host/proxy checks passed. Publication adds one
installer regression check: player-only installation must not depend on old
example module builds, and changed firmware must be rejected before accessing
hardware. The published checkout is checked with the resulting 44-stage suite.

Native hardware evidence for the visual revision:

| Item | Recorded result |
| --- | --- |
| Player identity | `FM-1_9400` |
| Player package SHA-256 | `1a8a3092183f53efb5d9b188cfcdaf9d5d20fcaf80f2067cfa663f356fd3727b` |
| Saw module SHA-256 | `07cab332d28e0bfc363ed8b7c899c72e7b5fbf703b8bbe8bd8dceea295778ed8` |
| Patch identity | `3434814855` |
| Activation | Status 0, slot 1 |
| Module image / state | 21,996 / 116,224 bytes |
| Layout data | 732 bytes |
| Status CPU / xruns | 2% / 0 |
| Saw host allocator | 32,864 bytes used; no late allocations/errors/bad samples |

The installer reported successful firmware restart. Upload acknowledged the
expected patch identity and active slot. The owner then confirmed the result.
The source-repository installation fix does not change firmware or patch DSP.

These are specific observations, not guarantees for arbitrary RNBO patches.
CPU was a status snapshot; worst-case timing with MIDI bursts and continuous
parameter changes still needs measurement. The three-bar battery indicator
uses stock ADC thresholds rather than a calibrated discharge curve. Actual
browser Web MIDI transfer remains unverified; its orchestration and failure
paths are covered by local tests. Raw private logs and device-specific state
are not part of the repository.
