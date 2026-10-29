// Serialize the compiler's compact patch graph as an editable Max document.
// Keep RNBO unique IDs and DSP data unchanged; Max box IDs are local to a canvas.
function prepareMaxPatch(document, xam, version) {
  const result = JSON.parse(JSON.stringify(document));
  function canvas(p, rnbo = false) {
    p.classnamespace = rnbo ? 'rnbo' : 'box';
    p.appversion ||= result.patcher.appversion;
    p.default_fontname = 'Arial';
    p.default_fontsize = 12;
    const ids = new Map(p.boxes.map(({box}, i) => [box.id, `obj-${i + 1}`]));
    for (const {box: b} of p.boxes) {
      b.id = ids.get(b.id);
      if (rnbo && b.maxclass !== 'comment' && b.maxclass !== 'panel') {
        const spec = xam.parseBoxText(b.text);
        const info = b.rnboinfo;
        if (!spec || !info) throw Error(`Missing RNBO description for ${b.text}`);
        b.rnbo_classname = info.classname;
        b.numinlets = info.inputs.length;
        b.numoutlets = info.outputs.length;
        b.outlettype = info.outputs.map(o => o.type === 'signal' ? 'signal' : '');
        const {defaultArgs, classname, objects, ...attributes} = spec.attributes;
        b.rnbo_extra_attributes = attributes;
        if (info.classname === 'message') {
          // RNBO's compiler representation uses "message @text ..."; Max
          // saves the same object as a message UI box containing just the list.
          b.maxclass = 'message';
          b.text = [].concat(attributes.text || []).join(' ');
          b.rnbo_extra_attributes = {text: '', storeempty: 0};
        }
        if (b.patcher) canvas(b.patcher, true);
      } else if (b.patcher && b.text.startsWith('rnbo~')) {
        delete b.rnbo_classname;
        delete b.rnbo_serial;
        delete b.rnbo_savetocoll;
        b.numinlets = 1;
        b.numoutlets = 3;
        b.outlettype = ['signal', 'signal', 'list'];
        b.inletInfo = {IOInfo: []};
        b.outletInfo = {IOInfo: [1, 2].map(index => ({type: 'signal', index, tag: '', comment: ''}))};
        b.rnboversion = version;
        b.rnboattrcache = {};
        b.saved_object_attributes = {optimization: 'O1', parameter_enable: 0};
        canvas(b.patcher, true);
      } else if (b.text === 'ezdac~') {
        b.maxclass = 'ezdac~';
        delete b.text;
        b.numinlets = 2;
        b.numoutlets = 0;
        b.patching_rect[2] = b.patching_rect[3] = 45;
      } else {
        b.numinlets = b.text === 'midiin' ? 0 : (b.maxclass === 'message' ? 2 : 1);
        b.numoutlets = ['comment','panel'].includes(b.maxclass) ? 0 : 1;
        b.outlettype = Array(b.numoutlets).fill(b.text === 'midiin' ? 'int' : '');
      }
    }
    for (const {patchline: line} of p.lines) {
      line.source[0] = ids.get(line.source[0]);
      line.destination[0] = ids.get(line.destination[0]);
      if (!line.source[0] || !line.destination[0]) throw Error('Unknown patch cord endpoint');
    }
  }
  canvas(result.patcher);
  return result;
}
module.exports = {prepareMaxPatch};
