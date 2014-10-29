from routes import Mapper

import ppp_core
import example_ppp_module as flower

class Application:
    def __init__(self):
        self.mapper = Mapper()
        self.mapper.connect('core', '/core', app=ppp_core.app)
        self.mapper.connect('flower', '/flower', app=flower.app)

    def __call__(self, environ, start_response):
        match = self.mapper.routematch(environ=environ)
        app = match[0]['app'] if match else self.not_found
        return app(environ, start_response)

    def not_found(self, environ, start_response):
        headers = [('Content-Type', 'text/plain')]
        start_response('404 Not Found', headers)
        return [b'Not found.']

app = Application()
