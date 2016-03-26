# PPP deployment scripts

## Assumptions

This repository provides script for deploying main PPP modules
under the following conditions:

* Everything is run as an unprivileged user (ie. you need root
  access only to set up the web server and install basic
  dependencies)
* Everything is installed directly in `~/`.
* Basic tools are installed (if they are not,
  `aptitude install python3 python3-dev git npm python3-pip curl wget php5-cli php5-curl unzip openjdk-8-jre-headless python3-numpy libaspell-dev memcached php5-memcached imagemagick librsvg2-bin ant`
  should be enough)

Note: `python3-requests` is broken in Debian testing at the moment I am
writing these lines. If you see this error:
`ImportError: cannot import name 'IncompleteRead'`, upgrade to the `unstable`
version of `python-requests`.

## Install dependencies

```
git clone https://github.com/ProjetPP/Deployment.git
./Deployment/bootstrap_bower.sh
./Deployment/bootstrap_corenlp.sh
./Deployment/bootstrap_modules.sh
cd PPP-WebUI/; ./bootstrap_icons.sh
```

## Run the PPP

From the `~/` directory:

```
./Deployment/run_corenlp.sh
```

From the `~/Deployment/` directory:

```
./run_python.sh
```


## Web server

Here is an Apache VirtualHost you can use. (change the base path
of the directories).

    <VirtualHost *:80>
        ServerAdmin valentin.lorentz+ppp@ens-lyon.org
        ServerName askplatyp.us
        DocumentRoot /home/ppp/PPP-WebUI/
        <Directory "/home/ppp/PPP-WebUI/">
                Options +Indexes +MultiViews +FollowSymLinks +ExecCGI
                Order allow,deny
                Allow from all
        </Directory>
        AssignUserId ppp ppp
    </VirtualHost>

    <VirtualHost *:80>
        ServerAdmin valentin.lorentz+ppp@ens-lyon.org
        ServerName wikidata.backend.askplatyp.us
        DocumentRoot /home/ppp/PPP-Wikidata/www/
        <Directory "/home/ppp/PPP-Wikidata/www/">
            Options +Indexes +MultiViews +FollowSymLinks +ExecCGI
            Order allow,deny
            Allow from all
        </Directory>
        AssignUserId ppp ppp
        Header set Access-Control-Allow-Origin "*"
        SetEnv PPP_WIKIDATA_CONFIG /home/ppp/Deployment/wikidata_config.default.json
    </VirtualHost>
    <VirtualHost *:80>
        ServerName core.frontend.askplatyp.us
        ProxyPass / http://127.0.0.1:9000/
        ProxyPassReverse / http://127.0.0.1:9000/
        <Proxy *>
            Order deny,allow
            Allow from all
        </Proxy>
        AssignUserId ppp ppp
    </VirtualHost>
    <VirtualHost *:80>
        ServerName logger.frontend.askplatyp.us
        ProxyPass / http://127.0.0.1:9005/
        ProxyPassReverse / http://127.0.0.1:9005/
        <Proxy *>
            Order deny,allow
            Allow from all
        </Proxy>
        AssignUserId ppp ppp
    </VirtualHost>

You can also use the `run.sh` script to run the python applications.


## MongoDB backend for Wikidata module

Warning, having your own clone of Wikidata using MongoDB requires more than 100 Go of storage and 4 Go of RAM. Setup it may take a while.

For that:

* Clone [WikibaseEntityStore](https://github.com/ProjetPP/WikibaseEntityStore) and `cd` to it.

* Install MongoDB 3 or greater. It is not yet packaged in Debian, so you would have to [install it from their own repo](https://docs.mongodb.org/master/tutorial/install-mongodb-on-debian/) if you use Debian.

* Install Composer (`curl -sS https://getcomposer.org/installer | php`) and php5-mongo (`aptitude install php5-mongo`)

* Install it with Composer (`php composer.phar install`) and add dependences for MongoDB (`php composer.phar require doctrine/mongodb symfony/console`).

* Download [the latest JSON dump of Wikidata](https://www.wikidata.org/wiki/Wikidata:Database_download).

* Runs the command `php entitystore import-json-dump MY_UNCOMPRESSED_JSON_DUMP PATH_TO_wikidata_config.mongodb.json` in the `WikibaseEntityStore` directory to fill the database.

* Setup Wikidata module to use your mongo DB install: replace `SetEnv PPP_WIKIDATA_CONFIG /home/ppp/Deployment/wikidata_config.default.json` by `SetEnv PPP_WIKIDATA_CONFIG /home/ppp/Deployment/wikidata_config.mongodb.json` in Apache config and run `php composer.phar require doctrine/mongodb` in `PPP-Wikidata` directory to install required dependences.

* To run daily entity store updates setup a CRON task that runs the `daily-entity-store-update.sh` at around 3pm UTC.

* It should work.
