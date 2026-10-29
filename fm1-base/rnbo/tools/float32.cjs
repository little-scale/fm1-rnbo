// Preserve comments/strings and explicit numeric suffixes. RNBO 1.4.4 emits
// unsuffixed decimal literals which promote float DSP expressions to double.
// This adaptation changes literal types; explicit MillisecondTime stays double.
const token=/\/\*[\s\S]*?\*\/|\/\/[^\n]*|"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|\b0[xX][0-9a-fA-F]+[uUlL]*|(?<![\w.])(?:(?:\d+\.\d*|\.\d+)(?:[eE][+-]?\d+)?|\d+[eE][+-]?\d+)[fFlL]?(?![\w.])/g;
function float32(source){
  let count=0;
  const code=source.replace(token,t=>{
    if(!/^(?:\d|\.\d)/.test(t) || /^0[xX]/.test(t) || /[fFlL]$/.test(t))return t;
    ++count;return t+'f';
  });
  return {code,count};
}
module.exports={float32};
