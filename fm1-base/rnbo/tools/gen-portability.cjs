// SPDX-License-Identifier: MIT
// Repair specific RNBO 1.4.4 Gen export omissions in the generated copy only.
function genPortability(source, fastPhase) {
  const changes = [];
  let code = source;
  if (fastPhase && code.includes('#define trunc(x) ((Int)(x))')) {
    if (code.split('#define trunc(x) ((Int)(x))').length !== 2) throw Error('Review generated trunc macro');
    code = code.replace('#define trunc(x) ((Int)(x))', '#define trunc(x) fm1_float_to_int64(x)');
    changes.push('portable binary32 truncation');
  }
  let modulo = false, mstosamps = false;
  code = code.replace(/^void (gen_\w+_perform)\([^)]*\)\s*\{.*?^\}/gms, body => {
    // Unqualified sqrt from Gen hypot bypasses RNBO's float overloads.
    if (/(?<![\w:>])sqrt\(/.test(body)) {
      body = body.replace(/(?<![\w:>])sqrt\(/g, 'rnbo_sqrt(');
      changes.push('Gen sqrt uses float overload');
    }
    if (/(?<![\w:>])safemod\(/.test(body)) {
      modulo = true; body = body.replace(/(?<![\w:>])safemod\(/g, 'fm1_gen_modulo(');
    }
    if (body.includes('this->mstosamps(')) {
      mstosamps = true; body = body.replaceAll('this->mstosamps(', 'fm1_gen_mstosamps(');
    }
    return body;
  });
  let helpers = '';
  if (modulo) {
    helpers += 'inline number fm1_gen_modulo(number value, number divisor) { return divisor == 0 ? 0 : ::fmodf(value, divisor); }\n';
    changes.push('Gen modulo helper, zero divisor returns zero');
  }
  if (mstosamps) {
    // Fixed sample rate is part of the module ABI. Scheduler methods retain
    // their original MillisecondTime precision.
    helpers += 'inline number fm1_gen_mstosamps(number ms) { return ms * number(44100) * number(0.001); }\n';
    changes.push('Gen sample conversion uses float32 at fixed 44100 Hz');
  }
  if (helpers) {
    if (code.split('#define autoref auto&').length !== 2) throw Error('Review Gen helper insertion point');
    code = code.replace('#define autoref auto&', '#define autoref auto&\n' + helpers);
  }
  return {code, changes};
}
module.exports = {genPortability};
