#!/bin/bash

# exemple de lancement :
# 
# sudo su -
# chmod +x /home/debian/upgradePHP8.sh
# /home/debian/upgradePHP8.sh
 
# ############

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
apt update -y
apt install -y php8.0

php -v
update-alternatives --set php /usr/bin/php8.0 
php -v

# Re-install des modules courants
apt install -y php8.0-curl
apt install -y php8.0-apcu
apt install -y php8.0-xml
apt install -y php8.0-gd
apt install -y php8.0-imagick
apt install -y php8.0-mysql

# Reccap de l'installation
source ./bin/reccap_install.sh