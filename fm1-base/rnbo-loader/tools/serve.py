#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Loopback-only Studio server, with optional local RNBO compilation."""
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import argparse
import hashlib
import json
import secrets
import threading
from urllib.parse import urlsplit

APP = Path(__file__).resolve().parents[1]
ROOT = APP / 'web'


def root_id(root, builder):
    return hashlib.sha256((str(Path(root).resolve()) + ':' + str(builder)).encode()).hexdigest()[:16]


class Handler(SimpleHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server, directory=str(server.web_root))

    def end_headers(self):
        self.send_header('Cache-Control', 'no-store')
        self.send_header('X-Content-Type-Options', 'nosniff')
        self.send_header('X-Frame-Options', 'DENY')
        self.send_header('Content-Security-Policy', "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; connect-src 'self'; frame-ancestors 'none'")
        super().end_headers()

    def allowed_host(self):
        return self.headers.get('Host') in (f'localhost:{self.server.server_port}', f'127.0.0.1:{self.server.server_port}')

    def authenticated(self, write=False):
        if not self.allowed_host():
            return False
        if not secrets.compare_digest(self.headers.get('X-FM1-Token', ''), self.server.token):
            return False
        return not write or self.headers.get('Origin') in (f'http://localhost:{self.server.server_port}', f'http://127.0.0.1:{self.server.server_port}')

    def response(self, status, data):
        raw = json.dumps(data).encode()
        self.send_response(status)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(raw)))
        self.end_headers()
        self.wfile.write(raw)

    def do_GET(self):
        if not self.allowed_host():
            return self.response(403, {'error': 'Use the local uploader address.'})
        path = urlsplit(self.path).path
        if path == '/api/session':
            return self.response(200, {'version': 2, 'studio_version': 1, 'token': self.server.token,
                                      'builder': self.server.builds is not None, 'root_id': self.server.root_id,
                                      'build_options': ['filter_delay_max_ms'] if self.server.builds else []})
        if path.startswith('/api/'):
            if not self.authenticated():
                return self.response(403, {'error': 'Reopen Studio to reconnect to the build service.'})
            if not self.server.builds:
                return self.response(404, {'error': 'Open Studio from the source checkout to convert RNBO patches.'})
            parts = path.strip('/').split('/')
            if len(parts) not in (3, 4) or parts[:2] != ['api', 'jobs']:
                return self.response(404, {'error': 'Unknown build endpoint.'})
            try:
                if len(parts) == 3:
                    return self.response(200, self.server.builds.snapshot(parts[2]))
                if parts[3] != 'module':
                    return self.response(404, {'error': 'Unknown build endpoint.'})
                data = self.server.builds.download(parts[2])
                self.send_response(200)
                self.send_header('Content-Type', 'application/octet-stream')
                self.send_header('Content-Length', str(len(data)))
                self.end_headers()
                self.wfile.write(data)
                return
            except KeyError:
                return self.response(404, {'error': 'Build not found or not ready.'})
            except ValueError as e:
                return self.response(409, {'error': str(e)})
        if path == '/catalogue.json' and self.server.catalogue is not None:
            return self.response(200, self.server.catalogue)
        if path == '/':
            path = '/module-loader.html'
        relative = path.lstrip('/')
        if relative not in self.server.assets:
            return self.response(404, {'error': 'Not found.'})
        target = self.server.assets[relative]
        # A fixed allowlist includes only public web assets, never the source tree.
        self.send_response(200)
        self.send_header('Content-Type', self.guess_type(str(target)))
        self.send_header('Content-Length', str(target.stat().st_size))
        self.end_headers()
        with target.open('rb') as stream:
            self.copyfile(stream, self.wfile)

    def do_HEAD(self):
        self.send_error(405)

    def do_POST(self):
        if not self.authenticated(write=True):
            return self.response(403, {'error': 'Open this page using the Studio launcher.'})
        if self.path == '/api/quit':
            if self.server.builds and self.server.builds.active:
                return self.response(409, {'error': 'Wait for the active build to finish.'})
            self.response(200, {'stopped': True})
            threading.Thread(target=self.server.shutdown, daemon=True).start()
            return
        if self.path != '/api/build' or self.server.builds is None:
            return self.response(404, {'error': 'Local builder is unavailable.'})
        try:
            length = int(self.headers.get('Content-Length', '0'))
            if not 0 < length <= 8 * 1024 * 1024:
                return self.response(413, {'error': 'Patch upload is too large (maximum source size: 4 MiB).'})
            if self.headers.get_content_type() != 'application/json':
                return self.response(415, {'error': 'Expected a JSON build request.'})
            body = json.loads(self.rfile.read(length))
            ident = self.server.builds.start(body)
            return self.response(202, {'id': ident})
        except BlockingIOError as e:
            return self.response(409, {'error': str(e)})
        except (ValueError, RecursionError) as e:
            return self.response(400, {'error': str(e)})


def make_server(port=8768, service=None, web_root=None, builder=True):
    root = Path(web_root or ROOT).resolve()
    if builder and service is None:
        from build_service import BuildService
        service = BuildService()
    server = ThreadingHTTPServer(('127.0.0.1', port), Handler)
    server.builds = service if builder else None
    server.token = service.token if server.builds else secrets.token_urlsafe(32)
    server.web_root = root
    server.root_id = root_id(root, builder)
    server.assets = {str(p.relative_to(root)): p for p in root.rglob('*')
                     if p.is_file() and not p.is_symlink() and p.resolve().is_relative_to(root)}
    server.catalogue = None
    if root == ROOT and builder:
        server.assets = {name: root / name for name in ('module-loader.html', 'module-loader.js', 'studio.js')}
        for name in ('fm1ota.js', 'fm1pkg.js'):
            server.assets[name] = APP.parent / 'web' / name
        manifest = APP / 'hardware-tests/manifest.json'
        if manifest.exists():
            cases = json.loads(manifest.read_text())['patches']
            server.catalogue = {'format': 1, 'patches': [{k: c[k] for k in
                                 ('id', 'title', 'bank', 'slot', 'kind', 'listen', 'parameters')} for c in cases]}
    if builder:
        # Use the current converter UI even when serving an older release's
        # firmware/library assets. Static portable bundles remain self-contained.
        for name in ('module-loader.html', 'module-loader.js', 'studio.js'):
            server.assets[name] = ROOT / name
        server.assets['index.html'] = ROOT / 'module-loader.html'
    return server


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', type=int, default=8768)
    parser.add_argument('--no-open', action='store_true')
    parser.add_argument('--release', type=Path)
    parser.add_argument('--static', action='store_true')
    args = parser.parse_args()
    server = make_server(args.port, web_root=args.release, builder=not args.static)
    url = f'http://localhost:{server.server_port}/module-loader.html'
    print(url, flush=True)
    if not args.no_open:
        from launch import open_browser
        open_browser(url)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        if server.builds:
            server.builds.stopping.set()
        server.server_close()


if __name__ == '__main__':
    main()
