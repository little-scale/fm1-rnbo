// RNBO emits static constexpr references to string literals without separate
// definitions. JieLi's Clang 4 emits unresolved references for those members.
// Ordinary immutable pointer members avoid that requirement in C++11. They
// are initialized with the explicitly constructed patch and allocate no heap.
function cpp11Strings(source){
  let count=0;
  const code=source.replace(/^([ \t]*)static constexpr auto& ((?:name|file|tag)\d+) = ("(?:\\.|[^"\\])*");[ \t]*$/gm,
    (_,indent,name,literal)=>{++count;return `${indent}const char * const ${name} = ${literal};`;});
  return {code,count};
}
module.exports={cpp11Strings};
