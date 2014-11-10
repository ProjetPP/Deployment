# PPP deployement scripts

## Assumptions

This repository provides script for deploying main PPP modules
under the following conditions:

* Everything is run as an unprivileged user (ie. you need root
  access only to set up the web server and install basic
  dependencies)
* Everything is installed directly in `~/`.
* Basic tools are installed (if they are not,
  `aptitude install python3 git npm python3-pip curl wget php5-cli php5-curl unzip openjdk-7-jre-headless`
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
        ServerName ppp.pony.ovh
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
        ServerName wikidata.ppp.pony.ovh
        DocumentRoot /home/ppp/PPP-Wikidata/www/
        <Directory "/home/ppp/PPP-Wikidata/www/">
            Options +Indexes +MultiViews +FollowSymLinks +ExecCGI
            Order allow,deny
            Allow from all
        </Directory>
        AssignUserId ppp ppp
        Header set Access-Control-Allow-Origin "*"
    </VirtualHost>

You can also use the `run.sh` script to run the python applications.
