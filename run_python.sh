#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")
export PPP_CORE_CONFIG=core_config.json
export PPP_NLP_CLASSICAL_CONFIG=nlp_classical_config.json
export PPP_CAS_CONFIG=cas_config.json
export PPP_LOGGER_CONFIG=logger_config.json
export PPP_ML_STANDALONE_CONFIG=qp_ml_standalone_config.json
gunicorn ppp_core:app -b 0.0.0.0:9000 -w 10 &
gunicorn ppp_questionparsing_grammatical:app -b 0.0.0.0:9001 -w 10 &
gunicorn example_ppp_module:app -b 0.0.0.0:9002 -w 10 &
gunicorn ppp_cas:app -b 0.0.0.0:9003 -w 10 &
gunicorn ppp_spell_checker:app -b 0.0.0.0:9004 -w 10 &
gunicorn ppp_logger:app -b 0.0.0.0:9005 -w 10 &
gunicorn ppp_questionparsing_ml_standalone:app -b 0.0.0.0:9006 -w 10 &
