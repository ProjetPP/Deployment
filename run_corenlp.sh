CORENLP_OPTIONS="-annotators tokenize,ssplit,pos,lemma,parse -parse.flags \" -makeCopulaHead\"" CORENLP=stanford-corenlp-full-* python3 -m corenlp --memory 1g -p 8999 &
for job in `jobs -p`; do echo $job;     wait $job; done
