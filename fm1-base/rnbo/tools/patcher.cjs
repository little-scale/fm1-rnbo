// SPDX-License-Identifier: MIT
// Max-saved RNBO UI objects and compact compiler graphs share this preparation.
const {genGraph}=require('./gen-graph.cjs');
function compilerPatch(p){
  const copy=JSON.parse(JSON.stringify(p));
  function visit(canvas){for(const {box} of canvas.boxes){
    if(box.patcher?.classnamespace==='dsp.gen')delete box.patcher;
    else if(box.patcher)visit(box.patcher);
  }}
  visit(copy);return copy;
}
function describePatch(p, xam, runner, prefix='', genOptions={}, genMemory=[]) {
  for (const [index, {box}] of p.boxes.entries()) {
    if (box.maxclass==='comment' || box.maxclass==='panel') continue;
    // The runner interprets UI message text as a payload, whereas the compact
    // source format uses an explicit message operator. Normalize it once.
    if (box.maxclass==='message') {
      box.text='message @text '+(box.text || '');
      box.maxclass='newobj';
    }
    box.text ||= box.rnbo_classname || box.rnboinfo?.classname || box.maxclass;
    const spec=xam.parseBoxText(box.text);
    if (!spec) throw Error(`Cannot parse RNBO object: ${box.text}`);
    xam.parseExtraAttributes(spec.xamclass,box.rnbo_extra_attributes,spec.attributes);
    box.rnbo_uniqueid ||= spec.xamclass+'_'+box.id;
    if (box.rnbo_serial===undefined) box.rnbo_serial=index;
    if (box.patcher) {
      if (box.patcher.classnamespace==='dsp.gen') {
        if(spec.xamclass!=='gen~') throw Error('Gen graph must belong to gen~');
        const {memory,...attributes}=genGraph(box.patcher,genOptions);
        genMemory.push({object:prefix+box.id,...memory});
        Object.assign(spec.attributes,attributes);
        box.rnbo_extra_attributes={...box.rnbo_extra_attributes,...attributes};
        box.rnboinfo=xam.getObjectDescription(xam.createObject(spec.xamclass,spec.attributes));
        continue;
      }
      describePatch(box.patcher,xam,runner,prefix+box.rnbo_uniqueid+'/',genOptions,genMemory);
      // The runner normalizes UI text in-place, so describe the subpatch on a
      // copy and keep the editable graph stable for the real invocation.
      spec.attributes.objects=runner.getXAMObjectsFromPatcher(compilerPatch(box.patcher),prefix+box.rnbo_uniqueid+'/',[],new runner.XAMIDStack());
    }
    box.rnboinfo=xam.getObjectDescription(xam.createObject(spec.xamclass,spec.attributes));
  }
  return genMemory;
}
module.exports={describePatch,compilerPatch};
