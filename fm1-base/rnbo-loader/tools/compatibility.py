#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Generate and compile an isolated RNBO/FM1 compatibility matrix. Never uploads."""
import argparse,collections,concurrent.futures,datetime,fnmatch,hashlib,json,os,re,shutil,signal,subprocess,sys,threading,time
from pathlib import Path

DEFAULT_APP=Path(__file__).resolve().parents[1]
SUPPORT=DEFAULT_APP/'tests/compatibility'
sys.path.insert(0,str(SUPPORT))
from fixtures import make_cases,slug,validate
STOP=threading.Event()

EXCLUSIONS={
    'external_files':'No sample files, external abstractions or external Gen files are loaded by this suite.',
    'host_services':'No file, network, GUI, display, recording or OS service is emulated as a supported device service.',
    'external_messages':'The current player has no public arbitrary inport/outport message API; internal send/receive is a separate test.',
    'audio_input':'The current bridge requires zero audio inputs and exactly two outputs; rejection is explicitly tested.',
    'physical_midi_output':'The suite sends MIDI into compiled modules; it does not claim physical outgoing MIDI support.',
    'hardware':'No firmware is installed and no patch is uploaded. Host CPU measurements are not device CPU measurements.',
    'embedded_gen':'Embedded Gen has a catalogue-based translator and bounded visual Data/Delay allocation. See GEN-SUPPORT.md for tested operators, constructor restrictions and unsupported host features.',
}

def digest(data):return hashlib.sha256(data).hexdigest()
def fingerprint(app):
    paths=[app/'tools/build.py',app/'modules/entry.cpp',app/'tools/probe.py',app/'tools/package.py',app/'tools/layout.py',app/'module.h',app/'modules/module.ld',app/'modules/support.c']
    paths+=[app.parent/'rnbo/tools/audit.py']
    paths+=list((app.parent/'rnbo').glob('*.h'))+list((app.parent/'rnbo').glob('*.cpp'))+list((app.parent/'rnbo/tools').glob('*.cjs'))
    data=b''.join(str(p.relative_to(app.parent)).encode()+p.read_bytes() for p in sorted(set(paths)) if p.is_file())
    for p in [Path(__file__).resolve(),SUPPORT/'probe.py',SUPPORT/'fixtures.py']:
        data+=p.name.encode()+p.read_bytes()
    return digest(data)

def available(app,native=True):
    candidates=[os.environ.get('RNBO_DIR',''),str(Path.home()/'Documents/Max 9/Packages/RNBO'),'/Applications/Max.app/Contents/Resources/C74/packages/RNBO']
    package=next((Path(p) for p in candidates if p and (Path(p)/'server/node_modules/@rnbo/xam').is_dir()),None)
    missing=[];version=None
    if package:
        version=json.loads((package/'package-info.json').read_text()).get('version')
        if version!='1.4.4':missing.append('The production exporter requires RNBO 1.4.4; found '+str(version))
    else:missing.append('RNBO 1.4.4 code generator unavailable; reconnect the Mac or set RNBO_DIR')
    for name in ['node',os.environ.get('CXX','clang++'),os.environ.get('CC','clang')]:
        if shutil.which(name) is None:missing.append('Missing executable: '+name)
    native_mode=None
    if native:
        toolchain=Path(os.environ.get('JIELI_TOOLCHAIN',app.parent.parent/'dependencies/jieli/jieli-linux-toolchains-20260730.1'))
        if os.environ.get('JIELI_DOCKER')!='1' and (toolchain/'pi32v2/bin/cc').is_file():native_mode='local toolchain'
        elif shutil.which('docker'):
            try:
                r=subprocess.run(['docker','info','--format','{{.ServerVersion}}'],capture_output=True,text=True,timeout=10)
                if r.returncode:missing.append('Docker socket/daemon unavailable')
                else:native_mode='Docker'
            except subprocess.TimeoutExpired:missing.append('Docker status query timed out')
        else:missing.append('No native JieLi toolchain or Docker executable')
    return dict(rnbo_version=version,rnbo_package=str(package) if package else None,native_mode=native_mode,missing=missing)

def run_process(command,log,timeout):
    start=time.monotonic()
    with Path(log).open('w') as output:
        proc=subprocess.Popen(list(map(str,command)),stdout=output,stderr=subprocess.STDOUT,start_new_session=os.name=='posix')
        try:
            while proc.poll() is None:
                if STOP.wait(.1):raise KeyboardInterrupt
                if time.monotonic()-start>timeout:raise subprocess.TimeoutExpired(command,timeout)
            rc=proc.returncode;timed_out=False
        except (subprocess.TimeoutExpired,KeyboardInterrupt) as error:
            if os.name=='posix':os.killpg(proc.pid,signal.SIGKILL)
            else:proc.kill()
            proc.wait()
            if isinstance(error,KeyboardInterrupt):raise
            rc=-1;timed_out=True
    return rc,timed_out,time.monotonic()-start

