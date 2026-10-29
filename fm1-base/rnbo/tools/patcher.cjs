// SPDX-License-Identifier: MIT
// Max-saved RNBO UI objects and compact compiler graphs share this preparation.
function describePatch(p, xam, runner, prefix='') {
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
      if (box.patcher.classnamespace==='dsp.gen') throw Error('Embedded Gen patches need additional export handling; use RNBO objects for this build.');
      describePatch(box.patcher,xam,runner,prefix+box.rnbo_uniqueid+'/');
      // The runner normalizes UI text in-place, so describe the subpatch on a
      // copy and keep the editable graph stable for the real invocation.
      spec.attributes.objects=runner.getXAMObjectsFromPatcher(JSON.parse(JSON.stringify(box.patcher)),prefix+box.rnbo_uniqueid+'/',[],new runner.XAMIDStack());
    }
    box.rnboinfo=xam.getObjectDescription(xam.createObject(spec.xamclass,spec.attributes));
  }
}
module.exports={describePatch};
