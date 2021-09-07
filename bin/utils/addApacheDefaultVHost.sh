#!/bin/bash
#
#  * Ajout d'un virtual host dans apache
#

# load usefull common stuff
if [ -z ${commonsLoaded+x} ]; then
    source /root/bin/utils/commons.sh
fi


AVH_ServerName=$(cat /etc/hostname)
AVH_RepoName="deploy"
AVH_PublicFolder="public"

# remove default files
rm /etc/apache2/sites-available/*.conf
rm /etc/apache2/sites-enabled/*.conf
        
mkdir -p "/var/log/apache2/"$AVH_ServerName

confFile="/etc/apache2/sites-available/000-"$AVH_ServerName".conf"
cat > $confFile<< EOF
ServerName ${AVH_ServerName}

<VirtualHost *:80>
    ServerName ${AVH_ServerName}
    DocumentRoot /var/www/$AVH_RepoName/${AVH_PublicFolder}
    
    ErrorLog  "|/usr/bin/cronolog /var/log/apache2/${AVH_ServerName}/%Y/%Y-%m/error.log"
    CustomLog "|/usr/bin/cronolog /var/log/apache2/${AVH_ServerName}/%Y/%Y-%m/access.log" combined
</VirtualHost>
EOF

# ready to install vhost
a2ensite "000-"$AVH_ServerName

# To activate the new configuration, you need to run:
systemctl reload apache2

# Obtaining an SSL Certificate
certbot --apache -d $AVH_ServerName

displayMsg "VirtualHost \e[92m"$AVH_ServerName"\e[0m created."


