#!/bin/bash

DATE=$(date --date="yesterday" +%Y%m%d)
wget https://dumps.wikimedia.org/other/incr/wikidatawiki/${DATE}/wikidatawiki-${DATE}-pages-meta-hist-incr.xml.bz2
bunzip2 wikidatawiki-${DATE}-pages-meta-hist-incr.xml.bz2
php WikibaseEntityStore/entitystore import-incremental-xml-dump wikidatawiki-${DATE}-pages-meta-hist-incr.xml entitystore-config.json
rm wikidatawiki-${DATE}-pages-meta-hist-incr.xml
