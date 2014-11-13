#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")
export PPP_CORE_CONFIG=core_config.json
export PPP_NLP_CLASSICAL_CONFIG=nlp_classical_config.json
gunicorn python_dispatcher:app -b 0.0.0.0:9000 -w 10
