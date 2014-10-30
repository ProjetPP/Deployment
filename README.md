# PPP deployement scripts

## Assumptions

This repository provides script for deploying main PPP modules
under the following conditions:

* Everything is run as an unprivileged user (ie. you need root
  access only to set up the web server)
* Everything is installed directly in `~/`.
* Basic tools are installed (python3, git, …)

## Install dependencies

```
git clone https://github.com/ProjetPP/Deployment.git
./Deployment/bootstrap_bower.sh
./Deployment/bootstrap.sh
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
