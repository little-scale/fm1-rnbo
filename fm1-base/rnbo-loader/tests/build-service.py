"""Test real HTTP boundaries and job orchestration; fake only native compilation."""
import hashlib
import json
from pathlib import Path
import shutil
import struct
import sys
import tempfile
import threading
import time
from urllib.request import Request,urlopen
from urllib.error import HTTPError
APP=Path(__file__).resolve().parents[1];sys.path.insert(0,str(APP/'tools'))
from build_service import BuildService,prepare_request
from serve import make_server
from package import create,parse,TEXT
source=(APP/'patches/fm4echo.rnbopat').read_text()
request={'name':'fm4echo.rnbopat','source':source,'voices':4}
name,normalized,config=prepare_request(request);assert name=='fm4echo' and config['shared_fx'] and config['voices']==4
assert 'filter_delay_max_ms' not in config
assert prepare_request(request|{'filter_delay_max_ms':40})[2]['filter_delay_max_ms']==40
for maximum in (0,-1,1001,True,'40',None,float('nan'),float('inf'),1<<2000):
    try:prepare_request(request|{'filter_delay_max_ms':maximum});raise AssertionError(maximum)
    except ValueError:pass
for change in [{'name':'../oops.rnbopat'},{'name':'x.maxpat'},{'voices':True},{'voices':3},{'voices':2},{'source':'[]'},{'source':'{"patcher":{}}'}]:
    try:prepare_request(request|change);raise AssertionError(change)
    except ValueError:pass
# Max-saved UI messages are accepted by input validation.
ui=json.loads((APP/'modules/fm4echo/fm4echo.maxpat').read_text())
rnbo=next(v['box']['patcher'] for v in ui['patcher']['boxes'] if v['box'].get('patcher'))
assert prepare_request(request|{'source':json.dumps({'patcher':rnbo})})[2]['shared_fx']
external=json.loads(source);external['patcher']['boxes'][0]['box']['text']+=' @file /etc/passwd'
try:prepare_request(request|{'source':json.dumps(external)});raise AssertionError('external file accepted')
except ValueError:pass

# Code-only GenExpr is self-contained; absent expressions and invalid port
# metadata remain rejected before starting a compiler job.
gen=json.loads((APP/'tests/compatibility/patches/gen_expr.rnbopat').read_text())
assert prepare_request({'name':'gen.rnbopat','source':json.dumps(gen),'voices':1})[0]=='gen'
genbox=next(v['box'] for v in gen['patcher']['boxes'] if v['box']['text']=='gen~')
for bad in [{'expr':''},{'geninlets':True},{'genoutlets':0}]:
    previous=dict(genbox['rnbo_extra_attributes']);genbox['rnbo_extra_attributes'].update(bad)
    try:prepare_request({'name':'gen.rnbopat','source':json.dumps(gen),'voices':1});raise AssertionError(bad)
    except ValueError:pass
    genbox['rnbo_extra_attributes']=previous

entered=threading.Event();release=threading.Event();fail=[False];stale=[False];wrong_cap=[False]
def compiler(job):
    entered.set();release.wait(5)
    (job['folder']/'build.log').write_text('FM1_STAGE exporting\nFM1_STAGE target\n')
    if fail[0]:return False
    out=job['module']/'build';out.mkdir();export=job['module']/'export';export.mkdir()
    image=bytearray(1024);struct.pack_into('<4I',image,0,0x31495041,2,84,123)
    image[16:24]=b'FM4ECHO\0';struct.pack_into('<9I',image,48,*([TEXT+84]*9))
    data=create(image,140000,123);(out/'fm4echo.rnbom').write_bytes(data)
    review={**parse(data),'sha256':hashlib.sha256(data).hexdigest(),'constructors':[hex(TEXT+84)],'undefined_symbols':[],'fast_phase':True,'float_to_int64_helpers_rejected':True}
    (out/'review.json').write_text(json.dumps(review))
    (out/'device-build-status.json').write_text(json.dumps({'success':True,'host':False,'stages':{'fm4echo':{'passed':True}}}))
    (export/'provenance.json').write_text(json.dumps({'input_sha256':'stale' if stale[0] else hashlib.sha256(job['source'].read_bytes()).hexdigest(),'filter_delay_max_ms':999 if wrong_cap[0] else job['config'].get('filter_delay_max_ms'),**{k:job['config'][k] for k in ('voices','fast_phase','shared_fx')}}))
    return True

