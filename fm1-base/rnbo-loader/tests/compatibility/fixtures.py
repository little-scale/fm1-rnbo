# SPDX-License-Identifier: MIT
"""Small, driven RNBO graphs. Candidate fixtures are not compatibility claims.

Every claimed operator must have a path to an audio output. External files,
host UI, network and hardware I/O are not simulated as if they were supported.
"""
from dataclasses import dataclass,field
import hashlib,json,re

@dataclass
class Case:
    name:str
    family:str
    patch:dict
    objects:list
    expectation:str='pass'
    assertion:str='finite'
    notes:str=''
    config:dict=field(default_factory=lambda:dict(voices=1,fast_phase=True,float32_delays=True,shared_fx=False,pool_bytes=98304))

class Graph:
    def __init__(self):self.boxes=[];self.lines=[]
    def box(self,text,**extra):
        ident='obj-'+str(len(self.boxes)+1)
        box=dict(id=ident,maxclass='newobj',text=text,patching_rect=[30+(len(self.boxes)%4)*180,30+(len(self.boxes)//4)*50,160,23]);box.update(extra)
        self.boxes.append({'box':box})
        return ident
    def wire(self,source,dest,outlet=0,inlet=0):
        self.lines.append({'patchline':dict(source=[source,outlet],destination=[dest,inlet])});return self
    def output(self,source,second=None):
        self.wire(source,self.box('out~ 1'));self.wire(second or source,self.box('out~ 2'))
    def document(self):return {'patcher':{'fileversion':1,'classnamespace':'rnbo','rect':[0,0,820,640],'boxes':self.boxes,'lines':self.lines}}

def slug(text):
    # Stable, short filenames accepted by the production builder.
    s=re.sub('[^a-z0-9]+','_',text.lower()).strip('_')[:15]
    return 'c_'+s+'_'+hashlib.sha256(text.encode()).hexdigest()[:5]

def signal(text,family,source='cycle~ 137',extra=(),notes=''):
    g=Graph();driver=g.box(source);obj=g.box(text);g.wire(driver,obj)
    for inlet,value in extra:
        p=g.box('sig~ '+str(value));g.wire(p,obj,inlet=inlet)
    gain=g.box('*~ 0.05');g.wire(obj,gain);g.output(gain)
    return Case(text,family,g.document(),[text],notes=notes)

def oscillator(text):
    g=Graph();freq=g.box('param frequency 137 @min 40 @max 600 @displayorder 1')
    obj=g.box(text);g.wire(freq,obj);gain=g.box('*~ 0.05');g.wire(obj,gain);g.output(gain)
    return Case(text,'oscillators',g.document(),[text],assertion='audible')

def control(text,family='event math',initial=.3,minimum=.1,maximum=.8,list_output=False,notes=''):
    g=Graph();p=g.box(f'param stimulus {initial} @min {minimum} @max {maximum} @displayorder 1')
    obj=g.box(text)
    if text.startswith('list.'):
        packed=g.box('pack 0. 0.3 0.1 0.2');g.wire(p,packed);g.wire(packed,obj)
    else:g.wire(p,obj)
    if list_output:
        unpack=g.box('unpack 0. 0. 0. 0.');g.wire(obj,unpack);obj=unpack
    sig=g.box('sig~');gain=g.box('*~ 0.001');g.wire(obj,sig);g.wire(sig,gain);g.output(gain)
    return Case(text,family,g.document(),[text],notes=notes)

def codebox(name,code,source='cycle~ 137',family='codebox'):
    g=Graph();driver=g.box(source)
    obj=g.box('codebox~',rnbo_classname='codebox~',rnbo_extra_attributes={'code':code})
    g.wire(driver,obj);gain=g.box('*~ 0.05');g.wire(obj,gain);g.output(gain)
    return Case(name,family,g.document(),['codebox~'],notes='Codebox syntax is validated by the pinned compiler, not inferred from a generated graph.')

def nested(depth=1,branch=False,voices=1):
    child=Graph();inp=child.box('in~ 1');gain=child.box('*~ 0.5');child.wire(inp,gain);child.wire(gain,child.box('out~ 1'))
    for n in range(depth-1):
        outer=Graph();i=outer.box('in~ 1');p=outer.box('p inner'+str(n),patcher=child.document()['patcher']);o=outer.box('out~ 1');outer.wire(i,p);outer.wire(p,o);child=outer
    g=Graph();src=g.box('cycle~ 137');p=g.box('p inner',patcher=child.document()['patcher']);g.wire(src,p)
    if branch:
        q=g.box('p other',patcher=child.document()['patcher']);g.wire(src,q);s=g.box('+~');g.wire(p,s);g.wire(q,s,inlet=1);p=s
    gain=g.box('*~ 0.05');g.wire(p,gain);g.output(gain)
    return Case(f'nested {depth} branch {branch}','structures',g.document(),['p'],assertion='audible')

def voices(count):
    g=Graph();n=g.box('notein');f=g.box('expr 440. * exp((in1 - 69.) * 0.0577622650466621)');v=g.box('/ 127.');s=g.box('cycle~');a=g.box('adsr~ 2 15 0.5 40');m=g.box('*~');level=g.box('*~ 0.03')
    g.wire(n,f);g.wire(f,s);g.wire(n,v,outlet=1);g.wire(v,a);g.wire(s,m);g.wire(a,m,inlet=1);g.wire(m,level);g.output(level)
    return Case(f'polyphony {count}','structures',g.document(),['notein','adsr~','cycle~'],assertion='audible',config=dict(voices=count,fast_phase=True,float32_delays=True,shared_fx=False,pool_bytes=114688))

def make_cases():
    cases=[]
    for text in ['cycle~','phasor~','saw~','tri~','rect~']:
        cases.append(oscillator(text))
    for text in ['noise~','pink~']:
        g=Graph();o=g.box(text);m=g.box('*~ 0.03');g.wire(o,m);g.output(m);cases.append(Case(text,'oscillators',g.document(),[text],assertion='audible'))
    for text in ['+~ 0.2','-~ 0.2','*~ 0.5','/~ 2.','%~ 2.','abs~','acos~','asin~','atan~','atan2~ 1.','cos~','sin~','tan~','cosh~','sinh~','tanh~','exp~','log~','log2~','log10~','pow~ 2.','sqrt~','ceil~','floor~','round~','trunc~','min~ 0.5','max~ 0.5','clip~ -0.5 0.5','wrap~ 0. 1.','fold~ -0.5 0.5','scale~ -1. 1. 0. 1.','>~ 0.','>=~ 0.','<~ 0.','<=~ 0.','==~ 0.','!=~ 0.','!~','&&~','||~']:
        src='sig~ 0.25' if text.split()[0] in ['log~','log2~','log10~','sqrt~','acosh~'] else 'cycle~ 137'
        cases.append(signal(text,'signal math',source=src))
    for text in ['delta~','change~','dcblock~','slide~ 5 10','rampsmooth~ 20 40','sah~ 0.','downsamp~ 4','latch~','onepole~ 1000','butterworth~ 1000','lores~ 1000 0.5','svf~ 1000 0.5','biquad~ 0.5 0. 0. 0. 0.','reson~ 1000 10.','average~ 32','average_rms~ 32','peakamp~ 10','snapshot~ 10','zerox~']:
        cases.append(signal(text,'filters/state'))
    for text in ['mtof~','ftom~','dbtoa~','atodb~','mstosamps~','sampstoms~','sah~']:
        cases.append(signal(text,'conversions',source='sig~ 0.25'))
    for text in ['+ 0.2','- 0.2','* 0.5','/ 2.','% 2.','abs','acos','asin','atan','atan2 1.','cos','sin','tan','cosh','sinh','tanh','exp','log','log2','log10','pow 2.','sqrt','ceil','floor','round','trunc','min 0.5','max 0.5','clip 0.1 0.7','wrap 0. 1.','fold 0. 1.','scale 0. 1. 0. 0.5','> 0.5','>= 0.5','< 0.5','<= 0.5','== 0.5','!= 0.5','!','&& 1','|| 1','and 1','or 1','xor 1','fixnan','fixdenorm','mtof','ftom','dbtoa','atodb','mstosamps','sampstoms','mstosamps 44100','expr in1 * 0.5 + 0.1','expr sin(in1) + cos(in1) * 0.1']:
        cases.append(control(text))
    for text in ['float 0.2','int 2','change','accum 0.','counter 0 15','gate 1 1','switch 1 1','select 1','split 0.2 0.7','clip 0.2 0.7','trigger f f','t f f','route 1 2','prepend 1','append 1','pack 0. 1.','unpack 0. 1.','list.len','list.sum','list.median','list.thin','list.unique','list.rev','list.sort','list.slice 2','list.reg 1 2 3','list.join','list.nth 1']:
        cases.append(control(text,'events/lists',list_output=text.startswith(('prepend','append','pack ','list.rev','list.thin','list.unique','list.sort','list.slice','list.reg','list.join'))))
    for kind in ['metro','delay','pipe','line','line~','timer']:
        g=Graph();bang=g.box('loadbang')
        message=g.box('0.5 20' if kind.startswith('line') else '0.5' if kind=='pipe' else '1',maxclass='message');g.wire(bang,message)
        clock=g.box(kind+(' 10' if kind in ['metro','delay','pipe'] else ''));g.wire(message,clock)
        if kind=='timer':
            d=g.box('delay 20');g.wire(bang,d);g.wire(d,clock,inlet=1)
        if kind in ['metro','delay']:
            counter=g.box('counter 1 7');g.wire(clock,counter);clock=counter
        gain=g.box('*~ 0.001');g.wire(clock,gain);g.output(gain)
        cases.append(Case('scheduled '+kind,'scheduler',g.document(),[kind],assertion='audible'))
    for length in [64,256,1024,4096]:
        g=Graph();s=g.box('cycle~ 137');d=g.box(f'delay~ {length} {max(1,length//2)}');g.wire(s,d);m=g.box('*~ 0.05');g.wire(d,m);g.output(m)
        cases.append(Case(f'delay {length}','delay/memory',g.document(),['delay~'],assertion='audible'))
    for text in ['delay~ 2048 128 @interp none','allpass~ 16 0.5','comb~ 16 0.5 0.5 0.5']:
        cases.append(signal(text,'delay/memory'))
    for count in [0,1,8,16,17]:
        g=Graph();o=g.box('cycle~ 137');m=g.box('*~ 0.02');g.wire(o,m)
        for n in range(count):
            p=g.box(f'param p{n} 0.5 @min 0 @max 1 @displayorder {n+1}');gain=g.box('*~');g.wire(m,gain);g.wire(p,gain,inlet=1);m=gain
        g.output(m);cases.append(Case(f'parameters {count}','boundaries',g.document(),['param'] if count else [],expectation='reject' if count>16 else 'pass'))
    for text in ['param cutoff 1000 @min 40 @max 12000 @exponent 2 @unit Hz','param mode 1 @enum off on auto','param steps 0.5 @min 0 @max 1 @steps 5','param~ level 0.25 @min 0 @max 1']:
        g=Graph();p=g.box(text);m=g.box('*~ 0.001');g.wire(p,m);g.output(m);cases.append(Case(text,'parameters',g.document(),[text]))
    cases.extend([nested(1),nested(2),nested(3),nested(1,True),nested(3,True)])
    cases.extend(voices(n) for n in [1,2,4])
    cases.extend([
        codebox('codebox arithmetic','out1 = in1 * 0.5;'),
        codebox('codebox functions','out1 = tanh(in1) + sin(in1) * 0.1;'),
        codebox('codebox branch','if (in1 > 0) { out1 = in1; } else { out1 = -in1; }'),
        codebox('codebox bounded loop','let sum = 0; for (let i = 0; i < 4; i += 1) { sum += in1 * 0.125; } out1 = sum;'),
        codebox('codebox history','@state previous = 0; out1 = in1 - previous; previous = in1;')])
    # Internal event and signal routing are different from unsupported host ports.
    for signal_route in [False,True]:
        g=Graph();src=g.box('cycle~ 137' if signal_route else 'param stimulus 0.25 @min 0.1 @max 0.5');send=g.box('send~ wire' if signal_route else 'send wire');receive=g.box('receive~ wire' if signal_route else 'receive wire');g.wire(src,send)
        if not signal_route:
            sig=g.box('sig~');g.wire(receive,sig);receive=sig
        m=g.box('*~ 0.05');g.wire(receive,m);g.output(m)
        cases.append(Case('internal '+('signal' if signal_route else 'event')+' routing','routing',g.document(),['send~','receive~'] if signal_route else ['send','receive']))
    # Signal and event fan-out/summing, feedback cycles broken by feedback~.
    g=Graph();src=g.box('cycle~ 137');s=g.box('+~');a=g.box('*~ 0.3');b=g.box('*~ 0.2');g.wire(src,a);g.wire(src,b);g.wire(a,s);g.wire(b,s,inlet=1);m=g.box('*~ 0.05');g.wire(s,m);g.output(m);cases.append(Case('fanout fanin','structures',g.document(),['+~','*~'],assertion='audible'))
    g=Graph();src=g.box('cycle~ 137');f=g.box('feedback~');mul=g.box('*~ 0.3');s=g.box('+~');d=g.box('delay~ 1024 64');g.wire(src,s);g.wire(f,mul);g.wire(mul,s,inlet=1);g.wire(s,d);g.wire(d,f);m=g.box('*~ 0.03');g.wire(s,m);g.output(m);cases.append(Case('feedback loop','structures',g.document(),['feedback~','delay~','+~'],assertion='audible'))
    for unit in ['notein','ctlin','bendin','touchin','polyin','pgmin']:
        g=Graph();n=g.box(unit);gain=g.box('*~ 0.001');g.wire(n,gain);g.output(gain);cases.append(Case(unit,'MIDI',g.document(),[unit]))
    for storage in ['data memory 256 1 @external 0','buffer~ memory 256 1']:
        for interpolation in ['none','linear','cubic']:
            g=Graph();data=g.box(storage);phase=g.box('phasor~ 137');index=g.box('*~ 255');g.wire(phase,index)
            writer=g.box('poke~ memory');g.wire(phase,writer);g.wire(index,writer,inlet=1)
            reader=g.box('peek~ memory @interp '+interpolation);g.wire(index,reader);gain=g.box('*~ 0.03');g.wire(reader,gain);g.output(gain)
            cases.append(Case(storage+' '+interpolation,'data/buffers',g.document(),[storage.split()[0],'poke~','peek~'],assertion='audible',notes='Bounded local buffer; no file loading or host memory required.'))
    for size in [16,17,32,64]:
        g=Graph();param=g.box('param stimulus 0.25 @min 0.1 @max 0.5');pack=g.box('pack '+' '.join('0.' for _ in range(size)));g.wire(param,pack)
        length=g.box('list.len');g.wire(pack,length);gain=g.box('*~ 0.001');g.wire(length,gain);g.output(gain)
        cases.append(Case('list capacity '+str(size),'boundaries',g.document(),['pack','list.len'],assertion='constant:'+str(size*.001),notes='16 is the inline list capacity, not a hard maximum. Static larger lists may allocate during initialization. Output must report the full length.'))
        g=Graph();param=g.box('param stimulus 0.25 @min 0.1 @max 0.5');pack=g.box('pack '+' '.join('0.' for _ in range(size)));store=g.box('list.reg');reverse=g.box('list.rev');length=g.box('list.len');gain=g.box('*~ 0.001')
        g.wire(param,pack);g.wire(pack,store);g.wire(store,reverse);g.wire(reverse,length);g.wire(length,gain);g.output(gain)
        cases.append(Case('list copy capacity '+str(size),'boundaries',g.document(),['pack','list.reg','list.rev','list.len'],assertion='constant:'+str(size*.001),notes='Tests copying/reversing lists after initialization; heap growth at audio time is rejected even when initial storage fits.'))
    g=Graph();param=g.box('param stimulus 0.25 @min 0.1 @max 0.5');cb=g.box('codebox',rnbo_extra_attributes={'code':'out1 = in1 * 0.5;'});gain=g.box('*~ 0.01');g.wire(param,cb);g.wire(cb,gain);g.output(gain)
    cases.append(Case('event codebox','codebox',g.document(),['codebox'],assertion='audible'))
    child=Graph();bang=child.box('loadbang');one=child.box('1',maxclass='message');metro=child.box('metro 10');counter=child.box('counter 1 7');gain=child.box('*~ 0.001');child.wire(bang,one);child.wire(one,metro);child.wire(metro,counter);child.wire(counter,gain);child.wire(gain,child.box('out~ 1'))
    g=Graph();sub=g.box('p clocks',patcher=child.document()['patcher']);g.output(sub)
    cases.append(Case('nested scheduler target','structures',g.document(),['p'],assertion='audible',notes='Exercises clocks addressed to an embedded patcher rather than only the root.'))
    gen=Graph();a=gen.box('in 1');b=gen.box('* 0.5');c=gen.box('out 1');gen.wire(a,b);gen.wire(b,c);nested_gen=gen.document()['patcher'];nested_gen['classnamespace']='dsp.gen'
    g=Graph();osc=g.box('cycle~ 137');obj=g.box('gen~',patcher=nested_gen);gain=g.box('*~ 0.03');g.wire(osc,obj);g.wire(obj,gain);g.output(gain)
    cases.append(Case('embedded Gen integration','structures',g.document(),['gen~'],notes='Embedded arithmetic graph translated to GenExpr; unsupported graph operators remain explicit errors.'))

    gen=Graph();a=gen.box('in 1');h=gen.box('history previous 0.25');s=gen.box('+');m=gen.box('* 0.98');o=gen.box('out 1')
    gen.wire(a,s);gen.wire(h,s,inlet=1);gen.wire(s,m);gen.wire(m,h);gen.wire(h,o)
    nested_gen=gen.document()['patcher'];nested_gen['classnamespace']='dsp.gen'
    g=Graph();osc=g.box('cycle~ 137');level=g.box('*~ 0.01');obj=g.box('gen~',patcher=nested_gen);gain=g.box('*~ 0.03')
    g.wire(osc,level);g.wire(level,obj);g.wire(obj,gain);g.output(gain)
    cases.append(Case('embedded Gen History feedback','structures',g.document(),['gen~'],assertion='audible',notes='One-sample feedback with nonzero initial state; independent GenExpr audio comparison is in gen_feedback.py.'))
    # Expected bridge boundaries: rejected distinctly from object compiler faults.
    for channels in [1,3]:
        g=Graph();s=g.box('cycle~ 137');m=g.box('*~ 0.02');g.wire(s,m)
        for ch in range(1,channels+1):g.wire(m,g.box(f'out~ {ch}'))
        cases.append(Case(f'output channels {channels}','boundaries',g.document(),['out~'],expectation='reject'))
    g=Graph();s=g.box('in~ 1');osc=g.box('cycle~ 137');mix=g.box('+~');g.wire(s,mix);g.wire(osc,mix,inlet=1);g.output(mix);cases.append(Case('audio input boundary','boundaries',g.document(),['in~'],expectation='reject'))
    # Each source stays isolated; names never select an existing instrument module.
    assert len({slug(c.name) for c in cases})==len(cases)
    return cases

def validate(case):
    p=case.patch['patcher'];ids={b['box']['id'] for b in p['boxes']};edges={i:set() for i in ids}
    if len(ids)!=len(p['boxes']):raise ValueError('Duplicate object id')
    for entry in p['lines']:
        line=entry['patchline'];a,b=line['source'],line['destination']
        if a[0] not in ids or b[0] not in ids or min(a[1],b[1])<0:raise ValueError('Invalid connection')
        edges[a[0]].add(b[0])
    outputs={b['box']['id'] for b in p['boxes'] if b['box'].get('text','').startswith('out~ ')}
    def reaches(i,seen):
        if i in outputs:return True
        if i in seen:return False
        seen.add(i);return any(reaches(j,seen) for j in edges[i])
    # Routing crosses an implicit named edge.
    for entry in p['boxes']:
        b=entry['box'];text=b.get('text','')
        if text.startswith(('send ','send~ ')):
            wanted=('receive~ ' if text.startswith('send~ ') else 'receive ')+text.split()[1]
            edges[b['id']].update(e['box']['id'] for e in p['boxes'] if e['box'].get('text')==wanted)
    buffers={b['box']['text'].split()[1]:b['box']['id'] for b in p['boxes'] if b['box'].get('text','').startswith(('data ','buffer~ '))}
    for name,ident in buffers.items():
        for entry in p['boxes']:
            b=entry['box'];words=b.get('text','').split()
            if len(words)>1 and words[1]==name:
                if words[0]=='poke~':edges[b['id']].add(ident)
                elif words[0]=='peek~':edges[ident].add(b['id'])
    for name in case.objects:
        first=name.split()[0]
        subjects=[b['box']['id'] for b in p['boxes'] if b['box'].get('text','').split()[0]==first]
        if not subjects or not any(reaches(i,set()) for i in subjects):raise ValueError('Claimed object is disconnected: '+name)
    return True
