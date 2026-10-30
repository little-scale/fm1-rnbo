#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Verify matching equations across visual History and nested codebox patches."""
import ctypes as C, json, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parent
APP = ROOT.parent
sys.path.insert(0, str(APP / 'tests/compatibility'))
from probe import Api, Stats

def main():
    libs = []
    apis = []
    render = []
    midi = []
    setters = []
    buf = [(C.c_int * 512)(), (C.c_int * 512)()]
    for ident in ['t05_history', 't06_nested']:
        lib = C.CDLL(str(APP / 'build/hardware-tests' / ident / 'build' / f'{ident}.dylib'), mode=C.RTLD_LOCAL)
        libs.append(lib)
        a = Api.in_dll(lib, 'rnbo_module')
        apis.append(a)
        assert C.CFUNCTYPE(C.c_int)(a.init)() == 1
        render.append(C.CFUNCTYPE(None, C.POINTER(C.c_int), C.c_uint, C.c_uint)(a.render))
        midi.append(C.CFUNCTYPE(None, C.c_uint, C.c_uint, C.c_uint)(a.midi))
        setters.append(C.CFUNCTYPE(None, C.c_uint, C.c_float)(a.set))
    words = 0
    peak = 0
    for stage, value in enumerate([0, 0.25, 0.5, 0.8, 1]):
        for setp, send in zip(setters, midi):
            setp(1, value)
            send(144, 48 + stage * 5, 100)
        for block in range(128):
            for fn, b in zip(render, buf):
                fn(b, 256, 4096)
            assert list(buf[0]) == list(buf[1]), ('History/nested mismatch', stage, block)
            peak = max(peak, max(map(abs, buf[0])))
            words += 512
        for send in midi:
            send(128, 48 + stage * 5, 0)
    for a in apis:
        s = Stats()
        C.CFUNCTYPE(None, C.POINTER(Stats))(a.stats)(C.byref(s))
        assert not (s.errors or s.late or s.bad_samples)
    report = dict(result='pass', patches=['t05_history', 't06_nested'], identical_audio_words=words, peak=peak, hardware_test=False)
    (APP / 'build/hardware-tests/history-ab.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report))
if __name__ == '__main__':
    main()
