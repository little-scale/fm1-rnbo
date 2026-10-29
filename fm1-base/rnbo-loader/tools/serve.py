#!/usr/bin/env python3
"""Browser uploader and loopback-only RNBO build service."""
from http.server import SimpleHTTPRequestHandler,ThreadingHTTPServer
from pathlib import Path
import argparse
import errno
import json
import secrets
import subprocess
import webbrowser
from urllib.parse import urlsplit
from urllib.request import urlopen
from build_service import BuildService

ROOT=Path(__file__).resolve().parents[1]/'web'

class Handler(SimpleHTTPRequestHandler):
    def __init__(self,*args,**kw):super().__init__(*args,directory=str(ROOT),**kw)
    def end_headers(self):
        self.send_header('Cache-Control','no-store');self.send_header('X-Content-Type-Options','nosniff')
        self.send_header('X-Frame-Options','DENY')
        self.send_header('Content-Security-Policy',"default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; connect-src 'self'; frame-ancestors 'none'")
        super().end_headers()
    def allowed_host(self):
        return self.headers.get('Host') in (f'localhost:{self.server.server_port}',f'127.0.0.1:{self.server.server_port}')
    def authenticated(self,write=False):
        if not self.allowed_host():return False
        if not secrets.compare_digest(self.headers.get('X-FM1-Token',''),self.server.builds.token):return False
        if write and self.headers.get('Origin') not in (f'http://localhost:{self.server.server_port}',f'http://127.0.0.1:{self.server.server_port}'):return False
        return True
    def response(self,status,data):
        raw=json.dumps(data).encode();self.send_response(status);self.send_header('Content-Type','application/json')
        self.send_header('Content-Length',str(len(raw)));self.end_headers();self.wfile.write(raw)
    def do_GET(self):
        if not self.allowed_host():return self.response(403,{'error':'Use the local uploader address.'})
        path=urlsplit(self.path).path
        if path=='/api/session':return self.response(200,{'version':2,'token':self.server.builds.token,'builder':True})
        if path.startswith('/api/'):
            if not self.authenticated():return self.response(403,{'error':'Reopen the local uploader to reconnect to the build service.'})
            parts=path.strip('/').split('/')
            if len(parts) not in (3,4) or parts[:2]!=['api','jobs']:return self.response(404,{'error':'Unknown build endpoint.'})
            try:
                if len(parts)==3:return self.response(200,self.server.builds.snapshot(parts[2]))
                if parts[3]!='module':return self.response(404,{'error':'Unknown build endpoint.'})
                data=self.server.builds.download(parts[2]);self.send_response(200)
                self.send_header('Content-Type','application/octet-stream');self.send_header('Content-Length',str(len(data)));self.end_headers();self.wfile.write(data)
            except KeyError:return self.response(404,{'error':'Build not found or not ready.'})
            except ValueError as e:return self.response(409,{'error':str(e)})
        if path=='/':self.path='/module-loader.html'
        elif path not in ('/module-loader.html','/module-loader.js'):return self.response(404,{'error':'Not found.'})
        return super().do_GET()
    def do_HEAD(self):
        # No alternate path through SimpleHTTPRequestHandler's file server.
        self.send_error(405)
    def do_POST(self):
        if not self.authenticated(write=True):return self.response(403,{'error':'Open this page using the local uploader launcher.'})
        if self.path!='/api/build':return self.response(404,{'error':'Unknown build endpoint.'})
        try:
            length=int(self.headers.get('Content-Length','0'))
            if not 0<length<=8*1024*1024:return self.response(413,{'error':'Patch upload is too large (maximum source size: 4 MiB).'})
            if self.headers.get_content_type()!='application/json':return self.response(415,{'error':'Expected a JSON build request.'})
            body=json.loads(self.rfile.read(length))
            ident=self.server.builds.start(body);return self.response(202,{'id':ident})
        except BlockingIOError as e:return self.response(409,{'error':str(e)})
        except (ValueError,RecursionError) as e:return self.response(400,{'error':str(e)})


def make_server(port=8768,service=None):
    server=ThreadingHTTPServer(('127.0.0.1',port),Handler);server.builds=service or BuildService();return server


def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--port',type=int,default=8768);parser.add_argument('--no-open',action='store_true');args=parser.parse_args()
    url=f'http://localhost:{args.port}/module-loader.html'
    try:server=make_server(args.port)
    except OSError as e:
        if e.errno!=errno.EADDRINUSE:raise
        with urlopen(f'http://localhost:{args.port}/api/session',timeout=2) as response:info=json.load(response)
        if info.get('version')!=2 or not info.get('builder'):raise RuntimeError('This port belongs to an older uploader. Close its Terminal window and reopen this launcher.')
        server=None
    print(url+' — use Chrome or Edge. Keep this Terminal window open while building.',flush=True)
    if not args.no_open:
        for app in ('/Applications/Google Chrome.app','/Applications/Microsoft Edge.app'):
            if Path(app).exists():subprocess.Popen(['open','-a',app,url]);break
        else:webbrowser.open(url)
    if server is None:return
    try:server.serve_forever()
    except KeyboardInterrupt:pass
    finally:server.builds.stopping.set();server.server_close()

if __name__=='__main__':main()
