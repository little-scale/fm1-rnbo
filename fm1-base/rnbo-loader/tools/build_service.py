#!/usr/bin/env python3
"""Local, isolated RNBO build jobs. Device uploads remain in the browser."""
import hashlib
import json
import os
from pathlib import Path
import re
import secrets
import signal
import subprocess
import sys
import threading
import time
from package import parse

APP=Path(__file__).resolve().parents[1]
MAX_SOURCE=4*1024*1024


def prepare_request(body):
    if not isinstance(body,dict) or set(body)-{'name','source','voices'}:raise ValueError('Choose a .rnbopat file and a voice count.')
    name=body.get('name');voices=body.get('voices');source=body.get('source')
    if not isinstance(name,str) or len(name)>200 or '/' in name or '\\' in name or not name.lower().endswith('.rnbopat'):raise ValueError('Choose a standalone .rnbopat file saved from inside the RNBO editor.')
    if type(voices) is not int or voices not in (1,2,4):raise ValueError('Choose Mono, 2 voices or 4 voices.')
    if not isinstance(source,str) or len(source.encode('utf-8'))>MAX_SOURCE:raise ValueError('RNBO source must be smaller than 4 MiB.')
    try:document=json.loads(source,parse_constant=lambda x:(_ for _ in ()).throw(ValueError('Non-finite JSON value')))
    except (ValueError,RecursionError) as e:raise ValueError('The RNBO file is not valid JSON.') from e
    if not isinstance(document,dict) or not isinstance(document.get('patcher'),dict):raise ValueError('This file does not contain an RNBO patcher.')
    total=0;groups=[]
    def canvas(p,depth=0):
        nonlocal total
        if depth>24 or not isinstance(p,dict) or not isinstance(p.get('boxes'),list) or not isinstance(p.get('lines'),list):raise ValueError('Invalid or excessively nested RNBO patch.')
        if depth==0 and p.get('classnamespace')!='rnbo':raise ValueError('Save the patch from inside the RNBO editor as .rnbopat, rather than saving the surrounding Max patch.')
        ids=set()
        for item in p['boxes']:
            if not isinstance(item,dict) or not isinstance(item.get('box'),dict):raise ValueError('Invalid RNBO object.')
            b=item['box'];ident=b.get('id')
            if not isinstance(ident,str) or not ident or ident in ids:raise ValueError('RNBO objects need unique IDs.')
            ids.add(ident);total+=1
            if total>2048:raise ValueError('This patch exceeds the local builder’s 2048-object limit.')
            text=b.get('text','');attrs=b.get('rnbo_extra_attributes') or {}
            if not isinstance(text,str) or not isinstance(attrs,dict):raise ValueError('Invalid RNBO object text or attributes.')
            if re.search(r'(?:^|\s)@(?:file|url)(?:\s|$)',text) or attrs.get('file') or attrs.get('url'):raise ValueError('External files are not supported yet. Embed subpatchers and generate buffer contents inside the patch.')
            classname=b.get('rnbo_classname') or text.split(' ',1)[0]
            if classname=='rnbo~':raise ValueError('Save from inside the RNBO editor, rather than the surrounding Max patch.')
            if classname in ('p','gen~') and not isinstance(b.get('patcher'),dict):raise ValueError('Embed subpatchers before building; external abstractions and Gen files are not supported yet.')
            match=re.search(r'(?:^|\s)@polyphony\s+(\d+)(?=\s|$)',text)
            count=int(match[1]) if match else attrs.get('polyphony',1)
            if classname=='p' and isinstance(count,(int,float)) and count>1:
                if depth or count not in (2,4):raise ValueError('Use one top-level embedded group with 2 or 4 voices.')
                groups.append(int(count))
            if 'patcher' in b:canvas(b['patcher'],depth+1)
        if len(p['lines'])>8192:raise ValueError('This patch has too many patch cords.')
        for item in p['lines']:
            line=item.get('patchline',{}) if isinstance(item,dict) else {}
            for key in ('source','destination'):
                end=line.get(key)
                if not isinstance(end,list) or len(end)!=2 or not isinstance(end[0],str) or end[0] not in ids or type(end[1]) is not int or end[1]<0:raise ValueError('A patch cord has an invalid endpoint.')
    canvas(document['patcher'])
    if len(groups)>1:raise ValueError('Use one embedded polyphonic group for a shared master effect.')
    if groups and voices!=groups[0]:raise ValueError(f'The embedded synth uses {groups[0]} voices. Select that voice count, or edit its polyphony in RNBO.')
    stem=re.sub('[^A-Za-z0-9_-]','_',name[:-8])[:24]
    if not stem or not stem[0].isalpha():stem=('patch_'+stem)[:24]
    config={'voices':voices,'fast_phase':True,'shared_fx':bool(groups),'float32_delays':True,'pool_bytes':114688}
    return stem,json.dumps(document,ensure_ascii=False,allow_nan=False),config


