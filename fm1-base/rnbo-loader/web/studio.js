// SPDX-License-Identifier: MIT
const HASH = /^[a-f0-9]{64}$/;
const ID = /^t(?:0[1-9]|1[0-5])_[a-z0-9]+$/;

export function assetURL(file, base) {
  if (typeof file !== 'string' || !/^[A-Za-z0-9_-]+(?:\/[A-Za-z0-9_.-]+)*\.[A-Za-z0-9]+$/.test(file) || file.split('/').some(p=>p==='.'||p==='..'))
    throw Error('Invalid release asset path.');
  const url = new URL(file, base);
  if (url.origin !== new URL(base).origin) throw Error('Release assets must come from the same site.');
  return url.href;
}

function asset(a, prefix, extension, maximum) {
  if (!a || typeof a.file !== 'string' || !a.file.startsWith(prefix) || !a.file.endsWith(extension) ||
      !HASH.test(a.sha256) || !Number.isSafeInteger(a.bytes) || a.bytes < 1 || a.bytes > maximum)
    throw Error('Invalid release asset metadata.');
  assetURL(a.file, 'https://release.invalid/studio/');
}

export function validateRelease(m) {
  if (!m || m.format !== 1 || m.identity !== 'FM-1_9400' || typeof m.version !== 'string' ||
      !Array.isArray(m.patches) || m.patches.length !== 15)
    throw Error('This is not a complete FM1 RNBO Studio release.');
  asset(m.firmware, 'firmware/', '.fwsc', 16*1024*1024);
  asset(m.sources, 'sources', '.zip', 128*1024*1024);
  const ids = new Set(), slots = new Set(), files = new Set();
  for (const p of m.patches) {
    if (!ID.test(p.id) || ids.has(p.id) || typeof p.title !== 'string' ||
        !Number.isInteger(p.bank) || p.bank < 1 || p.bank > 5 || ![1,2,3].includes(p.slot) ||
        slots.has(p.bank+':'+p.slot) || ![1,2].includes(p.abi) ||
        !Number.isInteger(p.image_bytes) || p.image_bytes < 84 || p.image_bytes > 65536 ||
        !Number.isInteger(p.state_bytes) || p.state_bytes < 0 || p.state_bytes > 180224 ||
        p.bytes !== p.image_bytes+64 || files.has(p.file))
      throw Error('Invalid patch library metadata.');
    asset(p, 'patches/', '.rnbom', 65600);
    ids.add(p.id); slots.add(p.bank+':'+p.slot); files.add(p.file);
  }
  return m;
}

export async function verifyBytes(bytes, metadata) {
  if (bytes.byteLength !== metadata.bytes) throw Error('Download size does not match the release.');
  const digest = await crypto.subtle.digest('SHA-256', bytes);
  const hash = [...new Uint8Array(digest)].map(b=>b.toString(16).padStart(2,'0')).join('');
  if (hash !== metadata.sha256) throw Error('Download checksum does not match the release.');
  return bytes;
}

export function inspectFirmware(bytes, productOf) {
  if (bytes.length < 960 || productOf(bytes) !== 'FM-1_9400')
    throw Error('Choose the RNBO Player image for this release (FM-1_9400).');
  const marker = new TextEncoder().encode('FELUCCA-LOADER-1');
  if (!bytes.some((_,i)=>marker.every((b,j)=>bytes[i+j]===b)))
    throw Error('The firmware image has no update loader.');
}

export async function installFirmware(bytes, {access, Updater, productOf, logicalImage, onStep}) {
  inspectFirmware(bytes, productOf);
  const updater = new Updater(access), image = logicalImage(bytes);
  try {
    if (await updater.resume(image, onStep)) {
      onStep('reboot');
      const back = await updater.waitFor(id=>id.text==='FM-1_9400', 40000);
      if (!back) throw Error('The write finished, but RNBO Player did not reconnect. Power-cycle the FM1 and reconnect.');
      back.link.close();
      onStep('done');
    } else {
      await updater.install(image, 'FM-1_9400', onStep);
    }
  } finally {
    for (const port of access.inputs.values()) port.onmidimessage = null;
    await Promise.allSettled([...access.inputs.values(),...access.outputs.values()].map(p=>p.close()));
  }
}

