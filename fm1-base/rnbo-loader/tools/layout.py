"""Compile Max patch coordinates into a bounded, read-only FM1 overview.

Subpatchers stay as boxes: their internals are not flattened into the parent.
The original .rnbopat is never rewritten. No third-party rendering libraries.
"""
import json
import math
import struct
import zlib
from pathlib import Path

MAGIC = 0x31564952
FOOTER = 0x31545652
WIDTH, HEIGHT = 240, 166
MAX_NODES, MAX_SEGMENTS = 96, 384
NODE_GEN = 1  # Node byte 7; zero remains the legacy RNBO/default style.


def ascii_text(value, size):
    return str(value or '').encode('ascii', 'replace')[:size-1].ljust(size, b'\0')


def compile_layout(source, description):
    patch = json.loads(Path(source).read_text())['patcher']
    params = description.get('parameters', [])[:16]
    identities = {p.get('paramId', p.get('name')): i for i, p in enumerate(params)}
    boxes = [v['box'] for v in patch.get('boxes', []) if v['box'].get('maxclass') not in ('comment', 'panel')]
    if len(boxes) > MAX_NODES:
        # Explicit, safe list fallback rather than silently omitting circuitry.
        return None, {'available': False, 'reason': 'More than 96 objects'}
    if not boxes:
        return None, {'available': False, 'reason': 'No objects'}
    entries = []
    for b in boxes:
        text = b.get('text') or b.get('rnbo_classname') or b.get('maxclass', '?')
        words = text.split()
        gen_context = patch.get('classnamespace') == 'dsp.gen'
        gen_container = words[0] in ('gen', 'gen~') or (b.get('patcher') or {}).get('classnamespace') == 'dsp.gen'
        flags = NODE_GEN if gen_context or gen_container else 0
        is_param = words[0] == 'param' and len(words) > 1
        parameter = identities.get(words[1], 255) if is_param else 255
        label = (params[parameter].get('displayName') or words[1]).title() if parameter != 255 else (words[1].title() if is_param else words[0])
        if gen_container:
            label = 'gen' if gen_context else 'gen~'
        elif b.get('patcher'):
            label = 'Subpatch'
        if words[0] == 'expr' and '440.' in text and '69.' in text:
            label = 'MIDI > Hz'
        if words[0] in ('out~', 'in~') and len(words) > 1:
            label += ' ' + words[1]
        rect = b.get('patching_rect', [0, len(entries)*35, 60, 23])
        if len(rect) != 4 or not all(isinstance(v, (int, float)) and math.isfinite(v) for v in rect):
            raise ValueError('Invalid patching_rect')
        entries.append((b, label[:15], parameter, rect, flags))
    # Preserve object anchor positions, but fit compact labels instead of long
    # @attribute declarations. A minimum-size Arial face is used on the device.
    xmin = min(e[3][0] for e in entries)
    ymin = min(e[3][1] for e in entries)
    xmax = max(e[3][0] for e in entries)
    ymax = max(e[3][1] for e in entries)
    xscale = 142 / max(1, xmax-xmin)
    yscale = (HEIGHT-14) / max(1, ymax-ymin)
    nodes, lookup = [], {}
    for b, label, parameter, rect, flags in entries:
        x = round(4+(rect[0]-xmin)*xscale)
        y = round(2+(rect[1]-ymin)*yscale)
        w = max(16, min(88, 6+len(label)*4))
        node = [x, y, w, 12, parameter, min(32, int(b.get('numinlets', 1))), min(32, int(b.get('numoutlets', 1))), flags, label]
        lookup[b['id']] = node
        nodes.append(node)
    # Compression can make neighbouring labels collide. Move a compact box
    # the shortest available distance, then attach its cords to the new ports.
    # Keep this deterministic; do not silently accept unreadable overlaps.
    placed = []
    for node in sorted(nodes, key=lambda n: (n[1], n[0])):
        original = node[:2]
        candidates = {(node[0], node[1])}
        for other in placed:
            for x in (node[0], other[0]+other[2]+2):
                for y in (node[1], other[1]+other[3]+2):
                    candidates.add((x, y))
        def clear(x, y):
            return all(x+node[2]+1<=b[0] or b[0]+b[2]+1<=x or y+node[3]+1<=b[1] or b[1]+b[3]+1<=y for b in placed)
        positions = [(x,y) for x,y in candidates if x+node[2]<=WIDTH and y+node[3]<=HEIGHT and clear(x,y)]
        if not positions:
            return None, {'available': False, 'reason': 'Object labels cannot fit legibly'}
        node[0],node[1] = min(positions,key=lambda p:(abs(p[0]-original[0])+abs(p[1]-original[1]),p[1],p[0]))
        placed.append(node)
    segments = []
    for entry in patch.get('lines', []):
        line = entry['patchline']
        src, dst = lookup.get(line['source'][0]), lookup.get(line['destination'][0])
        if src is None or dst is None:
            continue
        def port(n, index, count):
            return n[0]+min(n[2]-3, 3+round(max(0, index)*(n[2]-6)/max(1, count-1)))
        points = [(port(src, line['source'][1], src[6]), src[1]+src[3]-1)]
        mids = line.get('midpoints', [])
        for i in range(0, len(mids)-1, 2):
            points.append((max(0, min(239, round(4+(mids[i]-xmin)*xscale))), max(0, min(165, round(2+(mids[i+1]-ymin)*yscale)))))
        points.append((port(dst, line['destination'][1], dst[5]), dst[1]))
        segments.extend([list(a+b) for a, b in zip(points, points[1:])])
    if len(segments) > MAX_SEGMENTS:
        return None, {'available': False, 'reason': 'More than 384 wire segments'}
    data = struct.pack('<I6H', MAGIC, 1, len(nodes), len(segments), len(params), WIDTH, HEIGHT)
    data += b''.join(struct.pack('<8B16s', *n[:8], ascii_text(n[8], 16)) for n in nodes)
    data += b''.join(bytes(s) for s in segments)
    data += b''.join(ascii_text(p.get('unit', ''), 12) for p in params)
    return data, dict(available=True, nodes=nodes, segments=segments, parameters=[p.get('name') for p in params], bytes=len(data))


def write_layout(source, description, out):
    data, report = compile_layout(source, description)
    out = Path(out)
    (out/'visual.json').write_text(json.dumps(report, indent=2)+'\n')
    data = data or b''
    (out/'visual.bin').write_bytes(data)
    # Host simulator accesses exactly the same serialized data as the target.
    (out/'visual.h').write_text('extern "C" {\nextern const unsigned int __attribute__((visibility("default"))) rnbo_visual_bytes = '+str(len(data))+'u;\nextern const unsigned char __attribute__((visibility("default"))) rnbo_visual[] = {'+(','.join(map(str, data)) or '0')+'};\n}\n')
    return report


def append_layout(image, data, actual_function):
    if not data:
        return image
    data += b'\0' * (-len(data) % 4)
    return image + data + struct.pack('<4I', FOOTER, len(data), zlib.crc32(data), actual_function)
