#!/usr/bin/env node
// Local RNBO 1.4.4 code-generation probe. Uses the user's installed package.
// No installed package files are changed. Generated licensing is preserved.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const {float32}=require('./float32.cjs');
const {prepareRuntime}=require('./runtime.cjs');
const {cpp11Strings}=require('./cpp11.cjs');
const {float32Delays}=require('./float32-delays.cjs');
const {prepareMaxPatch}=require('./maxpat.cjs');
const {describePatch}=require('./patcher.cjs');
const {narrowSawTruncation}=require('./saw-truncation.cjs');
const root = path.resolve(__dirname, '..');
const candidates = [process.env.RNBO_DIR, path.join(process.env.HOME, 'Documents/Max 9/Packages/RNBO'), '/Applications/Max.app/Contents/Resources/C74/packages/RNBO'].filter(Boolean);
const pkg = candidates.find(p => fs.existsSync(path.join(p, 'server/node_modules/@rnbo/xam')));
if (!pkg) throw Error('Set RNBO_DIR to an installed RNBO 1.4.4 package.');
process.env.RNBO_DIR = pkg;
process.env.BABEL_DISABLE_CACHE = '1';
const version = JSON.parse(fs.readFileSync(path.join(pkg, 'package-info.json'))).version;
if (version !== '1.4.4') throw Error(`This internal-API probe is pinned to RNBO 1.4.4; found ${version}. Use a normal Minimal Export instead.`);
const modules = path.join(pkg, 'server/node_modules');
const xam = require(path.join(modules, '@rnbo/xam'));
const runner = require(path.join(modules, '@rnbo/xam-runner'));
const args=process.argv.slice(2);
const outIndex=args.indexOf('--out');
const outputArg=outIndex>=0?args.splice(outIndex,2)[1]:null;
if(outIndex>=0 && !outputArg)throw Error('--out requires a directory');
const voicesIndex=args.indexOf('--voices');
const voices=voicesIndex>=0?Number(args.splice(voicesIndex,2)[1]):1;
if(!Number.isInteger(voices) || voices<1 || voices>4)throw Error('This FM1 target supports export tests with 1 to 4 voices.');
const fastIndex=args.indexOf('--fast-phase');
const fastPhase=fastIndex>=0;
if(fastPhase)args.splice(fastIndex,1);
const sharedIndex=args.indexOf('--shared-fx');
const sharedFx=sharedIndex>=0;
if(sharedFx)args.splice(sharedIndex,1);
const delayIndex=args.indexOf('--float32-delays');
const useFloat32Delays=sharedFx||delayIndex>=0;
if(delayIndex>=0)args.splice(delayIndex,1);
const input = args[0] || path.join(root, 'patches/mono.rnbopat');
const patcher = JSON.parse(fs.readFileSync(input)).patcher;
// Max normally saves instance-specific inlet/outlet metadata. Recreate it for
// our deliberately small, self-contained patch (no abstractions or gen files).
describePatch(patcher,xam,runner);
if(sharedFx){
  const groups=patcher.boxes.filter(({box})=>box.patcher && box.text && Number(xam.parseBoxText(box.text).attributes.polyphony)>1);
  if(groups.length!==1 || Number(xam.parseBoxText(groups[0].box.text).attributes.polyphony)!==voices)
    throw Error('Shared-effect export requires one embedded polyphonic group matching the voice count');
}