def classify(returncode,timed_out,log,expected='pass'):
    stages=re.findall(r'^FM1_STAGE (\w+)',log,re.M)
    stage=stages[-1] if stages else 'starting'
    if timed_out:return 'timeout',stage
    if returncode==0:return ('unexpected_accept' if expected=='reject' else 'pass'),stage
    if expected=='reject' and 'Patch initialization/channel/parameter check failed' in log:return 'expected_reject','host initialization'
    low=log.lower()
    if any(s in low for s in ['pool exhausted','pool request too large','module state budget','module length','overflowed by','will not fit in region']):return 'resource_limit',stage
    if any(s in low for s in ['permission denied','operation not permitted','set rnbo_dir','no module named','command not found','no such file or directory']):return 'blocked_environment',stage
    if 'Unsupported embedded Gen graph:' in log or 'Embedded Gen patches need additional export handling' in log:return 'adapter_integration_gap',stage
    if stage=='exporting':return 'fixture_or_export_failure',stage
    if stage=='checking':return 'portability_audit_failure',stage
    if 'Patch host probe failed' in log:return 'host_runtime_failure','host probe'
    return 'compile_or_validation_failure',stage

def write_report(out,report):
    out=Path(out);out.mkdir(parents=True,exist_ok=True)
    tmp=out/'report.json.tmp';tmp.write_text(json.dumps(report,indent=2)+'\n');tmp.replace(out/'report.json')
    counts=collections.Counter(r['status'] for r in report['cases'])
    lines=['# RNBO/FM1 compatibility sweep','',f"Generated: {report['created_utc']}",'',
           '**A generated fixture is not a compatibility pass.** Only `pass` represents the selected compiler and runtime stages. Expected bridge rejections are separate. Export errors may be invalid fixtures and require review before blaming an object.','',
           f"Mode: {report['mode']}; RNBO: {report['environment'].get('rnbo_version') or 'unavailable'}.",'',
           '| Result | Cases |','| --- | ---: |']
    lines += [f'| {key} | {value} |' for key,value in sorted(counts.items())]
    if report['environment']['missing']:
        lines+=['','Environment blockers:']+['- '+s for s in report['environment']['missing']]
    lines+=['','| Fixture | Family | Production result | Last stage | Reference retry |','| --- | --- | --- | --- | --- |']
    for row in report['cases']:
        lines.append('| '+row['name'].replace('|','\\|')+' | '+row['family']+' | '+row['status']+' | '+row.get('stage','')+' | '+row.get('reference',{}).get('status','')+' |')
    lines+=['','## Scope','']+['- '+v for v in EXCLUSIONS.values()]
    (out/'REPORT.md').write_text('\n'.join(lines)+'\n')

def build_case(app,out,case,source,native,timeout,profile='production'):
    folder=out/'runs'/slug(case.name)/profile;module=folder/'module';module.mkdir(parents=True,exist_ok=True)
    config=dict(case.config)
    if profile=='reference':config['fast_phase']=False
    (module/'module.json').write_text(json.dumps(config,indent=2)+'\n')
    # Never reuse a stale reviewed artifact after any failed invocation.
    shutil.rmtree(module/'build',ignore_errors=True)
    command=[sys.executable,app/'tools/build.py','--patch',source,'--module-dir',module]
    if not native:command+=['--host']
    log=folder/'build.log';rc,timeout_hit,elapsed=run_process(command,log,timeout)
    text=log.read_text(errors='replace');status,stage=classify(rc,timeout_hit,text,case.expectation)
    result=dict(status=status,stage=stage,seconds=elapsed,log=str(log.relative_to(out)),returncode=rc)
    if status=='pass':
        probe_log=folder/'runtime.log';command=[sys.executable,SUPPORT/'probe.py',module/'build'/(source.stem+'.dylib'),'--assertion',case.assertion]
        rc,timeout_hit,seconds=run_process(command,probe_log,30);result['seconds']+=seconds
        if rc or timeout_hit:
            result.update(status='runtime_timeout' if timeout_hit else 'runtime_assertion_failure',stage='extended host runtime',runtime_log=str(probe_log.relative_to(out)))
        else:
            result['runtime']=json.loads(probe_log.read_text());result['stage']='target + host runtime' if native else 'host runtime'
            if native:
                review=module/'build/review.json';data=json.loads(review.read_text());package=module/'build'/(source.stem+'.rnbom')
                if digest(package.read_bytes())!=data['sha256']:raise RuntimeError('Reviewed module hash mismatch')
                result['native']=data;result['artifact']=str(package.relative_to(out));result['artifact_sha256']=data['sha256']
            else:
                artifact=module/'build'/(source.stem+'.dylib');result['artifact']=str(artifact.relative_to(out));result['artifact_sha256']=digest(artifact.read_bytes())
    if status not in ['pass','expected_reject']:
        result['diagnostic_tail']='\n'.join(text.splitlines()[-12:])[-1800:]
    return result

