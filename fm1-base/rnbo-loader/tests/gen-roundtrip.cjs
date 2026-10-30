// SPDX-License-Identifier: MIT
const assert = require('node:assert/strict');
const path = require('node:path');
const pkg = process.env.RNBO_DIR || path.join(process.env.HOME, 'Documents/Max 9/Packages/RNBO');
process.env.RNBO_DIR = pkg;
process.env.BABEL_DISABLE_CACHE = '1';
const xam = require(path.join(pkg, 'server/node_modules/@rnbo/xam'));
const runner = require(path.join(pkg, 'server/node_modules/@rnbo/xam-runner'));
const {describePatch, compilerPatch} = require('../../rnbo/tools/patcher.cjs');
const {prepareMaxPatch} = require('../../rnbo/tools/maxpat.cjs');
const child = {classnamespace: 'dsp.gen', boxes: [{box: {id: 'v', maxclass: 'newobj', text: 'constant 0.25'}}, {box: {id: 'out', maxclass: 'newobj', text: 'out 1'}}], lines: [{patchline: {source: ['v', 0], destination: ['out', 0]}}]};
const p = {classnamespace: 'rnbo', boxes: [
  {box: {id: 'visual', text: 'gen~', maxclass: 'newobj', patcher: child}},
  {box: {id: 'code', text: 'gen~', maxclass: 'newobj', rnbo_extra_attributes: {expr: 'out1=0.5;', geninlets: 0, genoutlets: 1}}}
], lines: []};
const memory = describePatch(p, xam, runner);
assert.equal(memory.length, 1);assert.equal(memory[0].estimated_buffer_bytes, 0);
assert.equal(p.boxes[0].box.rnbo_extra_attributes.memory, undefined);
assert.equal(compilerPatch(p).boxes[0].box.patcher, undefined);
assert.equal(p.boxes[0].box.patcher.classnamespace, 'dsp.gen');
const doc = {patcher: {boxes: [{box: {id: 'r', text: 'rnbo~', maxclass: 'newobj', patcher: p}}], lines: []}};
const saved = prepareMaxPatch(doc, xam, '1.4.4').patcher.boxes[0].box.patcher;
assert.equal(saved.boxes[0].box.patcher.classnamespace, 'dsp.gen');
assert.equal(saved.boxes[0].box.rnbo_extra_attributes.expr, undefined);
assert.equal(saved.boxes[1].box.rnbo_extra_attributes.expr, 'out1=0.5;');
assert.equal(saved.boxes[1].box.rnbo_extra_attributes.genoutlets, 1);
console.log('PASS editable visual Gen, preserved GenExpr, compiler copies and memory provenance');
