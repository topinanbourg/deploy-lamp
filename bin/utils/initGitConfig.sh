#!/bin/bash

# ##############################
# copie de la clef pour apache
echo "Copy gitconfig & ssh key for apache's user"

# Copie de la config git pour le user apache
cp /home/debian/.gitconfig           /var/www/
# de la clef ssh
mkdir /var/www/.ssh
cp /root/.ssh/id_rsa /var/www/.ssh/

chown -R www-data:www-data /var/www/.ssh
chown    www-data:www-data /var/www/.gitconfig
