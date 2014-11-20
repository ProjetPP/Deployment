import traceback
from routes import Mapper

import ppp_core
import example_ppp_module as flower
import ppp_nlp_classical
import ppp_cas
#import ppp_nlp_ml_standalone

class Application:
    def __init__(self):
        self.mapper = Mapper()
        self.mapper.connect('core', '/core/', app=ppp_core.app)
        self.mapper.connect('nlp_classical', '/nlp_classical/', app=ppp_nlp_classical.app)
        self.mapper.connect('flower', '/flower/', app=flower.app)
        self.mapper.connect('cas', '/cas/', app=ppp_cas.app)
        self.mapper.connect('spellcheck', '/spell_checker/', app=ppp_cas.app)
        #self.mapper.connect('nlp_ml_standalone', '/nlp_ml_standalone/', app=ppp_nlp_ml_standalone.app)

    def __call__(self, environ, start_response):
        match = self.mapper.routematch(environ=environ)
        app = match[0]['app'] if match else self.not_found
        try:
            return app(environ, start_response)
        except KeyboardInterrupt:
            raise
        except Exception as e:
            traceback.print_exc(e)

    def not_found(self, environ, start_response):
        headers = [('Content-Type', 'text/plain')]
        start_response('404 Not Found', headers)
        return [b'Not found.']

app = Application()
