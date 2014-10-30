#!/bin/bash

# Edit this if needed
BOWER=$HOME/node_modules/bower/bin/bower

#################
# Python stuff
echo "Installing Python modules."
pip3 install --user --upgrade routes gunicorn ppp_core ppp_nlp_classical
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

#################
# CoreNLP
echo "Installing CoreNLP"
pip3 install --user --upgrade pexpect unidecode xmltodict jsonrpclib-pelix
pip3 install --user --upgrade git+https://bitbucket.org/ProgVal/corenlp-python.git
if [ ! -f stanford-corenlp-full-2014-08-27.zip ]
then
    echo "Downloading CoreNLP (long: 221MB)…"
    wget http://nlp.stanford.edu/software/stanford-corenlp-full-2014-08-27.zip
fi
echo "Extracting CoreNLP…"
rm -rf stanford-corenlp-full-2014-08-27
unzip stanford-corenlp-full-2014-08-27.zip
