#!/bin/bash

# Edit this if needed
BOWER=$HOME/node_modules/bower/bin/bower

#################
# Python stuff
echo "Installing Python modules."
pip3 install --user --upgrade routes gunicorn ppp_core nltk ppp_questionparsing_grammatical
pip3 install --user --upgrade git+https://github.com/WojciechMula/aspell-python.git
pip3 install --user --upgrade sympy ply ppp_cas ppp_spell_checker
pip3 install --user --upgrade git+https://github.com/ProjetPP/ExamplePPPModule-Python.git

pip3 install --user --upgrade ppp_logger

###################
# QP ML standalone
pip3 install --user --upgrade ppp_questionparsing_ml_standalone
cd Deployment/
export PPP_ML_STANDALONE_CONFIG=qp_ml_standalone_config.json
DATA_DIR=`/usr/bin/env python3 -c "print(__import__('ppp_questionparsing_ml_standalone.config').config.Config().data_dir)"`

mkdir -p $DATA_DIR

if [ ! -f $DATA_DIR/embeddings-scaled.EMBEDDING_SIZE=25.txt ]
then
    wget http://metaoptimize.s3.amazonaws.com/cw-embeddings-ACL2010/embeddings-scaled.EMBEDDING_SIZE=25.txt.gz -c
    gzip -d embeddings-scaled.EMBEDDING_SIZE=25.txt.gz
    mv -v embeddings-scaled.EMBEDDING_SIZE=25.txt $DATA_DIR
fi
python3 -m ppp_questionparsing_ml_standalone bootstrap
cd ..

##################
# Web UI
echo "Installing WebUI."
git clone https://github.com/ProjetPP/PPP-WebUI.git
cd PPP-WebUI
$BOWER install
cd ..
cp Deployment/webui_config.js PPP-WebUI/config.js

#################
# PHP modules
for module in "Wikidata" "Wikipedia"
do
    echo "Installing $module module."
    git clone https://github.com/ProjetPP/PPP-${module}.git
    cd PPP-${module}/
    curl -sS https://getcomposer.org/installer | php
    php composer.phar install
    cd ..
done
