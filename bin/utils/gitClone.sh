#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
    echo "These script $0 must be run into a launcher."
    exit
fi

# check required repo name
checkVars "repoName"

if [ ! -d "/var/www/$repoName" ]; then

    displayMsg "Git clone of repo \e[93m$repoName\e[0m.."

    sudo -u www-data git clone "git@bitbucket.org:JosNo/"$repoName".git /var/www/"$repoName

    displayMsg "Repository \e[92m$repoName\e[0m cloned."
else 
    displayMsg "folder \e[93m/var/www/$repoName\e[0m already exist"
    displayMsg "(we can't clone repo \e[93m$repoName\e[0m)."
fi