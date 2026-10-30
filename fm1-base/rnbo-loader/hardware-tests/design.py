#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Author a playable, bounded hardware qualification collection. Never uploads."""
import copy, json, re
from pathlib import Path
ROOT = Path(__file__).resolve().parent
APP = ROOT.parent

class Graph:

    def __init__(self, gen=False):
        self.p = {'fileversion': 1, 'classnamespace': 'dsp.gen' if gen else 'rnbo', 'rect': [0, 0, 1180, 900], 'boxes': [], 'lines': []}

    def box(self, text, **extra):
        i = len(self.p['boxes'])
        ident = f'obj-{i + 1}'
        self.p['boxes'].append({'box': dict(id=ident, text=text, patching_rect=[25 + i % 4 * 280, 30 + i // 4 * 66, 250, 22]) | {'maxclass': 'newobj'} | extra})
        return ident

    def wire(self, a, b, inlet=0, outlet=0):
        self.p['lines'].append({'patchline': {'source': [a, outlet], 'destination': [b, inlet]}})
        return b

    def op(self, text, *sources):
        b = self.box(text)
        for i, s in enumerate(sources):
            if s is not None:
                self.wire(s, b, inlet=i)
        return b

    def comment(self, text):
        self.box(text, maxclass='comment')

    def document(self):
        return {'patcher': self.p}

def control(name, value, lo, hi, label=None, unit=''):
    return dict(name=name, default=value, min=lo, max=hi, label=label or name.replace('_', ' ').title(), unit=unit)
LEVEL = control('level', 0.12, 0, 0.25)
ATTACK = control('attack', 8, 1, 250, unit='ms')
RELEASE = control('release', 180, 10, 1500, unit='ms')
PAN = control('pan', 0.5, 0, 1)

class Instrument:

    def __init__(self, name, title, bank, middle, tests, listen):
        self.g = Graph()
        self.params = [copy.deepcopy(LEVEL), *middle, copy.deepcopy(ATTACK), copy.deepcopy(RELEASE)]
        assert len(self.params) == 8
        self.meta = dict(id=name, title=title, bank=bank, slot=0, kind='mono', parameters=self.params, tests=tests, listen=listen, config=dict(voices=1, fast_phase=True, float32_delays=True, pool_bytes=98304, gen_buffer_max_bytes=24576, gen_delay_max_samples=2048))
        self.g.comment(title + ' — ' + listen)
        self.p = {}
        for i, c in enumerate(self.params):
            self.p[c['name']] = self.g.box(f'''param {c['name']} {c['default']} @min {c['min']} @max {c['max']} @displayorder {i + 1} @displayname "{c['label']}"''')
        self.note = self.g.box('notein')
        self.freq = self.g.op('expr 440. * exp((in1 - 69.) * 0.0577622650466621)', self.note)
        self.vel = self.g.box('/ 127.')
        self.g.wire(self.note, self.vel, outlet=1)
        self.env = self.g.op('adsr~ 8 40 0.7 180', self.vel, self.p['attack'])
        self.g.wire(self.p['release'], self.env, inlet=4)

    def sig(self, event):
        return self.g.op('sig~', event)

    def dry(self, osc='saw~'):
        return self.g.op('*~', self.g.op(osc, self.freq), self.env)

    def gen(self, g, connections, **attrs):
        b = self.g.box('gen~', patcher=g.p, **attrs)
        for i, a in enumerate(connections):
            self.g.wire(a, b, inlet=i)
        return b

    def finish(self, left, right=None, gate=False):
        if right is None and 'pan' in self.p:
            l = self.g.op('expr 2. * min(1. - in1, 0.5)', self.p['pan'])
            r = self.g.op('expr 2. * min(in1, 0.5)', self.p['pan'])
            right = self.g.op('*~', left, r)
            left = self.g.op('*~', left, l)
        right = right or left
        for i, source in enumerate([left, right]):
            if gate:
                source = self.g.op('*~', source, self.env)
            source = self.g.op('*~', source, self.p['level'])
            source = self.g.op('clip~ -0.8 0.8', source)
            self.g.wire(source, self.g.box('out~ ' + str(i + 1)))
        self.meta['patch'] = self.g.document()
        return self.meta

def gen_inputs(n):
    g = Graph(True)
    return (g, [g.box('in ' + str(i + 1)) for i in range(n)])

def gen_out(g, a, b=None):
    g.wire(a, g.box('out 1'))
    if b is not None:
        g.wire(b, g.box('out 2'))

def mix(g, a, b, amount, signal=True):
    if signal:
        inv = g.op('expr 1. - in1', amount)
        return g.op('+~', g.op('*~', a, inv), g.op('*~', b, amount))
    return g.op('mix', a, b, amount)

def collection():
    s = Instrument('t01_keys', 'Keys And Eight Knobs', 1, [control('shape', 0.2, 0, 1), control('detune', 0, -12, 12, unit='semitones'), control('cutoff', 2500, 100, 9000, unit='Hz'), control('resonance', 0.15, 0, 0.8), PAN], ['notein, velocity, mtof expression, ADSR, filters', 'All eight knobs and FX banking; pan and patch graphics'], 'Start with single notes. Shape blends sine/saw; detune affects the saw. Pan must reach each speaker separately.')
    a = s.g.op('cycle~', s.freq)
    df = s.g.op('expr in1 * exp(in2 * 0.0577622650466621)', s.freq, s.p['detune'])
    b = s.g.op('saw~', df)
    x = mix(s.g, a, b, s.p['shape'])
    x = s.g.op('lores~ 2500 0.15', x, s.p['cutoff'], s.p['resonance'])
    yield s.finish(x, gate=True)
    s = Instrument('t02_clock', 'Clock Steps And Glide', 1, [control('period', 180, 60, 700, unit='ms'), control('interval', 2, 0, 12, unit='semitones'), control('glide', 25, 0, 120, unit='ms'), control('rotate', 0, 0, 7, unit='steps'), PAN], ['RNBO metro, event counter, hot arithmetic and scheduled line~', 'Clock stop/start and changing period without stuck notes'], 'Hold one key for an eight-step staircase. Release stops the clock; another key resumes the step position. Glide should smooth the jumps.')
    gate = s.g.op('> 0', s.vel)
    clock = s.g.op('metro 180', gate, s.p['period'])
    count = s.g.op('counter 0 7', clock)
    shift = s.g.op('+ @hot 1', count, s.p['rotate'])
    step = s.g.op('% 8', shift)
    offset = s.g.op('* @hot 1', step, s.p['interval'])
    pitch = s.g.op('+ @hot 1', s.note, offset)
    f = s.g.op('expr 440. * exp((in1 - 69.) * 0.0577622650466621)', pitch)
    pack = s.g.op('pack 0. 25.', f, s.p['glide'])
    ramp = s.g.op('line~', pack)
    yield s.finish(s.g.op('cycle~', ramp), gate=True)
    s = Instrument('t03_lists', 'Sixty Four Step List', 1, [control('step', 0, 0, 63, unit='index'), control('first', 0, -12, 12, unit='semitones'), control('transpose', 0, -12, 12, unit='semitones'), control('brightness', 2000, 100, 8000, unit='Hz'), PAN], ['64-item pack, list.reg copy, list.rev and read-only list.lookup', 'Repeated list updates after initialization without allocation growth'], 'Hold a note and scan Step through the stored melody. First changes the last step after reversal. Transpose shifts the whole melody.')
    values = [0, 2, 4, 7, 9, 7, 4, 2] * 8
    pack = s.g.op('pack ' + ' '.join((str(v) + '.' for v in values)), s.p['first'])
    reg = s.g.op('list.reg', pack)
    rev = s.g.op('list.rev', reg)
    idx = s.g.op('int', s.p['step'])
    trigger = s.g.op('t b l', rev)
    lookup = s.g.op('list.lookup', idx)
    s.g.wire(trigger, lookup, 1, 1)
    s.g.wire(trigger, idx)
    nth = s.g.op('unpack 0.', lookup)
    off = s.g.op('+ @hot 1', nth, s.p['transpose'])
    pitch = s.g.op('+ @hot 1', s.note, off)
    f = s.g.op('expr 440. * exp((in1 - 69.) * 0.0577622650466621)', pitch)
    x = s.g.op('saw~', f)
    x = s.g.op('lores~ 2000 0.1', x, s.p['brightness'])
    yield s.finish(x, gate=True)
    s = Instrument('t04_constants', 'Gen Constants Oscillator', 2, [control('ratio', 1, 0.25, 4), control('phase', 0, 0, 1, unit='cycles'), control('harmonic', 1, 1, 8), control('blend', 0, 0, 1), PAN], ['Visual Gen numeric/named constants, phasor, samplerate, twopi, pi, sin', 'RNBO controls sent to named Gen Param attributes, frequency ratios and phase wrapping'], 'A sine oscillator with a second harmonic blend. Ratio 1 follows the keyboard. A sharp discontinuity while moving Phase is expected.')
    g, (freq, harm, blend) = gen_inputs(3)
    ratio = g.box('param Ratio 1 @min 0.25 @max 4')
    phase = g.box('param Phase 0 @min 0 @max 1')
    p = g.op('phasor', g.op('*', freq, ratio))
    p = g.op('wrap 0 1', g.op('+', p, phase))
    angle = g.op('*', p, g.box('twopi'))
    fund = g.op('sin', angle)
    other = g.op('sin', g.op('*', angle, harm))
    x = mix(g, fund, other, blend, False)
    sr = g.box('samplerate')
    gain = g.op('/', sr, g.box('constant 44100'))
    x = g.op('*', x, gain)
    gen_out(g, x)
    x = s.gen(g, [s.sig(s.freq), s.sig(s.p['harmonic']), s.sig(s.p['blend'])])
    s.g.wire(s.g.op('set Ratio', s.p['ratio']), x)
    s.g.wire(s.g.op('set Phase', s.p['phase']), x)
    yield s.finish(x, gate=True)
    s = Instrument('t05_history', 'Gen History Lowpass', 2, [control('feedback', 0.8, 0, 0.98), control('drive', 1, 1, 8), control('mix', 1, 0, 1), control('cutoff', 6500, 300, 9000, unit='Hz'), PAN], ['One-sample History feedback, old-state reads, stability at 0.98', 'DC blocking, nonlinear drive and live smoothing coefficient'], 'Feedback darkens the sound smoothly. At 0.98 it should remain stable. Mix 0 is the dry reference; Mix 1 is fully filtered.')
    dry = s.dry()
    dry = s.g.op('lores~ 6500 0.1', dry, s.p['cutoff'])
    g, (a, fb, drive, amount) = gen_inputs(4)
    h = g.box('history previous 0')
    inv = g.op('!- 1', fb)
    y = g.op('+', g.op('*', a, inv), g.op('*', h, fb))
    g.wire(y, h)
    wet = g.op('dcblock', g.op('tanh', g.op('*', y, drive)))
    gen_out(g, mix(g, a, wet, amount, False))
    x = s.gen(g, [dry, s.sig(s.p['feedback']), s.sig(s.p['drive']), s.sig(s.p['mix'])])
    yield s.finish(x)
    s = Instrument('t06_nested', 'Nested Gen And Codebox', 2, [control('feedback', 0.7, 0, 0.98), control('drive', 1, 1, 8), control('mix', 1, 0, 1), control('cutoff', 6500, 300, 9000, unit='Hz'), PAN], ['Nested visual Gen boundaries, scoped History, codebox state', 'Cross-check behavior against History Lowpass with matched settings'], 'This uses the same filter equation through nested Gen and codebox. Match controls with History Lowpass for an A/B check.')
    dry = s.g.op('lores~ 6500 0.1', s.dry(), s.p['cutoff'])
    child, (a, fb) = gen_inputs(2)
    c = child.box('', maxclass='codebox', numinlets=2, numoutlets=1, code='History previous(0); y=in1*(1-in2)+previous*in2; out1=y; previous=fixdenorm(y);')
    child.wire(a, c)
    child.wire(fb, c, 1)
    gen_out(child, c)
    g, (a, fb, drive, amount) = gen_inputs(4)
    n = g.op('gen', a, fb)
    next((v['box'] for v in g.p['boxes'] if v['box']['id'] == n))['patcher'] = child.p
    wet = g.op('dcblock', g.op('tanh', g.op('*', n, drive)))
    gen_out(g, mix(g, a, wet, amount, False))
    yield s.finish(s.gen(g, [dry, s.sig(s.p['feedback']), s.sig(s.p['drive']), s.sig(s.p['mix'])]))
    s = Instrument('t07_hold', 'Gen Sample And Hold', 3, [control('rate', 5, 0.5, 25, unit='Hz'), control('depth', 0.6, 0, 1), control('steps', 4, 1, 12), control('smooth', 20, 1, 500, unit='samples'), PAN], ['Gen noise, sah, phasor, comparisons, int, slide and cycle', 'Sample-rate state with predictable step-rate control'], 'Hold a note for random stepped pitch. Rate sets the steps per second; Smooth softens transitions. Depth 0 returns to a steady pitch.')
    g, (freq, rate, depth, steps, smooth) = gen_inputs(5)
    p = g.op('phasor', rate)
    tr = g.op('< 0.5', p)
    noise = g.box('noise')
    held = g.op('sah 0', noise, tr)
    q = g.op('int', g.op('*', held, steps))
    q = g.op('/', q, steps)
    q = g.op('slide', q, smooth, smooth)
    mod = g.op('+ 1', g.op('*', q, depth))
    osc = g.op('cycle', g.op('*', freq, mod))
    gen_out(g, osc)
    yield s.finish(s.gen(g, [s.sig(s.freq), *[s.sig(s.p[k]) for k in ['rate', 'depth', 'steps', 'smooth']]]), gate=True)
    s = Instrument('t08_table', 'Gen Local Stereo Table', 3, [control('ratio', 1, 0.25, 4), control('shape', 0.5, 0, 1), control('offset', 0.25, 0, 1, unit='cycles'), control('mix', 1, 0, 1), PAN], ['Local Data 256x2, counter, poke, sample, nearest, dim, channels', 'Table rewrites, phase indexing and stereo channel addressing'], 'A locally generated wavetable. Shape blends sine and saw; Offset changes the right-channel phase. Mix compares nearest and linear reads.')
    g, (freq, ratio, shape, offset, amount) = gen_inputs(5)
    g.box('data table 256 2')
    c = g.box('counter 1 256')
    phase = g.op('/ 256', c)
    sine = g.op('sin', g.op('*', phase, g.box('twopi')))
    saw = g.op('- 1', g.op('* 2', phase))
    wave = mix(g, sine, saw, shape, False)
    w = g.op('poke table', wave, c)
    w2 = g.op('poke table 1', g.op('neg', wave), c)
    readphase = g.op('phasor', g.op('*', freq, ratio))
    phase2 = g.op('wrap 0 1', g.op('+', readphase, offset))
    a = g.op('sample table', readphase)
    b = g.op('nearest table', readphase)
    right = g.op('sample table', phase2, g.box('constant 1'))
    gen_out(g, mix(g, b, a, amount, False), right)
    node = s.gen(g, [s.sig(s.freq), *[s.sig(s.p[k]) for k in ['ratio', 'shape', 'offset', 'mix']]])
    r = s.g.box('*~ 1')
    s.g.wire(node, r, outlet=1)
    lpan = s.g.op('expr 2. * min(1. - in1, 0.5)', s.p['pan'])
    rpan = s.g.op('expr 2. * min(in1, 0.5)', s.p['pan'])
    yield s.finish(s.g.op('*~', node, lpan), s.g.op('*~', r, rpan), gate=True)
    s = Instrument('t09_gendelay', 'Gen Dual Tap Delay', 3, [control('time', 16, 1, 40, unit='ms'), control('feedback', 0.45, 0, 0.98), control('mix', 0.5, 0, 1), control('spread', 1.3, 0.5, 1.8), control('brightness', 5000, 300, 9000, unit='Hz')], ['Bounded 2048-sample Gen delay, two fractional taps and feedback', 'Dry/wet endpoints and stable high feedback'], 'Short stereo echoes become comb/flange tones on held notes. Play short notes to hear the tail. Mix 1 must remove the immediate dry sound.')
    dry = s.g.op('lores~ 5000 0.1', s.dry(), s.p['brightness'])
    g, (a, time, fb, amount, spread) = gen_inputs(5)
    d = g.box('delay 2048 2')
    t = g.op('* 44.1', time)
    g.wire(t, d, 1)
    t2 = g.op('clamp 1 2048', g.op('*', t, spread))
    g.wire(t2, d, 2)
    feed = g.op('+', g.op('*', a, g.op('!- 1', fb)), g.op('*', d, fb))
    g.wire(feed, d)
    tap = g.box('pass')
    g.wire(d, tap, outlet=1)
    gen_out(g, mix(g, a, d, amount, False), mix(g, a, tap, amount, False))
    n = s.gen(g, [dry, *[s.sig(s.p[k]) for k in ['time', 'feedback', 'mix', 'spread']]])
    r = s.g.box('*~ 1')
    s.g.wire(n, r, outlet=1)
    yield s.finish(n, r)
    s = Instrument('t10_comb', 'RNBO Comb And Allpass', 4, [control('time', 8, 1, 16, unit='ms'), control('feedback', 0.45, 0, 0.9), control('mix', 0.5, 0, 1), control('diffuse', 0.5, 0, 1), PAN], ['Bounded comb~/allpass~ rings and signal-rate audio through both', 'Declared duration cap and phase coloration at small memory cost'], 'Time changes a metallic resonance. Diffuse blends the comb with its allpass stage. Feedback 0 gives a useful short-delay reference.')
    s.meta['config']['filter_delay_max_ms'] = 16
    dry = s.dry()
    feed = s.g.op('expr 1. - in1', s.p['feedback'])
    x = s.g.op('*~', dry, feed)
    comb = s.g.op('comb~ 8 0.5 0.5 0.5', x, s.p['time'])
    s.g.wire(s.p['feedback'], comb, 4)
    ap = s.g.op('allpass~ 8 0.5', comb, s.p['time'], s.p['feedback'])
    wet = mix(s.g, comb, ap, s.p['diffuse'])
    yield s.finish(mix(s.g, dry, wet, s.p['mix']))
    s = Instrument('t11_lofi', 'RNBO LoFi And Averages', 4, [control('crush', 0.5, 0, 1), control('smooth', 0.5, 0, 1), control('drive', 1, 1, 6), control('cutoff', 5000, 100, 9000, unit='Hz'), PAN], ['Fixed downsamp~ 4, average~ 32 and average_rms~ 32', 'Bounded averaging history and float32 audio path'], 'Crush blends sample holding; Smooth blends a 32-sample moving average. Drive adds saturation. Listen for clean parameter changes and no lasting DC.')
    dry = s.g.op('lores~ 5000 0.1', s.dry(), s.p['cutoff'])
    held = s.g.op('downsamp~ 4', dry)
    x = mix(s.g, dry, held, s.p['crush'])
    avg = s.g.op('average~ 32', x)
    rms = s.g.op('average_rms~ 32', x)
    wet = mix(s.g, x, avg, s.p['smooth'])
    x = s.g.op('tanh~', s.g.op('*~', wet, s.p['drive']))
    gain = s.g.op('+~ 0.8', s.g.op('*~ 0.2', rms))
    yield s.finish(s.g.op('dcblock~', s.g.op('*~', x, gain)))
    s = Instrument('t12_genmath', 'Gen Maths And Routing', 4, [control('drive', 2, 1, 8), control('mode', 1, 1, 3), control('symmetry', 0, -0.5, 0.5), control('mix', 0.5, 0, 1), PAN], ['Gen wrap, fold, tanh, selector, named send/receive, dcblock', 'Reverse operators, variable selector and bounded nonlinear paths'], 'Mode selects fold, wrap or tanh shaping. Mix 0 is the dry reference. Symmetry shifts the shape; the DC blocker should prevent a persistent offset.')
    dry = s.dry()
    g, (a, drive, mode, sym, amount) = gen_inputs(5)
    v = g.op('+', g.op('*', a, drive), sym)
    fold = g.op('fold -1 1', v)
    wrap = g.op('wrap -1 1', v)
    sat = g.op('tanh', v)
    choose = g.op('int', mode)
    sel = g.op('selector 3', choose, fold, wrap, sat)
    g.op('send shaped', sel)
    r = g.box('receive shaped')
    gen_out(g, mix(g, a, g.op('dcblock', r), amount, False))
    yield s.finish(s.gen(g, [dry, *[s.sig(s.p[k]) for k in ['drive', 'mode', 'symmetry', 'mix']]]))
    for number, source, title, hybrid in [(13, 'fm8poly2fast', 'Two Voice FM Reference', False), (14, 'fm4echo', 'Four Voice Master Echo', False), (15, 'fm4echo', 'Four Voice Gen Hybrid', True)]:
        doc = json.loads((APP / 'patches' / f'{source}.rnbopat').read_text())
        p = doc['patcher']
        config = json.loads((APP / 'modules' / source / 'module.json').read_text())
        config.update(float32_delays=True, fast_phase=True)
        if number == 13:
            order = ['level', 'ratio', 'depth', 'pan', 'decay', 'sustain', 'attack', 'release']
        else:
            order = ['level', 'ratio', 'depth', 'echo_time', 'echo_feedback', 'echo_mix', 'attack', 'release']
        params = []
        for key in order:
            b = next((v['box'] for v in p['boxes'] if v['box'].get('text', '').startswith('param ' + key + ' ')))
            tokens = b['text'].split()
            value = float(tokens[2])
            lo = float(tokens[tokens.index('@min') + 1])
            hi = float(tokens[tokens.index('@max') + 1])
            c = control(key, value, lo, hi)
            params.append(c)
            b['text'] = f'''param {key} {value} @min {lo} @max {hi} @displayorder {len(params)} @displayname "{c['label']}"'''
        tests = ['RNBO voice allocation, stealing, voice sleep, MIDI release and parameter broadcast']
        listen = 'Play a chord, then add another note to force stealing. Old note-offs must not kill a newer voice. Release all keys and observe idle CPU.'
        if number >= 14:
            tests += ['One shared master echo, feedback 0.98, fully wet mix, panic and effect reset']
            listen += ' Echo tails must continue after releasing the chord.'
        if hybrid:
            child = next((v['box']['patcher'] for v in p['boxes'] if v['box'].get('patcher')))
            b = next((v['box'] for v in child['boxes'] if v['box']['id'] == 'o2'))
            g, (a,) = gen_inputs(1)
            ph = g.op('phasor', a)
            osc = g.op('sin', g.op('*', ph, g.box('twopi')))
            gen_out(g, osc)
            b['text'] = 'gen~'
            b['patcher'] = g.p
            for k in ['rnboinfo', 'rnbo_extra_attributes', 'rnbo_classname']:
                b.pop(k, None)
            tests += ['Embedded visual Gen inside four RNBO voices; constants and separate oscillator state']
            listen += ' Compare against Four Voice Master Echo for tuning, allocation and CPU; oscillator starting phase can differ.'
        yield dict(id=f't{number:02d}_' + ('fm2' if number == 13 else 'fm4echo' if number == 14 else 'hybrid'), title=title, bank=5, slot=number - 12, kind='poly', parameters=params, tests=tests, listen=listen, config=config, patch=doc)

def generate():
    cases = list(collection())
    assert len(cases) == 15
    for index, c in enumerate(cases):
        c['slot'] = index % 3 + 1
        folder = ROOT / 'patches' / c['id']
        folder.mkdir(parents=True, exist_ok=True)
        (folder / (c['id'] + '.rnbopat')).write_text(json.dumps(c.pop('patch'), indent=2) + '\n')
        (folder / 'module.json').write_text(json.dumps(c['config'], indent=2) + '\n')
        c['source'] = f"patches/{c['id']}/{c['id']}.rnbopat"
    (ROOT / 'manifest.json').write_text(json.dumps({'format': 1, 'patches': cases}, indent=2) + '\n')
    print('Authored', len(cases), 'standalone patches')
if __name__ == '__main__':
    generate()
