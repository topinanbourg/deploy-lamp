#!/bin/bash

# 
# this file contain some const
# 
# exemple de lancement :
# 
# sudo su -
# chmod +x /home/centos/install.sh
# /home/centos/install.sh
 
# Enable color display
displayWithColor=true

# Hostname to set
defaultHostName="s3.kalak.xyz"

# Git repo name, and subfolder name (to deploy, backups..)
repoName="mamouth"

# doit on ajouter des clefs ssh
declare -a sshKeysToAdd=(
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCU38/eDLfHkQAYZKbQynOi+w1epcacid+jfy5oCTHPVPk51Kig3KDzF+gfOcXjzBZI15kyg/vBYSeHdKZHPqnyoiK17d/n4NaSlMXULR75lufGuQTgospJpcxtd4oI58n2i0hHtrueNaO/Xk97cngm+VQPmpjHx/3K3Gny0WAXUQ== JosNo2@TopMove"
)

# BDD cnx (will be overided to set "DB_HOST", ...)
default_DB_HOST="localhost"
default_DB_USER="prestashop_admin"
#default_DB_PASS="mBtlIfSwLmYXRw3Z6ZXVRRYSsglWZQEYVDCzvUEcdG"
default_DB_PASS="unknow"
default_DB_NAME="prestashop_db"

# where to find some backup sql to restore
folderToFetchBackUpSQL="/home/debian/backupSQL"
