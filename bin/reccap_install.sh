#!/bin/bash
#
# Reccap de l'install du server
# 

# load usefull common stuff
if [ -z ${commonsLoaded+x} ]; then
    source /root/bin/utils/commons.sh
    displayWithColor=true
fi


# #### #### ####
serverName=$(cat /etc/hostname)
displayMsg "ServerName: \e[92m"$serverName"\e[0m"

# #### #### ####
osVersion=$(lsb_release -d)
# Description:    Debian GNU/Linux 10 (buster)
osVersion=$(trim echo $osVersion | cut -d ":" -f2)
# => Debian GNU/Linux 10 (buster)
echo $osVersion

# #### #### ####
apacheVersion=$(apache2 -v)
# Server version: Apache/2.4.38 (Debian)
# Server built:   2021-06-10T10:13:06
apacheVersion=$(echo $apacheVersion | head -1 | cut -d " " -f3 | cut -d "/" -f2)
displayMsg "Apache: \e[92m"$apacheVersion"\e[0m"

# #### #### ####
mysqlVersion=$(mysql --version)
# mysql  Ver 15.1 Distrib 10.3.29-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2
mysqlVersion=$(echo $mysqlVersion | cut -d " " -f5)
displayMsg "MySQL:  \e[92m"$mysqlVersion"\e[0m"

# #### #### ####
phpVersion=$(php --version)
# PHP 7.3.29-1~deb10u1 (cli) (built: Jul  2 2021 04:04:33) ( NTS )
# Copyright (c) 1997-2018 The PHP Group
# Zend Engine v3.3.29, Copyright (c) 1998-2018 Zend Technologies
#     with Zend OPcache v7.3.29-1~deb10u1, Copyright (c) 1999-2018, by Zend Technologies
phpVersion=$(echo $phpVersion | head -1 | cut -d " " -f2 | cut -d "~" -f1)
displayMsg "PHP:    \e[92m"$phpVersion"\e[0m"

echo ""

# #### #### ####
certbotVersion=$(certbot --version)
# certbot 0.31.0
certbotVersion=$(echo $certbotVersion | cut -d " " -f2)
displayMsg "Certbot: \e[92m"$certbotVersion"\e[0m"

# #### #### ####
ufwVersion=$(ufw --version)
# ufw 0.36
# Copyright 2008-2015 Canonical Ltd.
ufwVersion=$(echo $ufwVersion | head -1 | cut -d " " -f2)
displayMsg "ufw:     \e[92m"$ufwVersion"\e[0m"

# #### #### ####
fail2banVersion=$(fail2ban-server --version)
# Fail2Ban v0.10.2
#
# Copyright (c) 2004-2008 Cyril Jaquier, 2008- Fail2Ban Contributors
# Copyright of modifications held by their respective authors.
# Licensed under the GNU General Public License v2 (GPL).
fail2banVersion=$(echo $fail2banVersion | cut -d " " -f2 | cut -d "v" -f2)
displayMsg "fail2ban:\e[92m"$fail2banVersion"\e[0m"

# #### #### ####
curlVersion=$(curl --version)
# curl 7.64.0 (x86_64-pc-linux-gnu) libcurl/7.64.0 OpenSSL/1.1.1d zlib/1.2.11 libidn2/2.0.5 libpsl/0.20.2 (+libidn2/2.0.5) libssh2/1.8.0 nghttp2/1.36.0 librtmp/2.3
# Release-Date: 2019-02-06
# Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp
# Features: AsynchDNS IDN IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz TLS-SRP HTTP2 UnixSockets HTTPS-proxy PSL
curlVersion=$(echo $curlVersion | cut -d " " -f2)
displayMsg "curl:    \e[92m"$curlVersion"\e[0m"

echo ""

# #### #### ####
gitVersion=$(git --version)
# git version 2.20.1
gitVersion=$(echo $gitVersion | cut -d " " -f3)
displayMsg "git:    \e[92m"$gitVersion"\e[0m"

# #### #### ####
nodeVersion=$(node --version)
# v10.24.0
nodeVersion=$(echo $nodeVersion | sed 's/[v]*//g')
displayMsg "NodeJS: \e[92m"$nodeVersion"\e[0m"

# #### #### ####
npmVersion=$(npm --version)
# 5.8.0
displayMsg "npm:    \e[92m"$npmVersion"\e[0m"

# #### #### ####
composerVersion=$(sudo -u www-data composer --version)
# Composer version 2.1.6 2021-08-19 17:11:08
composerVersion=$(echo $composerVersion | cut -d " " -f3)
displayMsg "Composer: \e[92m"$composerVersion"\e[0m"

echo ""

# #### #### ####
reposList=()
foldersList=(/var/www/*)
for folderName in "${foldersList[@]}" ; do
       folderPath=$folderName"/.git"
    if [ -d "$folderPath" ]; then
          reposList+=($(basename $folderName))
    fi
done

reposCount=${#reposList[@]}
if [ $reposCount -gt 0 ]; then
    displayMsg "Repositories fetched (\e[92m"$reposCount"\e[0m)"
    for folderName in "${reposList[@]}" ; do
        displayMsg " \e[92m"$folderName"\e[0m"
    done
    echo ""
fi

# #### #### ####
vhostsList=()
confsList=(/etc/apache2/sites-available/*.conf)
for confFile in "${confsList[@]}" ; do
    shortName=$(basename $confFile)
    shortName="${shortName%.*}"
    if [[ $shortName == *"-ssl" ]]; then
        continue
    fi
    if [[ $shortName == "000-default" ]]; then
          vhostsList+=($serverName)
    else
        vhostsList+=($shortName)
    fi
done

vHostCount=${#vhostsList[@]}
if [ $vHostCount -gt 0 ]; then
    displayMsg "VirtualHost created (\e[92m"$vHostCount"\e[0m)"
    for vhostName in "${vhostsList[@]}" ; do
        displayMsg " \e[92m"$vhostName"\e[0m"
    done
    echo ""
fi
