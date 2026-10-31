"""Layout source fidelity, nested patch handling, limits and package roundtrip."""
import copy
import json
from pathlib import Path
import random
import struct
import sys
import tempfile
APP=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(APP/'tools'))
from layout import compile_layout,append_layout,NODE_GEN
from package import create,parse,TEXT
source=APP/'patches/saw_cutoff_delay.rnbopat'
before=source.read_bytes()
# Layout needs parameter identities, not a generated RNBO export. Keep this
# regression runnable in a clean source folder without RNBO or a compiler.
def description(path):
    boxes=json.loads(path.read_text())['patcher']['boxes']
    params=[]
    for item in boxes:
        words=item['box'].get('text','').split()
        if len(words)>1 and words[0]=='param':
            params.append({'name':words[1]})
    return {'parameters':params}
desc=description(source)
data,report=compile_layout(source,desc)
assert report['available'] and len(report['nodes'])==22 and len(report['segments'])==23
assert source.read_bytes()==before
nodes={n[8]:n for n in report['nodes']}
assert nodes['saw~'][1]<nodes['lores~'][1]<nodes['delay~'][1]
assert {n[4] for n in report['nodes'] if n[4]!=255}==set(range(8))
assert 'MIDI > Hz' in nodes and 'Cutoff' in nodes and '@' not in ''.join(nodes)
assert all(n[7]==0 for n in report['nodes'])
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
    assert nested['nodes'][0][7]==0
    patch['patcher']['boxes']*=97;path.write_text(json.dumps(patch))
    assert compile_layout(path,desc)[0] is None
    # Gen identity must survive serialization, including GenExpr-only boxes.
    # RNBO codebox and RNBO subpatches stay RNBO even if they contain Gen.
    patch={'patcher':{'classnamespace':'rnbo','boxes':[
        {'box':{'id':'g','text':'gen~','patcher':{'classnamespace':'dsp.gen','boxes':[],'lines':[]},'patching_rect':[0,0,40,20]}},
        {'box':{'id':'expr','rnbo_classname':'gen~','rnbo_extra_attributes':{'expr':'out1=in1;'},'patching_rect':[100,0,40,20]}},
        {'box':{'id':'code','maxclass':'codebox~','code':'out1=in1;','patcher':None,'patching_rect':[0,100,40,20]}},
        {'box':{'id':'p','text':'p voice','patcher':{'classnamespace':'rnbo','boxes':[],'lines':[]},'patching_rect':[100,100,40,20]}}
    ],'lines':[]}}
    path.write_text(json.dumps(patch));data,coloured=compile_layout(path,{'parameters':[]})
    assert [n[7] for n in coloured['nodes']]==[NODE_GEN,NODE_GEN,0,0]
    assert [n[8] for n in coloured['nodes']]==['gen~','gen~','codebox~','Subpatch']
    assert [data[16+24*i+7] for i in range(4)]==[NODE_GEN,NODE_GEN,0,0]
    assert parse(create(append_layout(bytes(image),data,TEXT+84),98304,123))['image_bytes']==1024+len(data)+16
    patch['patcher']={'classnamespace':'dsp.gen','boxes':[
        {'box':{'id':'history','text':'history previous 0','patching_rect':[0,0,40,20]}},
        {'box':{'id':'code','maxclass':'codebox','code':'out1=in1;','patching_rect':[100,0,40,20]}},
        {'box':{'id':'nested','text':'gen','patcher':{'classnamespace':'dsp.gen','boxes':[],'lines':[]},'patching_rect':[0,100,40,20]}}
    ],'lines':[]}
    path.write_text(json.dumps(patch));data,coloured=compile_layout(path,{'parameters':[]})
    assert all(n[7]==NODE_GEN for n in coloured['nodes'])
    assert [n[8] for n in coloured['nodes']]==['history','codebox','gen']
    # Crowded source anchors previously exhausted the right/down-only pass,
    # although enough screen area remained for every label and connection.
    rng=random.Random(22)
    patch={'patcher':{'boxes':[
        {'box':{'id':str(i),'text':'object'+str(i),'patching_rect':[rng.randrange(600),rng.randrange(1000),60,20]}}
        for i in range(58)],'lines':[
        {'patchline':{'source':[str(i),0],'destination':['57',0]}}
        for i in range(4)]}}
    path.write_text(json.dumps(patch));before=path.read_bytes()
    data,crowded=compile_layout(path,{'parameters':[]})
    assert crowded['available'] and crowded['placement']=='expanded placement'
    assert len(crowded['nodes'])==58 and len(crowded['segments'])==4
    assert compile_layout(path,{'parameters':[]})==(data,crowded)
    assert path.read_bytes()==before
    for i,a in enumerate(crowded['nodes']):
        assert 0<=a[0] and a[0]+a[2]<=240 and 0<=a[1] and a[1]+a[3]<=166
        for b in crowded['nodes'][i+1:]:
            assert a[0]+a[2]<b[0] or b[0]+b[2]<a[0] or a[1]+a[3]<b[1] or b[1]+b[3]<a[1]
    assert parse(create(append_layout(bytes(image),data,TEXT+84),98304,123))
    patch['patcher']['lines']*=97;path.write_text(json.dumps(patch))
    assert compile_layout(path,{'parameters':[]})[1]['reason']=='More than 384 wire segments'
    patch['patcher']={'boxes':[{'box':{'id':'blank','text':'  ','maxclass':'number'}}],'lines':[]}
    path.write_text(json.dumps(patch))
    assert compile_layout(path,{'parameters':[]})[1]['nodes'][0][8]=='number'
    # Optional user fixtures run through the same serialized/package checks.
    for fixture in map(Path,sys.argv[1:]):
        before=fixture.read_bytes();data,report=compile_layout(fixture,description(fixture))
        assert report['available'],report
        assert compile_layout(fixture,description(fixture))==(data,report)
        assert fixture.read_bytes()==before
        for i,a in enumerate(report['nodes']):
            assert 0<=a[0] and a[0]+a[2]<=240 and 0<=a[1] and a[1]+a[3]<=166
            for b in report['nodes'][i+1:]:
                assert a[0]+a[2]<b[0] or b[0]+b[2]<a[0] or a[1]+a[3]<b[1] or b[1]+b[3]<a[1]
        assert parse(create(append_layout(bytes(image),data,TEXT+84),98304,123))
        print(f'PASS {fixture.name}: {len(report["nodes"])} objects, {len(report["segments"])} segments, {len(data)} bytes')
print('PASS source fidelity, parameter bindings, Gen/RNBO classification, nested boxes, crowded placement, bounded fallback and package compatibility')
