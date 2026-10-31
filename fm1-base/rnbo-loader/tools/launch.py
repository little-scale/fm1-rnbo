#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Open Studio, starting or reusing its local service without a Terminal window."""
import argparse
import json
from pathlib import Path
import subprocess
import sys
import time
from urllib.request import urlopen
import webbrowser
from serve import APP, ROOT, root_id


def session(port):
    try:
        with urlopen(f'http://127.0.0.1:{port}/api/session', timeout=.5) as response:
            return json.load(response)
    except (OSError, ValueError):
        return None


def open_browser(url):
    if sys.platform == 'darwin':
        for parent in (Path('/Applications'), Path.home() / 'Applications'):
            for name in ('Google Chrome.app', 'Microsoft Edge.app'):
                app = parent / name
                if app.exists():
                    subprocess.run(['open', '-a', str(app), url], check=True)
                    return
    webbrowser.open(url)


def compatible(info, identity, builder):
    return bool(info and info.get('studio_version') == 1 and info.get('root_id') == identity and
                (not builder or 'filter_delay_max_ms' in info.get('build_options', [])))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--release', type=Path)
    parser.add_argument('--static', action='store_true')
    parser.add_argument('--no-open', action='store_true')
    args = parser.parse_args()
    root = args.release
    pointer = APP / 'build/studio-latest.json'
    if root is None and pointer.is_file():
        root = Path(json.loads(pointer.read_text())['web_root'])
    if root is None and (APP / 'build/studio-release/web/release.json').is_file():
        root = APP / 'build/studio-release/web'
    root = (root or ROOT).resolve()
    if not (root / 'module-loader.html').is_file():
        raise SystemExit('Studio web files are missing: ' + str(root))
    identity = root_id(root, not args.static)
    logs = Path.home() / ('Library/Logs/FM1-RNBO' if sys.platform == 'darwin' else '.local/state/fm1-rnbo')
    logs.mkdir(parents=True, exist_ok=True)
    for port in range(8768, 8781):
        info = session(port)
        if compatible(info, identity, not args.static):
            break
        # Never terminate or reuse an unrelated service (including an older uploader).
        if info:
            continue
        command = [sys.executable, str(Path(__file__).with_name('serve.py')), '--port', str(port), '--no-open']
        if args.release or root != ROOT:
            command.extend(['--release', str(root)])
        if args.static:
            command.append('--static')
        with (logs / f'studio-{port}.log').open('a') as stream:
            proc = subprocess.Popen(command, stdout=stream, stderr=subprocess.STDOUT, start_new_session=True)
        for _ in range(50):
            if proc.poll() is not None:
                break
            info = session(port)
            if compatible(info, identity, not args.static):
                break
            time.sleep(.1)
        if compatible(info, identity, not args.static):
            break
        if proc.poll() is None:
            proc.terminate()
            proc.wait(timeout=5)
    else:
        raise SystemExit('Studio could not start. See ' + str(logs))
    url = f'http://localhost:{port}/module-loader.html'
    print(url)
    if not args.no_open:
        open_browser(url)


if __name__ == '__main__':
    main()
