You can install everything from an unprivileged user:

    git clone https://github.com/ProjetPP/Deployment.git
    ./Deployment/bootstrap_bower.sh
    ./Deployment/bootstrap.sh

Here is an Apache VirtualHost you can use. (change the base path
of the directories).

    <VirtualHost *:80>
            ServerAdmin progval@gmail.com
            ServerName ppp.pony.ovh
            DocumentRoot /home/ppp/PPP-WebUI/
            <Directory "/home/ppp/PPP-WebUI/">
                    Options +Indexes +MultiViews +FollowSymLinks +ExecCGI
                    Order allow,deny
                    Allow from all
            </Directory>
            AssignUserId ppp ppp
    </VirtualHost>

You can also use the `run.sh` script to run the python applications.
