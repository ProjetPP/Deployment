#!/bin/bash

export PPP_CORE_CONFIG=core_config.json
gunicorn python_dispatcher:app -b 0.0.0.0:9000 -w 10
