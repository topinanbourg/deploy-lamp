#!/bin/bash

# 
# this file contain some const
# 
# exemple de lancement :
# 
# sudo su -
# chmod +x /home/centos/install.sh
# /home/centos/install.sh
 
# ############
# Some const
# 
# Enable color display
displayWithColor=true

# Hostname to set
defaultHostName="s3-kalak-xyz"

# Git repo name, and subfolder name (to deploy, backups..)
REPO_NAME=curiositasv7

# BDD cnx (will be overided to set "DB_HOST", ...)
default_DB_HOST="localhost"
default_DB_USER="prestashop_admin"
#default_DB_PASS="mBtlIfSwLmYXRw3Z6ZXVRRYSsglWZQEYVDCzvUEcdG"
default_DB_PASS="unknow"
default_DB_NAME="prestashop_db"

# where to find some backup sql to restore
folderToFetchBackUpSQL="/home/centos/backupSQL"