const out = outputArg?path.resolve(outputArg):path.join(root, 'export');
fs.mkdirSync(out, {recursive:true});
(async () => {
  const invocation = runner.createInvocation(xam, patcher, {
    language: 0, classname:'fm1patch', fixedblocksize:256, fixedsamplerate:44100,
    polyphony:!sharedFx&&voices>1?voices:0, midi:true, presets:false, staterestore:false, probing:false, license:true
  });
  const result = await runner.codegenInvocationStorage.run({reportCodegenProgress:()=>{}}, () => invocation.call());
  if (!result.code) throw Error('RNBO returned no C++ source');
  const delayAdaptation=useFloat32Delays && /\b(?:new Float64Buffer\(this->delaytilde_|Float64BufferRef delaytilde_)/.test(result.code)?float32Delays(result.code):{code:result.code,count:0};
  const sawAdaptation=fastPhase?narrowSawTruncation(delayAdaptation.code):{code:delayAdaptation.code,count:0};
  const floats=float32(sawAdaptation.code);
  const strings=cpp11Strings(floats.code);
  const adapted={code:strings.code,count:floats.count};
  fs.writeFileSync(path.join(out,'rnbo_source.raw.h'), result.code);
  fs.writeFileSync(path.join(out,'rnbo_source.h'), adapted.code);
  fs.writeFileSync(path.join(out,'description.json'), JSON.stringify(result.desc,null,2)+'\n');
  const common = path.join(pkg,'source/rnbo/common');
  fs.cpSync(common,path.join(out,'common'),{recursive:true,filter:p=>!p.endsWith('U.cpp')});
  fs.copyFileSync(path.join(pkg,'source/rnbo/LICENSE'),path.join(out,'RNBO-runtime-LICENSE'));
  const runtime_adaptations=prepareRuntime(out,{clockTargets:fastPhase});
  const hashes = {};
  for (const name of fs.readdirSync(path.join(out,'common')).sort()) {
    const p=path.join(out,'common',name);
    if(fs.statSync(p).isFile()) hashes[name]=crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
  }
  const activeMethods=[...result.code.matchAll(/number ([A-Za-z0-9_]+_calcActiveVoices)\(\)/g)].map(m=>m[1]);
  if(voices>1 && activeMethods.length!==1)throw Error('Review voice counter for this export topology');
  const digest=crypto.createHash('sha256').update(adapted.code).update(fastPhase?'\nFM1_FAST_PHASE_v1_CLOCK_TARGETS_v1':'').digest('hex');
  fs.writeFileSync(path.join(out,'patch_config.h'),`// Generated patch identity: invalidate saved parameters after code changes.\n#define RNBO_FM1_PATCH_ID 0x${digest.slice(0,8)}u\n#define RNBO_FM1_CLASS fm1patch\n#define RNBO_FM1_POLYPHONY ${voices}\n#define RNBO_FM1_SHARED_FX ${sharedFx?1:0}\n${voices>1?'#define RNBO_FM1_VOICE_COUNT_METHOD '+activeMethods[0]+'\n':''}#define RNBO_FM1_FAST_PHASE ${fastPhase?1:0}\n#define RNBO_FM1_EXPOSED_PARAMS ${voices>1?(result.desc.parameters||[]).filter(p=>!p.paramId.includes("/")).length:(result.desc.parameters||[]).length}u\n`);
  fs.writeFileSync(path.join(out,'provenance.json'),JSON.stringify({rnbo_version:version,voices,shared_fx:sharedFx,fast_phase:fastPhase,package:pkg,input:path.resolve(input),input_sha256:crypto.createHash('sha256').update(fs.readFileSync(input)).digest('hex'),raw_generated_sha256:crypto.createHash('sha256').update(result.code).digest('hex'),adapted_sha256:crypto.createHash('sha256').update(adapted.code).digest('hex'),patch_identity_sha256:digest,float_literal_adaptations:adapted.count,float32_delay_buffers:delayAdaptation.count,narrowed_saw_truncations:sawAdaptation.count,cpp11_string_adaptations:strings.count,runtime_adaptations,fixed_sample_rate:44100,fixed_vector_size:256,common_sha256:hashes},null,2)+'\n');
  const box=(id,text,x,y,extra={})=>({box:{id,maxclass:'newobj',text,patching_rect:[x,y,160,22],...extra}});
  const wire=(a,b,c,d)=>({patchline:{source:[a,b],destination:[c,d]}});
  const maxpatch={patcher:{fileversion:1,appversion:{major:9,minor:0,revision:9,architecture:'arm64',modernui:1},rect:[100,100,640,360],boxes:[
    box('midi','midiin',40,40),box('patch',`rnbo~ @dumpoutlet 1${!sharedFx&&voices>1?' @polyphony '+voices:''}`,40,110,{patcher,rnbo_classname:'fm1patch',rnbo_serial:1,rnbo_savetocoll:0}),
    box('dac','ezdac~',40,240),{box:{id:'help',maxclass:'comment',text:'RNBO FM1 mono probe. Audio starts OFF. Edit inside rnbo~. K1: level, K2: attack, K3: release.',patching_rect:[230,40,360,90],linecount:4}},
    {box:{id:'level',maxclass:'message',text:'level 0.2',patching_rect:[260,150,90,22]}},
    {box:{id:'attack',maxclass:'message',text:'attack 10',patching_rect:[260,185,90,22]}},
    {box:{id:'release',maxclass:'message',text:'release 150',patching_rect:[260,220,90,22]}}
  ],lines:[wire('midi',0,'patch',0),wire('patch',0,'dac',0),wire('patch',1,'dac',1),wire('level',0,'patch',0),wire('attack',0,'patch',0),wire('release',0,'patch',0)]}};
  if(outputArg){
    const params=result.desc.parameters||[];
    maxpatch.patcher.boxes=maxpatch.patcher.boxes.filter(v=>!['level','attack','release'].includes(v.box.id));
    maxpatch.patcher.lines=maxpatch.patcher.lines.filter(v=>!['level','attack','release'].includes(v.patchline.source[0]));
    maxpatch.patcher.boxes.find(v=>v.box.id==='help').box.text='RNBO FM1 module. Audio starts OFF. Edit inside rnbo~; save the RNBO subpatch as .rnbopat before building.';
    params.slice(0,8).forEach((p,i)=>{
      maxpatch.patcher.boxes.push({box:{id:'param'+i,maxclass:'message',text:p.name+' '+p.initialValue,patching_rect:[240+190*Math.floor(i/4),140+35*(i%4),180,22]}});
      maxpatch.patcher.lines.push(wire('param'+i,0,'patch',0));
    });
  }
  fs.writeFileSync(outputArg?path.join(path.dirname(out),path.basename(input,'.rnbopat')+'.maxpat'):path.join(root,'patches/mono.maxpat'),JSON.stringify(prepareMaxPatch(maxpatch,xam,version),null,2)+'\n');
  console.log(`Generated ${result.code.length} bytes of RNBO C++, version ${version}; suffixed ${adapted.count} float literals; adapted ${strings.count} C++11 string members`);
})().catch(e=>{console.error(e);process.exitCode=1});
