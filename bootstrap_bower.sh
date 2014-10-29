#!/bin/bash
npm install bower

BOWER=./node_modules/bower/bin/bower
# We have to patch bower so it runs with (the right) nodejs executable…
NODEJS=$(head -n 1 $(which npm))
# remove the shebang
sed -i "1s/^.*$//" $BOWER
# add npm's shebang
sed -i 1i$NODEJS $BOWER

# initialize bower
echo "y" | $BOWER
