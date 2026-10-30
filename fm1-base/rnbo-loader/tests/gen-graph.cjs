// SPDX-License-Identifier: MIT
const assert = require('node:assert/strict');
const {genGraph, catalogue} = require('../../rnbo/tools/gen-graph.cjs');
const box = (id, text, extra = {}) => ({box: {id, text, maxclass: 'newobj', ...extra}});
const wire = (a, b, inlet = 0, outlet = 0) => ({patchline: {source: [a, outlet], destination: [b, inlet]}});
const graph = () => ({classnamespace: 'dsp.gen', boxes: [box('a', 'in 1'), box('b', '* 0.5'), box('c', 'out 1')], lines: [wire('a', 'b'), wire('b', 'c')]});
let g = graph();
const before = JSON.stringify(g), result = genGraph(g);
assert.equal(result.geninlets, 1); assert.equal(result.genoutlets, 1);
assert.match(result.expr, /mul\(.*0.5\)/); assert.match(result.expr, /out1 =/);
assert.equal(JSON.stringify(g), before);
for (const text of ['history 1', '* @foo 1', 'fftin', 'buffer external', 'cycle external']) {
  g = graph(); g.boxes[1].box.text = text;
  assert.throws(() => genGraph(g), /Unsupported embedded Gen/);
}
g = graph(); g.lines.push(wire('b', 'b')); assert.throws(() => genGraph(g), /multiple cords/);
g = graph(); g.lines = [wire('b', 'b'), wire('b', 'c')]; assert.throws(() => genGraph(g), /feedback/);
// Gen's unconnected inputs use their declared defaults.
g = graph(); g.lines = [wire('b', 'c')]; assert.match(genGraph(g).expr, /mul\(1, 0.5\)/);
g = graph(); g.boxes.push(box('d', 'in 3')); assert.throws(() => genGraph(g), /noncontiguous/);
g = graph(); g.boxes.push(box('d', 'in 1')); assert.throws(() => genGraph(g), /duplicate in port/);
g = graph(); g.lines[0].patchline.source[1] = 1; assert.throws(() => genGraph(g), /invalid cord/);
// Every non-FFT constant and its catalogue aliases translate to the same token.
for (const [name, meta] of catalogue()) {
  if (meta.box_expr !== 'constant' || meta.op === 'constant' || meta.op.startsWith('FFT')) continue;
  g = {classnamespace: 'dsp.gen', boxes: [box('a', name), box('o', 'out 1')], lines: [wire('a', 'o')]};
  assert.ok(genGraph(g).expr.includes('= ' + meta.op + ';'), name);
}
for (const name of ['fftsize', 'ffthop', 'fftoffset', 'fftfullspect']) {
  g = {classnamespace: 'dsp.gen', boxes: [box('a', name), box('o', 'out 1')], lines: [wire('a', 'o')]};
  assert.throws(() => genGraph(g), /FFT host context/);
}
g = {classnamespace: 'dsp.gen', boxes: [box('a', 'voice'), box('o', 'out 1')], lines: [wire('a', 'o')]};
assert.throws(() => genGraph(g), /voice-index mapping/);
// Multi-output nodes are emitted once, independent of box storage order.
g = {classnamespace: 'dsp.gen', boxes: [box('c', 'counter 1 17'), box('o', 'out 1'), box('p', 'out 2')], lines: [wire('c', 'o'), wire('c', 'p', 0, 2)]};
g.boxes.reverse(); assert.equal(genGraph(g).expr.match(/counter\(/g).length, 1);
// A named History snapshot must precede every write, including coupled states.
g = {classnamespace: 'dsp.gen', boxes: [box('a', 'history left 0.25'), box('b', 'history right -0.25'), box('o', 'out 1'), box('p', 'out 2')], lines: [wire('a', 'b'), wire('b', 'a'), wire('a', 'o'), wire('b', 'p')]};
let expr = genGraph(g).expr;
for (const state of ['left', 'right']) assert.ok(expr.lastIndexOf(state + ' = fixdenorm(') > expr.indexOf('out2 ='));
// Generated variable names may not shadow user state.
g = {classnamespace: 'dsp.gen', boxes: [box('a', 'history fm1g0 0.25'), box('o', 'out 1')], lines: [wire('a', 'o')]};
assert.match(genGraph(g).expr, /fm1gg\d+_0 = fm1g0/);
// Memory defaults, explicit budgets and aggregate accounting.
g = {classnamespace: 'dsp.gen', boxes: [box('d', 'delay'), box('o', 'out 1')], lines: [wire('d', 'o')]};
let bounded = genGraph(g); assert.equal(bounded.memory.estimated_buffer_bytes, 16384);
assert.equal(bounded.memory.changes[0].default_delay_samples, 2048);
bounded = genGraph(g, {delayMaxSamples: 128, bufferMaxBytes: 1024});
assert.equal(bounded.memory.estimated_buffer_bytes, 1024);
assert.throws(() => genGraph(g, {delayMaxSamples: 129, bufferMaxBytes: 1024}), /buffer budget/);
g.boxes.push(box('d2', 'delay')); assert.throws(() => genGraph(g), /buffer budget/);
g = {classnamespace: 'dsp.gen', boxes: [box('d', 'data table 64 2'), box('o', 'out 1')], lines: [wire('d', 'o')]};
assert.equal(genGraph(g).memory.estimated_buffer_bytes, 1024);
g.boxes[0].box.text = 'data table 1000000'; assert.throws(() => genGraph(g), /buffer budget/);
for (const opts of [{bufferMaxBytes: 0}, {delayMaxSamples: 0}, {bufferMaxBytes: NaN}, {delayMaxSamples: 1.5}]) assert.throws(() => genGraph(graph(), opts), /memory limits/);
// Missing data/buses cannot silently compile to zeros.
g = {classnamespace: 'dsp.gen', boxes: [box('a', 'peek absent'), box('o', 'out 1')], lines: [wire('a', 'o')]};
assert.throws(() => genGraph(g), /unknown local data/);
g.boxes[0].box.text = 'receive absent'; assert.throws(() => genGraph(g), /receive has no send/);
console.log('PASS Gen constants, graph validation, constructors, feedback scheduling and bounded memory guards');
