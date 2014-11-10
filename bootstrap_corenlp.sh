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

