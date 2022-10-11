#!/bin/bash

# exemple de lancement :
# 
# sudo su -
# chmod +x /home/debian/upgradePHP8.sh
# /home/debian/upgradePHP8.sh
 
# ############

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
sudo wget -qO - https://packages.sury.org/php/apt.gpg | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/debian-php-8.gpg --import
sudo chmod 644 /etc/apt/trusted.gpg.d/debian-php-8.gpg
apt update -y
apt install -y php8.1

php -v
update-alternatives --set php /usr/bin/php8.1 
php -v

# Re-install des modules courants
apt install -y php8.1-curl
apt install -y php8.1-apcu
apt install -y php8.1-xml
apt install -y php8.1-gd
apt install -y php8.1-imagick
apt install -y php8.1-mysql

# Reccap de l'installation
source ./bin/reccap_install.sh