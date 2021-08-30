#!/bin/bash

# ##############################
# copie de la clef pour apache
echo "Copy gitconfig & ssh key for apache's user"

# Copie de la config git pour le user apache
cp /home/centos/.gitconfig           /usr/share/httpd/
# de la clef ssh
mkdir /usr/share/httpd/.ssh
cp /root/.ssh/id_rsa /usr/share/httpd/.ssh/

chown -R apache:apache /usr/share/httpd/.ssh
chown    apache:apache /usr/share/httpd/.gitconfig
