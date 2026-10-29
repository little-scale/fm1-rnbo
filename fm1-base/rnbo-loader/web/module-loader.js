// SPDX-License-Identifier: MIT
export const u32=(b,i=0)=>(b[i]|b[i+1]<<8|b[i+2]<<16|b[i+3]<<24)>>>0;
export const put32=n=>[n&255,n>>>8&255,n>>>16&255,n>>>24&255];
export function crc(b){let c=0xffffffff;for(const v of b){c^=v;for(let j=0;j<8;j++)c=(c>>>1)^((c&1)?0xedb88320:0);}return (~c)>>>0;}
export function pack(b){const out=[];let a=0,n=0;for(const v of b){a|=v<<n;n+=8;while(n>=7){out.push(a&127);a>>>=7;n-=7;}}if(n)out.push(a&127);return out;}
export function unpack(b){const out=[];let a=0,n=0;for(const v of b){a|=(v&127)<<n;n+=7;while(n>=8){out.push(a&255);a>>>=8;n-=8;}}return Uint8Array.from(out);}
export function frame(cmd,body=[]){return Uint8Array.from([240,...pack([0,89,cmd,body.length&255,body.length>>>8&255,0,...body,(~body.reduce((a,v)=>a+v,0))&255]),247]);}
export function parseModule(b){
  if(b.length<148)throw Error('Module is too short');
  const abi=u32(b,8);if(abi!==1&&abi!==2)throw Error('Unsupported MIDI ABI');
  const wanted=[0x314d4e52,1,abi,241,44100,256,0x1c34000,0x1c44000];
  if(wanted.some((v,i)=>u32(b,i*4)!==v))throw Error('Incompatible module format or player ABI');
  const imageBytes=u32(b,32),stateBytes=u32(b,36),id=u32(b,44),im=b.subarray(64);
  if(imageBytes<84||imageBytes>65536||imageBytes%4||b.length!==64+imageBytes||stateBytes>180224||stateBytes%4)throw Error('Module exceeds memory limits');
  if(crc(b.subarray(0,48))!==u32(b,48)||[52,56,60].some(i=>u32(b,i))||crc(im)!==u32(b,40))throw Error('Module integrity check failed');
  if([0x31495041,abi,84,id].some((v,i)=>u32(im,i*4)!==v))throw Error('Invalid patch interface');
  const titleBytes=im.subarray(16,48),end=titleBytes.indexOf(0);if(end<0)throw Error('Invalid patch title');
  for(let i=48;i<84;i+=4){const p=u32(im,i);if(p<0x1c34000+84||p>=0x1c34000+imageBytes||p%2)throw Error('Invalid patch entry point');}
  return {abi,title:new TextDecoder().decode(titleBytes.subarray(0,end)),id,imageBytes,stateBytes};
}
export function parseBank(d){
  if(d.length!==23||d[0]!==0||d[1]!==89||d[2]!==0x6d||d[3]!==16||d[4]||d[5]||((~d.subarray(6,-1).reduce((a,v)=>a+v,0))&255)!==d[d.length-1])throw Error('Invalid patch-bank reply');
  const version=u32(d,6),count=u32(d,10),active=u32(d,14),occupied=u32(d,18);
  if(version!==1||count!==3||active>3||occupied>7||(active&&!(occupied&(1<<(active-1)))))throw Error('Unsupported patch bank');
  return {version,count,active,occupied};
}
export function inspectSource(text){
  let doc;try{doc=JSON.parse(text);}catch{throw Error('This .rnbopat is not valid JSON. Save it again from the RNBO editor.');}
  const patch=doc?.patcher;if(!patch||patch.classnamespace!=='rnbo'||!Array.isArray(patch.boxes))throw Error('Save a .rnbopat from inside the RNBO editor, rather than the surrounding Max patch.');
  const groups=patch.boxes.map(({box:b})=>{
    const text=b.text||'',m=text.match(/(?:^|\s)@polyphony\s+(\d+)(?=\s|$)/);
    return b.patcher&&(b.rnbo_classname==='p'||/^p\s/.test(text))?Number(m?m[1]:b.rnbo_extra_attributes?.polyphony||1):1;
  }).filter(n=>n>1);
  if(groups.length>1||groups.some(n=>![2,4].includes(n)))throw Error('Use one embedded synth group with 2 or 4 voices.');
  return {embeddedVoices:groups[0]||0};
}
if(typeof document!=='undefined')setup();
function setup(){
  const el=id=>document.getElementById(id);
  let access,input,output,connected=false,data=null,meta=null,source=null,sourceName='',embedded=0,pending=false,timer,playerAbi=0,phase='idle',bank=null,chosen=1,uploadedSlot=0,legacy=false;
  let service=null,fileVersion=0,deviceVersion=0,downloadUrl=null;
  const log=s=>el('log').textContent=s;
  const memory=()=>`${meta.title} · ${(meta.imageBytes/1024).toFixed(1)} / 64 KiB program · ${(meta.stateBytes/1024).toFixed(1)} / 176 KiB working RAM`;
  function controls(){
    el('connect').disabled=!access||pending;el('upload').disabled=!connected||(!data&&!(source&&service))||pending;
    el('upload').textContent=source&&!data?'Build & Upload':'Upload Patch';
    el('build').disabled=!source||!service||pending;el('build').hidden=!source;
    el('status').disabled=!connected||pending;el('ports').disabled=pending;el('device').disabled=pending;el('file').disabled=pending;
    el('voices').disabled=pending||!source||!!embedded;el('voice-options').hidden=!source;
    el('slot-options').hidden=legacy;
    for(let n=1;n<=3;n++){
      const button=el('slot'+n),stored=!!(bank?.occupied&(1<<(n-1))),active=bank?.active===n;
      button.disabled=!connected||pending||!bank;button.setAttribute('aria-pressed',String(chosen===n));
      button.textContent=`Slot ${n} · ${bank?(stored?'Stored':'Empty'):'Connect to view'}${active?' · Active':''}`;
    }
    el('destination').textContent=legacy?'Upload replaces the currently active patch. Three-slot selection will appear after the player update.':bank?`Upload to slot ${chosen}${bank.occupied&(1<<(chosen-1))?' — replaces this slot’s patch.':' — empty slot.'}`:'Connect to see available patch slots.';
  }
  function finish(message){pending=false;phase='idle';clearTimeout(timer);controls();log(message);}
  function wait(message,ms=6000){clearTimeout(timer);timer=setTimeout(()=>finish(message),ms);}
  function requestBank(verify=false){
    phase=verify?'verify-bank':'bank';clearTimeout(timer);
    timer=setTimeout(()=>{
      if(verify){finish('Upload was acknowledged, but slot verification timed out. Refresh device status before retrying.');return;}
      legacy=true;bank=null;connected=true;finish('Player connected. Uploads replace the current patch; no firmware update is needed.');
    },1200);
    output.send(frame(0x6c));
  }
  function metrics(d){el('metrics').textContent=`CPU ${u32(d,14)}% · overruns ${u32(d,18)} · peak ${u32(d,26)} µs / 5805 µs budget`;}
  function receive(event){try{
    const p=event.data;if(p[0]!==240||p[p.length-1]!==247)return;const d=unpack(p.subarray(1,-1));if(d[0]!==0||d[1]!==89)return;
    if(d[2]===0x11&&d.length===34&&phase==='identity'){
      const identity=new TextDecoder().decode(d.subarray(6,33)).replace(/\0+$/,'');
      if(identity!=='FM-1_9400'){connected=false;finish(`Connected ${identity}. Install RNBO Player FM-1_9400 first.`);return;}
      phase='status';output.send(frame(0x68));return;
    }
    if(d.length<7||((~d.subarray(6,-1).reduce((a,v)=>a+v,0))&255)!==d[d.length-1])return;
    if(d[2]===0x30&&phase==='upload'&&connected&&data&&d.length===15){
      const at=u32(d,7),n=d[11]|d[12]<<8|d[13]<<16;
      if(n<1||n>512||at>data.length||n>data.length-at){finish('Device requested bytes outside the patch. Upload stopped.');return;}
      output.send(frame(0x30,[0,...put32(at),n&255,n>>>8,0,...data.subarray(at,at+n)]));el('progress').value=(at+n)*100/data.length;return;
    }
    if(d[2]===0x6d&&(phase==='bank'||phase==='verify-bank')){
      const verify=phase==='verify-bank';bank=parseBank(d);legacy=false;connected=true;
      if(verify&&bank.active!==uploadedSlot){finish('Active slot mismatch. Refresh device status before retrying.');return;}
      chosen=bank.active||chosen;
      finish(verify?`${meta.title} is active in slot ${bank.active}. PRESETS changes patches on the FM1.`:'Player connected. Choose a patch, then Build & Upload.');return;
    }
    if(d.length!==35||d[3]!==28||d[4]||d[5]||![1,2].includes(u32(d,22)))return;
    if(d[2]===0x69&&phase==='status'){playerAbi=u32(d,22);metrics(d);requestBank();}
    else if(d[2]===0x6b&&phase==='upload'){
      metrics(d);
      if((u32(d,6)|0)!==0)finish(`Patch rejected (${u32(d,6)|0}). Previously committed patches remain stored.`);
      else if(!meta||u32(d,10)!==meta.id)finish('Active patch identity mismatch. Refresh device status before retrying.');
      else {el('progress').value=100;if(legacy)finish(`${meta.title} is active. Ready to play.`);else requestBank(true);}
    }
  }catch(e){connected=false;finish(e.message);}}
  async function api(path,options={}){
    const response=await fetch(path,{...options,headers:{'X-FM1-Token':service?.token||'',...options.headers}});
    if(!response.ok){let message=`Local build service error (${response.status}).`;try{message=(await response.json()).error||message;}catch{}throw Error(message);}
    return response;
  }
  function clearDownload(){if(downloadUrl)URL.revokeObjectURL(downloadUrl);downloadUrl=null;el('download').hidden=true;el('download').removeAttribute('href');}
  function setDownload(){clearDownload();downloadUrl=URL.createObjectURL(new Blob([data],{type:'application/octet-stream'}));el('download').href=downloadUrl;el('download').download=sourceName.replace(/\.rnbopat$/i,'.rnbom');el('download').hidden=false;}
  async function loadFile(file){
    if(pending||!file)return;
    const version=++fileVersion;source=null;data=meta=null;embedded=0;sourceName=file.name;clearDownload();el('build-log').textContent='';el('build-details').hidden=true;controls();
    try{
      if(file.size>4*1024*1024)throw Error('Choose a patch smaller than 4 MiB.');
      const bytes=new Uint8Array(await file.arrayBuffer());if(version!==fileVersion)return;
      if(/\.rnbopat$/i.test(file.name)){
        const text=new TextDecoder().decode(bytes),info=inspectSource(text);source=text;embedded=info.embeddedVoices;
        let remembered=1;try{remembered=Number(localStorage.getItem('fm1-voices:'+sourceName))||1;}catch{}
        el('voices').value=String(embedded||([1,2,4].includes(remembered)?remembered:1));
        el('voice-help').textContent=embedded?`The embedded synth sets ${embedded} voices; master effects stay shared.`:'Choose how many voices this instrument should play. This choice is remembered for this filename.';
        el('patch').textContent=`${file.name} · RNBO source · ready to build`;
      }else if(/\.rnbom$/i.test(file.name)){
        const description=parseModule(bytes);data=bytes;meta=description;el('patch').textContent=memory();
      }else throw Error('Choose an RNBO .rnbopat source file or a compiled .rnbom patch.');
      controls();log(source?'Patch selected. Connect the FM1 and click Build & Upload, or use Build Only to prepare it offline.':'Compiled patch selected. Connect the FM1 and click Upload Patch.');
    }catch(e){source=data=meta=null;el('patch').textContent='Patch could not be loaded.';controls();log(e.message);}
  }
  function upload(){
    if(!connected||!data||!meta)throw Error('Connect the FM1 before uploading.');
    if(meta.abi>playerAbi)throw Error('This polyphonic patch needs the newer raw-MIDI player firmware.');
    uploadedSlot=chosen;pending=true;phase='upload';controls();el('progress').value=0;
    log(`Uploading ${meta.title}${legacy?'':` to slot ${uploadedSlot}`}… Keep USB connected.`);
    wait('Upload timed out. Reconnect and refresh status before retrying. Previously committed patches remain stored.',180000);
    output.send(frame(legacy?0x6a:0x6e,[...put32(data.length),...put32(crc(data)),...(legacy?[]:put32(uploadedSlot))]));
  }
  async function build(andUpload){
    if(!source||!service||pending)return;
    const initialDevice=deviceVersion,initialFile=fileVersion,voices=Number(el('voices').value),destination=chosen;
    try{localStorage.setItem('fm1-voices:'+sourceName,String(voices));}catch{}
    pending=true;phase='build';data=meta=null;clearDownload();controls();el('progress').value=0;el('build-details').hidden=false;el('build-log').textContent='Starting local compiler…';
    try{
      const response=await api('/api/build',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({name:sourceName,source,voices})});
      const {id}=await response.json();let job;
      const labels={exporting:'Exporting RNBO',checking:'Checking portability',compiling:'Compiling and testing audio',target:'Compiling for FM1',validating:'Checking the FM1 package'};
      do{
        job=await (await api('/api/jobs/'+id)).json();if(initialFile!==fileVersion)throw Error('The selected patch changed. Build it again.');
        log((labels[job.stage]||'Building patch')+'…');el('build-log').textContent=job.log||'Starting local compiler…';
        if(job.state==='running')await new Promise(resolve=>setTimeout(resolve,500));
      }while(job.state==='running');
      if(job.state!=='succeeded')throw Error(job.error||'Build failed. See the build log.');
      const result=new Uint8Array(await (await api('/api/jobs/'+id+'/module')).arrayBuffer());
      const description=parseModule(result);data=result;meta=description;el('patch').textContent=memory();setDownload();
      if(andUpload&&connected&&deviceVersion===initialDevice&&input?.state!=='disconnected'&&output?.state!=='disconnected'){
        chosen=destination;upload();
      }else finish(andUpload?'Build passed. Reconnect the FM1, then click Upload Patch.':'Build passed. Download the module, or connect the FM1 and click Upload Patch.');
    }catch(e){finish(e.message);}
  }
  el('ports').onclick=async()=>{try{
    if(!navigator.requestMIDIAccess)throw Error('Web MIDI is unavailable. Open this page in Chrome or Edge.');
    connected=false;bank=null;legacy=false;deviceVersion++;access=await navigator.requestMIDIAccess({sysex:true});el('device').replaceChildren();
    for(const port of access.inputs.values())if(/fm-?1|rnbo|felucca/i.test(port.name))el('device').add(new Option(port.name,port.id));
    if(!el('device').options.length)throw Error('No FM1 MIDI input found. Check the USB data cable.');controls();log('Choose the FM1, then Connect.');
    access.onstatechange=()=>{if(input?.state==='disconnected'||output?.state==='disconnected'){
      connected=false;bank=null;deviceVersion++;
      if(phase==='build'){controls();log('FM1 disconnected. The build will finish; reconnect before uploading.');}
      else finish('FM1 disconnected. Reconnect before uploading.');
    }};
  }catch(e){controls();log(e.message);}};
  el('connect').onclick=async()=>{try{
    if(input)input.onmidimessage=null;connected=false;bank=null;legacy=false;deviceVersion++;input=access.inputs.get(el('device').value);
    output=[...access.outputs.values()].find(p=>p.name===input?.name);if(!output)throw Error('No matching FM1 MIDI output found.');
    await input.open();await output.open();input.onmidimessage=receive;pending=true;phase='identity';controls();log('Checking the RNBO Player…');
    wait('No player response. Check USB and installed firmware.');output.send(Uint8Array.from([240,0,50,69,0,0,0,64,127,247]));
  }catch(e){finish(e.message);}};
  el('file').onchange=()=>loadFile(el('file').files[0]);
  el('dropzone').ondragover=e=>{e.preventDefault();};
  el('dropzone').ondrop=e=>{e.preventDefault();return loadFile(e.dataTransfer.files[0]);};
  el('voices').onchange=()=>{if(pending)return;data=meta=null;clearDownload();controls();};
  el('device').onchange=()=>{connected=false;bank=null;deviceVersion++;controls();};
  for(let n=1;n<=3;n++)el('slot'+n).onclick=()=>{chosen=n;controls();};
  el('upload').onclick=()=>{if(pending)return;if(source&&!data)return build(true);try{upload();}catch(e){finish(e.message);}};
  el('build').onclick=()=>build(false);
  el('status').onclick=()=>{pending=true;phase='status';controls();wait('No device status response.');output.send(frame(0x68));};
  controls();
  fetch('/api/session').then(r=>{if(!r.ok)throw Error('service');return r.json();}).then(info=>{
    if(info.version!==2||!info.token||!info.builder)throw Error('service');service=info;
    el('service').textContent='Local builder ready. Keep its Terminal window open while building.';controls();
  }).catch(()=>{el('service').textContent='To build RNBO files, open Open-Build-Uploader.command. Compiled .rnbom uploads still work here.';controls();});
}