def friendly_error(log):
    lower=log.lower()
    if 'operation not permitted' in lower or 'permission denied' in lower:
        return 'The local tools could not be accessed. Open Open-Build-Uploader.command from your normal Terminal and retry. Details are in the build log.'
    if 'docker' in lower and any(x in lower for x in ('cannot','failed','connect','not found')):
        return 'Docker is not available. Start Docker Desktop, reopen the uploader launcher and retry.'
    if 'pool exhausted' in lower or 'pool request too large' in lower or 'overflowed' in lower:
        return 'The patch exceeds its memory budget. Reduce voices or buffer/delay sizes; see the build log.'
    if 'initialization/channel/parameter' in lower:
        return 'Patch initialization failed. Use no audio inputs, exactly out~ 1 and out~ 2, and at most 16 parameters. Also check buffer sizes.'
    lines=[x.strip() for x in log.splitlines() if x.strip()]
    errors=[x for x in lines if any(t in x.lower() for t in ('error:', 'error(', 'cannot parse','unsupported','failed:'))]
    return (errors[-1] if errors else 'The patch did not pass the build checks. See the build log below.')[:500]


class BuildService:
    def __init__(self,root=None,runner=None):
        self.root=Path(root or APP/'build/browser-jobs');self.root.mkdir(parents=True,exist_ok=True)
        self.token=secrets.token_urlsafe(32);self.lock=threading.Lock();self.jobs={};self.active=None
        self.runner=runner or self._compile;self.stopping=threading.Event()

    def start(self,body):
        name,source,config=prepare_request(body)
        with self.lock:
            if self.active:raise BlockingIOError('A build is already running. Wait for it to finish.')
            ident=secrets.token_hex(12);folder=self.root/ident;folder.mkdir()
            path=folder/(name+'.rnbopat');path.write_text(source)
            module=folder/'module';module.mkdir();(module/'module.json').write_text(json.dumps(config,indent=2)+'\n')
            job={'id':ident,'name':name,'state':'running','error':None,'folder':folder,'source':path,'module':module,'config':config}
            self.jobs[ident]=job;self.active=ident
            while len(self.jobs)>20:self.jobs.pop(next(iter(self.jobs)))
        threading.Thread(target=self._work,args=(job,),daemon=True).start()
        return ident

    def _compile(self,job):
        log=job['folder']/'build.log'
        with log.open('w') as stream:
            proc=subprocess.Popen([sys.executable,'-u',str(APP/'tools/build.py'),'--patch',str(job['source']),'--module-dir',str(job['module'])],cwd=APP.parent,stdout=stream,stderr=subprocess.STDOUT,start_new_session=True)
            deadline=time.monotonic()+300
            while proc.poll() is None:
                if self.stopping.wait(.2) or time.monotonic()>deadline:
                    os.killpg(proc.pid,signal.SIGKILL);proc.wait()
                    stream.write('\nBuild stopped or exceeded the five-minute time limit.\n');return False
            return proc.returncode==0

    def _work(self,job):
        try:
            if not self.runner(job):raise RuntimeError(friendly_error(self.log(job)))
            package=job['module']/'build'/(job['name']+'.rnbom');data=package.read_bytes();meta=parse(data)
            review=json.loads((package.parent/'review.json').read_text())
            provenance=json.loads((job['module']/'export/provenance.json').read_text())
            status=json.loads((package.parent/'device-build-status.json').read_text())
            if not status.get('success') or status.get('host') or not status.get('stages',{}).get(job['name'],{}).get('passed'):raise RuntimeError('The FM1 target build did not complete successfully.')
            expected=hashlib.sha256(job['source'].read_bytes()).hexdigest()
            if provenance.get('input_sha256')!=expected or any(provenance.get(k)!=job['config'][k] for k in ('voices','fast_phase','shared_fx')):raise RuntimeError('The build does not match the selected RNBO source and voice settings.')
            if meta['title']!=job['name'].upper():raise RuntimeError('The built patch has an unexpected title.')
            if review.get('sha256')!=hashlib.sha256(data).hexdigest() or any(review.get(k)!=v for k,v in meta.items()):raise RuntimeError('The compiled module did not match its reviewed package.')
            if review.get('undefined_symbols')!=[] or not review.get('constructors') or not review.get('fast_phase') or not review.get('float_to_int64_helpers_rejected'):raise RuntimeError('The module did not pass its native build review.')
            with self.lock:job.update(state='succeeded',package=package,meta=meta,sha256=review['sha256'])
        except Exception as e:
            with self.lock:job.update(state='failed',error=str(e))
        finally:
            with self.lock:self.active=None

    @staticmethod
    def log(job):
        path=job['folder']/'build.log'
        if not path.exists():return ''
        with path.open('rb') as f:
            f.seek(max(0,path.stat().st_size-16000));return f.read().decode('utf-8',errors='replace')

    def snapshot(self,ident):
        with self.lock:
            if ident not in self.jobs:raise KeyError(ident)
            job=dict(self.jobs[ident])
        log=self.log(job);stages=re.findall(r'^FM1_STAGE ([a-z]+)$',log,re.M)
        return {k:job.get(k) for k in ('id','name','state','error','meta','sha256')}|{'stage':stages[-1] if stages else 'exporting','log':log,'voices':job['config']['voices']}

    def download(self,ident):
        with self.lock:
            job=self.jobs.get(ident)
            if not job or job['state']!='succeeded':raise KeyError(ident)
            path=job['package'];sha=job['sha256']
        data=path.read_bytes()
        if hashlib.sha256(data).hexdigest()!=sha:raise ValueError('The built package changed; rebuild the patch.')
        parse(data);return data
