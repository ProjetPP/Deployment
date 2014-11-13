#!/bin/bash

# Edit this if needed
BOWER=$HOME/node_modules/bower/bin/bower

#################
# Python stuff
echo "Installing Python modules."
pip3 install --user --upgrade routes gunicorn ppp_core nltk ppp_nlp_classical ppp_nlp_standalone
pip3 install --user --upgrade git+https://github.com/ProjetPP/ExamplePPPModule-Python.git

##################
# Web UI
echo "Installing WebUI."
git clone https://github.com/ProjetPP/PPP-WebUI.git
cd PPP-WebUI
$BOWER install
cd ..
cp Deployment/webui_config.js PPP-WebUI/config.js

#################
# Wikidata
echo "Installing Wikidata module."
git clone https://github.com/ProjetPP/PPP-Wikidata.git
cd PPP-Wikidata/
curl -sS https://getcomposer.org/installer | php
php composer.phar install
cd ..
