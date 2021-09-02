#!/bin/bash
#
#  * Ajout d'un virtual host dans apache
#

# load usefull common stuff
if [ -z ${commonsLoaded+x} ]; then
    source /root/bin/utils/commons.sh
fi

default_ServerName=$(cat /etc/hostname)
default_RepoName="RepoName"
default_PublicFolder="public"

if [ -n $repoName ]; then
    default_RepoName=$repoName
fi

AVH_ServerName=""
AVH_RepoName=""
AVH_PublicFolder=""
# demande des informations du vhost
while [ true ]; do

    echo ""
    echo ""
    echo "Please fill VirtualHost informations"
    echo ""
    displayMsg "Fill new value, or leave \e[92mdefault\e[0m"
    echo ""
    fieldnames=("ServerName" "RepoName" "PublicFolder")
    
    for fieldKey in ${fieldnames[@]}
    do
        fieldname="AVH_"$fieldKey
        if [ -z "${!fieldname}" ]; then
            # if var is empty
            defaultFieldValue="default_$fieldKey"
            # set default value
            eval "$fieldname"='${!defaultFieldValue}'
        fi
        currentValue=${!fieldname}
        displayMsg " $fieldKey: \e[92m"$currentValue"\e[0m";
        echo -n
        read userinput
        if [ -n "$userinput" ]; then
            # update value if user input is'nt empty
            eval "$fieldname"='$userinput'
        fi
    done

    echo ""
    echo "Are theses values ok:"
    for fieldKey in ${fieldnames[@]}
    do
        fieldname="AVH_"$fieldKey
        currentValue=${!fieldname}
        displayMsg "    $fieldKey: \e[92m"$currentValue"\e[0m"
    done
    echo ""

    displayMsg "(\e[93my\e[0m)es or fill another values ?"
    echo -n
    read userinput
    # Check if user want to proceed
    if [[ -z $userinput || $userinput == "y" || $userinput == "Y" ]]; then
        
        mkdir -p "/var/log/apache2/"$AVH_ServerName

        confFile="/etc/apache2/sites-available/"$AVH_ServerName".conf"
        cat > $confFile<< EOF
<VirtualHost *:80>
    ServerName ${AVH_ServerName}
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/$AVH_RepoName/${AVH_PublicFolder}
    ErrorLog  "|/usr/bin/cronolog /var/log/apache2/${AVH_ServerName}/%Y/%Y-%m/error.log"
    CustomLog "|/usr/bin/cronolog /var/log/apache2/${AVH_ServerName}/%Y/%Y-%m/access.log" combined
</VirtualHost>
EOF
        # ready to install vhost
        a2ensite $AVH_ServerName

        # Obtaining an SSL Certificate
        certbot --apache -d $AVH_ServerName

        displayMsg "VirtualHost \e[92m"$AVH_ServerName"\e[0m created."
        echo ""
        echo "Must we create another VHost?"
        displayMsg "yes or (n)o?"
        echo -n
        read userinput
        # Check if user want another VHost
        if [[ $userinput == "y" || $userinput == "Y" ]]; then
            # re-ask new values to create another VHOST
            continue
        else
            # all done
            break
        fi
    else
        # user want change some value
        continue
    fi

done


