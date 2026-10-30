#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Audition keyboard patches, exercise every knob, and save a host-only WAV."""
import argparse, ctypes as C, json, math, struct, sys, wave
from pathlib import Path
ROOT = Path(__file__).resolve().parent
APP = ROOT.parent
sys.path.insert(0, str(APP / 'tests/compatibility'))
from probe import Api, Stats

def main():
    p = argparse.ArgumentParser()
    p.add_argument('module', type=Path)
    p.add_argument('--id', required=True)
    a = p.parse_args()
    case = next((c for c in json.loads((ROOT / 'manifest.json').read_text())['patches'] if c['id'] == a.id))
    lib = C.CDLL(str(a.module.resolve()), mode=C.RTLD_LOCAL)
    api = Api.in_dll(lib, 'rnbo_module')
    init = C.CFUNCTYPE(C.c_int)(api.init)
    render = C.CFUNCTYPE(None, C.POINTER(C.c_int), C.c_uint, C.c_uint)(api.render)
    midi = C.CFUNCTYPE(None, C.c_uint, C.c_uint, C.c_uint)(api.midi)
    setp = C.CFUNCTYPE(None, C.c_uint, C.c_float)(api.set)
    getp = C.CFUNCTYPE(C.c_float, C.c_uint)(api.value)
    getname = C.CFUNCTYPE(C.c_char_p, C.c_uint)(api.name)
    statsfn = C.CFUNCTYPE(None, C.POINTER(Stats))(api.stats)
    panic = C.CFUNCTYPE(None)(api.panic)
    count = C.CFUNCTYPE(C.c_uint)(api.count)
    audio = (C.c_int * 512)()
    stats = Stats()
    assert init() == 1
    assert count() == 8, count()
    names = [getname(i).decode() for i in range(8)]
    expected = [c['label'] for c in case['parameters']]
    assert names == expected, (names, expected)
    statsfn(C.byref(stats))
    allocated = stats.allocations
    record = []
    peak = 0

    def process(seconds, save=False):
        nonlocal peak
        values = []
        for _ in range(math.ceil(seconds * 44100 / 256)):
            render(audio, 256, 4096)
            v = list(audio)
            values.extend(v)
            peak = max(peak, max(map(abs, v)))
            if save:
                record.extend(v)
        statsfn(C.byref(stats))
        assert not (stats.errors or stats.late or stats.bad_samples), tuple((getattr(stats, n) for n, _ in Stats._fields_))
        assert stats.allocations == allocated
        return values

    def rms(v):
        return math.sqrt(sum((x * x for x in v)) / len(v)) / 8388607
    idle = process(0.2)
    assert max(map(abs, idle)) <= 8, 'Not quiet before a note'
    for note in [48, 60, 67, 72]:
        midi(144, note, 90)
        v = process(0.4, True)
        assert max(map(abs, v)) > 64, 'No audible note'
        midi(128, note, 0)
        process(0.25, True)
    if case['kind'] == 'poly':
        for note in [48, 55, 60, 64, 67, 72]:
            midi(144, note, 100)
            process(0.12, True)
        for note in [48, 55, 60, 64, 67, 72]:
            midi(128, note, 0)
            process(0.1, True)
    process(3, True)
    tail = process(2)
    assert rms(tail) < 0.005, ('Default tail did not decay', rms(tail))
    responses = []
    for index, parameter in enumerate(case['parameters']):
        extrema = []
        for value in [0, 1]:
            assert init() == 1
            statsfn(C.byref(stats))
            allocated = stats.allocations
            setp(index, value)
            assert abs(getp(index) - value) < 1e-05, (index, value, getp(index))
            midi(144, 60, 100)
            v = process(0.7)
            midi(128, 60, 0)
            process(0.1)
            left = v[::2]
            crossings = sum((x <= 0 < y for x, y in zip(left, left[1:])))
            extrema.append(dict(normalized=value, rms=round(rms(v), 6), peak=max(map(abs, v)), positive_zero_crossings=crossings))
        responses.append(dict(knob=index + 1, name=parameter['label'], extrema=extrema))
    if a.id == 't04_constants':
        lo, hi = responses[1]['extrema']
        ratio = hi['positive_zero_crossings'] / max(1, lo['positive_zero_crossings'])
        assert 15 < ratio < 17, ('RNBO-to-Gen Param Ratio did not change frequency by 16x', ratio)
    if a.id == 't03_lists':
        lo, hi = responses[1]['extrema']
        ratio = lo['positive_zero_crossings'] / max(1, hi['positive_zero_crossings'])
        assert 1.09 < ratio < 1.15, ('List endpoint pitches are not two semitones apart', ratio)
    assert init() == 1
    statsfn(C.byref(stats))
    allocated = stats.allocations
    for val in [0, 0.25, 0.5, 0.75, 1, 0.5]:
        for index in range(8):
            setp(index, val)
        midi(144, 60, 110)
        process(0.35)
        midi(128, 60, 0)
        process(0.15)
    panic()
    silence = process(0.05)
    assert not any(silence), 'Panic did not silence module'
    assert init() == 1
    statsfn(C.byref(stats))
    allocated = stats.allocations
    midi(144, 60, 100)
    assert max(map(abs, process(0.15))) > 64
    panic()
    out = a.module.parent.parent / 'audition.wav'
    with wave.open(str(out), 'wb') as w:
        w.setnchannels(2)
        w.setsampwidth(3)
        w.setframerate(44100)
        w.writeframes(b''.join((int(v).to_bytes(3, 'little', signed=True) for v in record)))
    statsfn(C.byref(stats))
    report = dict(parameters=names, pool_bytes=stats.pool_used, pool_capacity=stats.pool_capacity, peak=peak, peak_dbfs=round(20 * math.log10(max(1, peak) / 8388607), 2), default_tail_rms=round(rms(tail), 8), knob_tests=responses, preview_seconds=len(record) / 88200, preview='audition.wav', hardware_test=False)
    print(json.dumps(report, indent=2))
if __name__ == '__main__':
    main()