def main(argv=None):
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--project',type=Path,default=DEFAULT_APP,help='RNBO player directory, containing tools/build.py')
    p.add_argument('--out',type=Path,help='Must be inside the player directory; default build/compatibility')
    p.add_argument('--generate-only',action='store_true',help='Write and validate source fixtures; does not imply compilation')
    p.add_argument('--host',action='store_true',help='Run host compile/audits/runtime, without the native compiler')
    p.add_argument('--filter',default='*',help='Case name/family glob; case-insensitive')
    p.add_argument('--limit',type=int);p.add_argument('--timeout',type=int,default=180)
    p.add_argument('--jobs',type=int,default=1,help='Independent build processes, 1..8 (default 1)')
    p.add_argument('--resume',action='store_true');p.add_argument('--reference-retry',action='store_true',help='Retry failed production cases without fast phase optimization; no automatic production fallback')
    p.add_argument('--require-complete',action='store_true',help='Return nonzero if any selected case is not a pass/expected rejection')
    args=p.parse_args(argv);app=args.project.resolve()
    if not (app/'tools/build.py').is_file():p.error('--project must contain tools/build.py')
    out=(args.out or app/'build/compatibility').resolve()
    if not out.is_relative_to(app):p.error('--out must be inside the player directory')
    if args.limit is not None and args.limit<1:p.error('--limit must be positive')
    if args.timeout<1:p.error('--timeout must be positive')
    if not 1<=args.jobs<=8:p.error('--jobs must be 1..8')
    STOP.clear()
    cases=[c for c in make_cases() if fnmatch.fnmatch(c.name.lower(),args.filter.lower()) or fnmatch.fnmatch(c.family.lower(),args.filter.lower())]
    if args.limit:cases=cases[:args.limit]
    if not cases:p.error('No fixtures match the selection')
    out.mkdir(parents=True,exist_ok=True);prior={}
    if args.resume and (out/'report.json').exists():
        prior={r['id']:r for r in json.loads((out/'report.json').read_text())['cases']}
    environment=available(app,native=not args.host)
    report=dict(schema=1,created_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),mode='generated only' if args.generate_only else 'host' if args.host else 'native',environment=environment,source_fingerprint=fingerprint(app),hardware_test=False,cases=[],scope=EXCLUSIONS)
    pending=[];completed={}
    def save(index,row):
        completed[index]=row;report['cases']=[completed[i] for i in sorted(completed)];write_report(out,report)
        print(f"[{len(completed)}/{len(cases)}] {row['name']}: {row['status']}",flush=True)
    def execute(c,row,source):
        row.update(build_case(app,out,c,source,not args.host,args.timeout))
        if args.reference_retry and c.expectation=='pass' and row['status'] in ['portability_audit_failure','compile_or_validation_failure','runtime_assertion_failure']:
            row['reference']=build_case(app,out,c,source,not args.host,args.timeout,'reference')
        return row
    for index,c in enumerate(cases):
        validate(c);ident=slug(c.name);folder=out/'fixtures'/ident;folder.mkdir(parents=True,exist_ok=True)
        source=folder/(ident+'.rnbopat');source.write_text(json.dumps(c.patch,indent=2)+'\n')
        inputs=digest(source.read_bytes()+json.dumps(c.config,sort_keys=True).encode()+report['source_fingerprint'].encode()+report['mode'].encode()+str(args.reference_retry).encode())
        row=dict(id=ident,name=c.name,family=c.family,objects=c.objects,expectation=c.expectation,notes=c.notes,source=str(source.relative_to(out)),input_fingerprint=inputs,status='not_run',structurally_validated=True)
        old=prior.get(ident)
        if args.generate_only:row['status']='generated_not_compiled'
        elif environment['missing']:row['status']='blocked_environment';row['stage']='preflight'
        elif old and old.get('input_fingerprint')==inputs and old.get('status')=='pass' and old.get('artifact') and (out/old['artifact']).is_file() and digest((out/old['artifact']).read_bytes())==old.get('artifact_sha256'):
            row=old;row['reused_verified_artifact']=True
        else:
            pending.append((index,c,row,source));continue
        save(index,row)
    executor=concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs)
    futures={executor.submit(execute,c,row,source):index for index,c,row,source in pending}
    try:
        for future in concurrent.futures.as_completed(futures):save(futures[future],future.result())
    except BaseException:
        STOP.set()
        for future in futures:future.cancel()
        raise
    finally:executor.shutdown(wait=True,cancel_futures=True)
    counts=collections.Counter(r['status'] for r in report['cases']);print(json.dumps(dict(counts),sort_keys=True));print('Report:',out/'REPORT.md')
    if not args.generate_only and environment['missing']:return 2
    if args.require_complete and any(r['status'] not in ['pass','expected_reject'] for r in report['cases']):return 1
    return 0

if __name__=='__main__':raise SystemExit(main())
