export JAVA_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

if [ ! -f $JAVA_PATH ]
then
    export JAVA_PATH=/usr/lib/jvm/java-8-oracle/bin/java
fi


CORENLP_OPTIONS="-parse.flags \" -makeCopulaHead\"" CORENLP=stanford-corenlp-full-* python3 -m corenlp --memory 1g -p 8999 &
for job in `jobs -p`; do echo $job;     wait $job; done