export async function setupStudio(host, deps={}) {
  const doc = deps.document || document, el = id=>doc.getElementById(id);
  const request = deps.fetch || fetch, base = deps.base || new URL('.', location.href).href;
  const loadPackage = deps.loadPackage || (()=>import('./fm1pkg.js'));
  const loadUpdater = deps.loadUpdater || (()=>import('./fm1ota.js'));
  const midi = deps.midi || (()=>navigator.requestMIDIAccess({sysex:true}));
  let release = null, busy = false, selected = null, file = null, fileInvalid = false, localSession = null;
  const buttons = [];
  const say = text=>{el('release-status').textContent=text;};
  function update(state={}) {
    busy = !!state.busy;
    el('install-player').disabled=busy||!release||fileInvalid;
    el('firmware-file').disabled=busy||!release;
    el('stop-service').disabled=busy;
    for (const button of buttons) button.disabled=busy||!release;
  }
  function display(rows) {
    const list = el('library'); list.replaceChildren(); buttons.length=0;
    for (const p of rows) {
      const card=doc.createElement('article'), heading=doc.createElement('h3'), info=doc.createElement('p'), listen=doc.createElement('p'), button=doc.createElement('button');
      heading.textContent=p.id.toUpperCase()+' · '+p.title;
      info.textContent=`Group ${p.bank} · example slot ${p.slot}`+(p.image_bytes?` · ${(p.image_bytes/1024).toFixed(1)} KiB program · ${(p.state_bytes/1024).toFixed(1)} KiB RAM`:'');
      listen.textContent=p.listen||''; button.textContent=release?'Choose Patch':'Release build required';
      button.onclick=()=>choose(p); buttons.push(button);
      card.append(heading,info,listen,button); list.append(card);
    }
    update({busy});
  }
  async function download(a) {
    const response=await request(assetURL(a.file,base));
    if (!response.ok) throw Error('Could not download '+a.file+'.');
    return verifyBytes(new Uint8Array(await response.arrayBuffer()),a);
  }
  async function choose(p) {
    if (!release||busy||!host.reserve('library')) return;
    update({busy:true});
    try {
      const bytes=await download(p);
      host.release('Patch checked.');
      await host.loadFile(new File([bytes],p.id+'.rnbom',{type:'application/octet-stream'}));
      selected=p;
      el('library-selection').textContent=p.id.toUpperCase()+' selected. Choose the destination slot above, then Upload Patch.';
      el('patch-heading').scrollIntoView?.({behavior:'smooth',block:'center'});
    } catch(e) { host.release(e.message); }
    finally { update({busy:host.isBusy()}); }
  }
  async function install() {
    if (!release||busy||fileInvalid||!host.reserve('firmware')) return;
    update({busy:true}); let writing=false;
    const guard=e=>{if(writing){e.preventDefault();e.returnValue='';}};
    const win=deps.window||window;
    win.addEventListener('beforeunload',guard);
    try {
      say('Checking the firmware image…');
      const bytes=file?await verifyBytes(new Uint8Array(await file.arrayBuffer()),release.firmware):await download(release.firmware);
      const [{productOf,logicalImage},{Updater}]=await Promise.all([loadPackage(),loadUpdater()]);
      inspectFirmware(bytes,productOf);
      await host.disconnect();
      const access=await midi();
      writing=true;
      el('firmware-progress').hidden=false; el('firmware-progress').removeAttribute('value');
      await installFirmware(bytes,{access,Updater,productOf,logicalImage,onStep:(step,count)=>{
        const labels={start:'Starting update',verify:'Checking image on FM1',loader:'Waiting for update loader',write:'Writing firmware',reboot:'Waiting for RNBO Player to restart',done:'RNBO Player installed'};
        say((labels[step]||step)+(typeof count==='number'?` · ${count} transfers`:'')+'. Keep USB connected.');
      }});
      el('firmware-progress').value=100;
      say('RNBO Player installed. Find USB MIDI Device and reconnect below, then choose a library patch.');
      host.release('Firmware installed. Reconnect the FM1 to see its three patch slots.');
    } catch(e) {
      say(e.message); host.release('Firmware installation stopped: '+e.message);
      el('firmware-progress').hidden=true;
    } finally {
      writing=false;win.removeEventListener('beforeunload',guard);update({busy:host.isBusy()});
    }
  }
  el('install-player').onclick=install;
  el('firmware-file').onchange=async()=>{
    file=el('firmware-file').files[0]||null;fileInvalid=!!file;update({busy});
    if (!file) {say('Ready to install the released player.');return;}
    if (!release) return;
    const candidate=file;
    try {
      if(file.size!==release.firmware.bytes)throw Error('Choose the firmware image supplied with this release.');
      await verifyBytes(new Uint8Array(await file.arrayBuffer()),release.firmware);
      if(file!==candidate)return;
      fileInvalid=false;say(file.name+' matches release '+release.version+'.');
    } catch(e) {if(file===candidate)say(e.message);}
    update({busy:host.isBusy()});
  };
  el('stop-service').onclick=async()=>{
    if(busy||!localSession||!host.reserve('stop'))return;
    try {
      const response=await request('/api/quit',{method:'POST',headers:{'X-FM1-Token':localSession.token}});
      if(!response.ok)throw Error('The local service could not stop. Finish any running build first.');
      await host.disconnect();say('Local service stopped. Close this tab, or reopen Studio to continue.');
      host.release('Studio service stopped. Reopen Open-Studio.command to continue.');
    }catch(e){host.release(e.message);}
  };
  update();
  try {
    const response=await request(new URL('release.json',base));
    if(response.ok) {
      release=validateRelease(await response.json());
      say('Release '+release.version+' · firmware and all 15 patches ready.');
      display(release.patches);
      el('source-download').href=assetURL(release.sources.file,base);el('source-download').hidden=false;
    }else if(response.status===404) {
      say('Build a Studio release on your Mac to enable firmware installation and the compiled patch library. Patch conversion is available below.');
      const catalogue=await request(new URL('catalogue.json',base));
      if(catalogue.ok)display((await catalogue.json()).patches);
    }else throw Error('Could not load the Studio release.');
  }catch(e){release=null;say(e.message);}
  try {
    const response=await request('/api/session');
    if(response.ok){const info=await response.json();if(info.studio_version===1){localSession=info;el('stop-service').hidden=false;}}
  }catch{}
  update({busy:host.isBusy()});
  return {update,choose,install,get selected(){return selected;},get release(){return release;}};
}
