#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Check collection completeness and stale evidence without RNBO or hardware."""
import ast
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent


def read_json(path):
    return json.loads(path.read_text())


def check_graph(patch):
    boxes = [item['box'] for item in patch['boxes']]
    identities = [box['id'] for box in boxes]
    assert len(identities) == len(set(identities)), 'Duplicate object ID'
    for item in patch['lines']:
        for endpoint in ('source', 'destination'):
            ident, port = item['patchline'][endpoint]
            assert ident in identities, f'Dangling {endpoint}: {ident}'
            assert type(port) is int and port >= 0, 'Invalid port'
    for box in boxes:
        if isinstance(box.get('patcher'), dict):
            check_graph(box['patcher'])


def graph_structure(patch):
    # Max rewrites object IDs when saving some polyphonic wrappers. Compare
    # connected topology and nested canvases using each canvas's box order.
    boxes = [item['box'] for item in patch['boxes']]
    index = {box['id']: i for i, box in enumerate(boxes)}
    edges = []
    for item in patch['lines']:
        source, destination = (item['patchline'][key]
                               for key in ('source', 'destination'))
        edges.append((index[source[0]], source[1], index[destination[0]], destination[1]))
    children = [(i, graph_structure(box['patcher'])) for i, box in enumerate(boxes)
                if isinstance(box.get('patcher'), dict)]
    return len(boxes), sorted(edges), children


def main():
    cases = read_json(ROOT / 'manifest.json')['patches']
    report = read_json(ROOT / 'HOST-RESULTS.json')
    evidence = {case['id']: case for case in report['patches']}
    assert len(cases) == 15 and len(evidence) == 15
    assert len({case['id'] for case in cases}) == 15
    assert {(case['bank'], case['slot']) for case in cases} == {
        (bank, slot) for bank in range(1, 6) for slot in range(1, 4)
    }
    for case in cases:
        ident = case['id']
        source = ROOT / case['source']
        assert source == ROOT / 'patches' / ident / (ident + '.rnbopat')
        assert read_json(source.parent / 'module.json') == case['config'], ident
        record = evidence[ident]
        assert record['source_sha256'] == hashlib.sha256(source.read_bytes()).hexdigest(), (
            ident + ': archived host evidence is stale; rerun the host collection'
        )
        assert record['build'] == 'pass' and record['audition'] == 'pass', ident
        assert record['hardware_test'] is False, 'Host evidence cannot claim hardware'
        patch = read_json(source)['patcher']
        check_graph(patch)
        parameters = [box['box'] for box in patch['boxes']
                      if box['box'].get('text', '').startswith('param ')]
        assert len(parameters) == len(case['parameters']) == 8, ident
        ordered = sorted(parameters, key=lambda box: int(
            re.search(r'@displayorder\s+(\d+)', box['text'])[1]))
        assert [box['text'].split()[1] for box in ordered] == [
            parameter['name'] for parameter in case['parameters']
        ], ident
        wrapper = read_json(ROOT / 'max' / (ident + '.maxpat'))['patcher']
        embedded = [item['box']['patcher'] for item in wrapper['boxes']
                    if item['box'].get('text', '').startswith('rnbo~')]
        assert len(embedded) == 1, ident
        check_graph(embedded[0])
        assert graph_structure(embedded[0]) == graph_structure(patch), ident
    for bank in range(1, 6):
        group = sorted((case for case in cases if case['bank'] == bank),
                       key=lambda case: case['slot'])
        expected = [case['id'] for case in group]
        build = (ROOT.parent / f'Build-Test-Group-{bank}.command').read_text()
        upload = (ROOT.parent / f'Upload-Test-Group-{bank}.command').read_text()
        assert f'--bank {bank}' in build and f'prepare-group-{bank}.log' in build
        declared = re.search(r'for slot, ident in enumerate\((\([^)]*\)), 1\):', upload)
        assert declared and list(ast.literal_eval(declared[1])) == expected, bank
        transfer = re.search(r'for rnbo_test_id in ([^;\n]+); do', upload)
        assert transfer and transfer[1].split() == expected, bank
        for guard in ('source_sha256', 'module.json', 'device-build-status.json',
                      'review.json', 'undefined_symbols', '--check', 'set -euo pipefail'):
            assert guard in upload, (bank, guard)
    print('PASS 15 source/config/Max/archived-hash checks and five bank/upload mappings')
    print('These are source/evidence checks, not fresh RNBO builds or hardware tests.')


if __name__ == '__main__':
    main()
