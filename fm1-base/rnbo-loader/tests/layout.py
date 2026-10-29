"""Layout source fidelity, nested patch handling, limits and package roundtrip."""
import copy
import json
from pathlib import Path
import struct
import sys
import tempfile
APP=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(APP/'tools'))
from layout import compile_layout,append_layout
from package import create,parse,TEXT
source=APP/'patches/saw_cutoff_delay.rnbopat'
before=source.read_bytes()
desc=json.loads((APP/'modules/saw_cutoff_delay/export/description.json').read_text())
data,report=compile_layout(source,desc)
assert report['available'] and len(report['nodes'])==22 and len(report['segments'])==23
assert source.read_bytes()==before
nodes={n[8]:n for n in report['nodes']}
assert nodes['saw~'][1]<nodes['lores~'][1]<nodes['delay~'][1]
assert {n[4] for n in report['nodes'] if n[4]!=255}==set(range(8))
assert 'MIDI > Hz' in nodes and 'Cutoff' in nodes and '@' not in ''.join(nodes)
assert all(0<=n[0] and n[0]+n[2]<=240 and 0<=n[1] and n[1]+n[3]<=166 for n in report['nodes'])
for i,a in enumerate(report['nodes']):
    for b in report['nodes'][i+1:]:
        assert a[0]+a[2]<=b[0] or b[0]+b[2]<=a[0] or a[1]+a[3]<=b[1] or b[1]+b[3]<=a[1]
image=bytearray(1024);struct.pack_into('<4I',image,0,0x31495041,1,84,123)
struct.pack_into('<9I',image,48,*([TEXT+84]*9))
package=create(append_layout(bytes(image),data,TEXT+84),98304,123)
assert parse(package)['image_bytes']==len(package)-64
assert parse(create(bytes(image),98304,123))['image_bytes']==1024
for fn in [TEXT+83,TEXT+len(image),TEXT+85]:
    try:create(append_layout(bytes(image),data,fn),98304,123)
    except ValueError:pass
    else:raise AssertionError('Invalid callback accepted')
with tempfile.TemporaryDirectory() as directory:
    path=Path(directory)/'nested.rnbopat'
    patch={'patcher':{'boxes':[{'box':{'id':'sub','text':'p inside','patcher':json.loads(before)['patcher'],'patching_rect':[0,0,40,20]}}],'lines':[]}}
    path.write_text(json.dumps(patch));_,nested=compile_layout(path,{'parameters':[]})
    assert len(nested['nodes'])==1 and nested['nodes'][0][8]=='Subpatch'
    patch['patcher']['boxes']*=97;path.write_text(json.dumps(patch))
    assert compile_layout(path,desc)[0] is None
print('PASS original coordinates/connections, all eight bindings, compact labels, nested boxes, bounded fallback and package compatibility')
