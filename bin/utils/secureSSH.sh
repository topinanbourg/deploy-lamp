#!/bin/bash

# Désactivation de la connexion SSH par mot de passe
echo "Disable SSH connexion with password"
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Reload ssh deamon
echo "Reload ssh deamon"
# for debian:
#systemctl restart ssh
# for centos
service sshd restart