with tempfile.TemporaryDirectory(prefix='fm1-builder-test-') as tmp:
    service=BuildService(tmp,runner=compiler);server=make_server(0,service);thread=threading.Thread(target=server.serve_forever,daemon=True);thread.start()
    origin=f'http://127.0.0.1:{server.server_port}'
    def call(path,body=None,token=True,site=None,host=None):
        headers={}
        if token:headers['X-FM1-Token']=service.token
        if body is not None:headers.update({'Content-Type':'application/json','Origin':site or origin})
        if host:headers['Host']=host
        req=Request(origin+path,data=json.dumps(body).encode() if body is not None else None,headers=headers)
        try:
            with urlopen(req,timeout=3) as r:return r.status,r.read()
        except HTTPError as e:return e.code,e.read()
    assert json.loads(call('/api/session',token=False)[1])['version']==2
    assert call('/api/session',host='attacker.example')[0]==403
    assert call('/api/build',request,token=False)[0]==403
    assert call('/api/build',request,site='https://attacker.example')[0]==403
    assert call('/api/jobs/missing',token=False)[0]==403
    assert call('/../../setup/env.sh')[0]==404
    assert call('/api/jobs/missing')[0]==404
    assert call('/api/build',request|{'voices':8})[0]==400
    code,raw=call('/api/build',request|{'filter_delay_max_ms':40});assert code==202;ident=json.loads(raw)['id'];assert entered.wait(2)
    assert json.loads((service.jobs[ident]['module']/'module.json').read_text())['filter_delay_max_ms']==40
    assert call('/api/build',request)[0]==409
    assert call('/api/jobs/'+ident+'/module')[0]==404
    release.set()
    def completed(ident):
        for _ in range(200):
            job=json.loads(call('/api/jobs/'+ident)[1])
            if job['state']!='running':return job
            time.sleep(.01)
        raise AssertionError('worker did not finish')
    job=completed(ident);assert job['state']=='succeeded',job
    code,data=call('/api/jobs/'+ident+'/module');assert code==200 and hashlib.sha256(data).hexdigest()==job['sha256']
    # Editing a previously approved artifact invalidates download.
    package=service.jobs[ident]['package'];package.write_bytes(data[:-1]+bytes([data[-1]^1]));assert call('/api/jobs/'+ident+'/module')[0]==409
    fail[0]=True;code,raw=call('/api/build',request);failed=completed(json.loads(raw)['id']);assert failed['state']=='failed'
    assert call('/api/jobs/'+failed['id']+'/module')[0]==404
    fail[0]=False;stale[0]=True;code,raw=call('/api/build',request);bad=completed(json.loads(raw)['id']);assert bad['state']=='failed' and 'selected RNBO source' in bad['error']
    assert call('/api/jobs/'+bad['id']+'/module')[0]==404
    stale[0]=False;wrong_cap[0]=True
    code,raw=call('/api/build',request|{'filter_delay_max_ms':40});badcap=completed(json.loads(raw)['id'])
    assert badcap['state']=='failed' and 'filter delay maximum' in badcap['error']
    assert call('/api/jobs/'+badcap['id']+'/module')[0]==404
    server.shutdown();server.server_close();thread.join()
print('PASS build service: request validation, Max source, origin/host/token boundaries, isolated jobs, single build, progress, reviewed downloads, failure and stale artifact refusal')

# A source converter must serve its current UI over an older release's web
# assets, while keeping that release's firmware/library files available.
from launch import compatible
with tempfile.TemporaryDirectory(prefix='fm1-old-release-test-') as tmp:
    root=Path(tmp);(root/'web').mkdir()
    for filename in ('module-loader.html','module-loader.js','studio.js'):
        (root/'web'/filename).write_text('old release UI')
    (root/'web/release.json').write_text('{"format":1}')
    service=BuildService(root/'jobs',runner=compiler)
    server=make_server(0,service,web_root=root/'web')
    thread=threading.Thread(target=server.serve_forever,daemon=True);thread.start()
    origin=f'http://127.0.0.1:{server.server_port}'
    try:
        with urlopen(origin+'/module-loader.html') as r:assert b'filter-cap' in r.read()
        with urlopen(origin+'/module-loader.js') as r:assert b'filterDelayOptions' in r.read()
        with urlopen(origin+'/release.json') as r:assert json.load(r)=={'format':1}
        with urlopen(origin+'/api/session') as r:info=json.load(r)
        assert compatible(info,server.root_id,True)
        old=info|{'build_options':[]}
        assert not compatible(old,server.root_id,True)
        assert compatible(old,server.root_id,False)
    finally:
        server.shutdown();server.server_close();thread.join()
print('PASS builder capability detection and current converter UI over older release assets')
