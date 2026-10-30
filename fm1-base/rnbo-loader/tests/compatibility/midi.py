#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Check that each compiled MIDI receiver actually responds on three channels."""
import argparse,ctypes as C,importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('compat_probe',HERE/'probe.py');probe=importlib.util.module_from_spec(spec);spec.loader.exec_module(probe)

def main():
    p=argparse.ArgumentParser();p.add_argument('--report',type=Path,required=True);args=p.parse_args()
    root=args.report.resolve().parent;report=json.loads(args.report.read_text());results=[]
    for row in report['cases']:
        if row['family']!='MIDI':continue
        assert row['status']=='pass',row['name']
        lib=C.CDLL(str(root/row['artifact']),mode=C.RTLD_LOCAL);api=probe.Api.in_dll(lib,'rnbo_module')
        init=C.CFUNCTYPE(C.c_int)(api.init);midi=C.CFUNCTYPE(None,C.c_uint,C.c_uint,C.c_uint)(api.midi)
        render=C.CFUNCTYPE(None,C.POINTER(C.c_int),C.c_uint,C.c_uint)(api.render);audio=(C.c_int*512)()
        for channel in [0,1,15]:
            assert init()==1
            for status,a,b in [(0x90,60,96),(0xb0,1,96),(0xe0,0,96),(0xd0,96,0),(0xa0,60,96),(0xc0,64,0)]:midi(status|channel,a,b)
            peak=0
            for _ in range(16):render(audio,256,4096);peak=max(peak,max(map(abs,audio)))
            assert peak>16,(row['name'],channel,'No MIDI response')
            stats=probe.Stats();C.CFUNCTYPE(None,C.POINTER(probe.Stats))(api.stats)(C.byref(stats));assert not(stats.late or stats.errors or stats.bad_samples)
            results.append(dict(object=row['name'],channel=channel,peak=peak))
    assert len(results)==18
    (root/'midi-response.json').write_text(json.dumps(results,indent=2)+'\n');print('PASS',len(results),'compiled MIDI receiver/channel response checks (host API)')

if __name__=='__main__':main()
