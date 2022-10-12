#!/bin/bash
#
echo ""
echo ""
echo "Now, we will update system, this can take a long time,"
read -p "so, take a cofee, and press [Enter] when ready..."

# reccup de la maj des paquets
displayMsg "\e[93mapt update\e[0m"
apt update

displayMsg "Install \e[92mcurl\e[0m, \e[92mwget\e[0m & \e[92munzip\e[0m..."
# install needed packages
apt install -y curl
apt install -y nano
apt install -y wget unzip

# install apache
displayMsg "Install \e[92mApache\e[0m"
apt install -y apache2
apt install -y cronolog
chown -R www-data:www-data /var/www

# install firewall
displayMsg "Install firewall \e[92mufw\e[0m"
apt install -y ufw
displayMsg "  Allow \e[92mSSH\e[0m ports 21"
ufw allow in "SSH"
displayMsg "  Allow \e[92mWWW Full\e[0m ports 80,443"
ufw allow in "WWW Full"
displayMsg "  Enable \e[92mufw\e[0m"
ufw enable

# install fail2ban
apt install -y fail2ban

# install PHP
displayMsg "Install \e[92mPHP\e[0m"
apt install -y php libapache2-mod-php php-mysql php-cli php-zip php-curl php-xml

# install APCU for php
apt install -y php-dev
pecl channel-update pecl.php.net
pecl install apcu
apt install -y php-apcu

# install Imagick for php
apt install -y php-imagick
# install MBString
apt install -y php7.4-mbstring
# install GD
apt install -y php-gd
# install intl
apt install -y php-intl

# install Composer
displayMsg "Install \e[92mComposer\e[0m"
wget -O composer-setup.php https://getcomposer.org/installer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php


# install certbot for let's encrypt
displayMsg "Install \e[92mCertbot\e[0m for let's encript"
apt install -y python3-certbot-apache

# install de git
displayMsg "Install \e[92mgit\e[0m"
apt install -y git

# install de NodeJs
displayMsg "Install \e[92mNodeJs\e[0m"
apt install -y nodejs

# install de npm
displayMsg "Install \e[92mnpm\e[0m"
apt install -y npm

# install mariaDB
displayMsg "Install \e[92mMariaDB\e[0m"
apt install -y mariadb-server
# secure install
mysql_secure_installation

echo ""
echo "Operatin system up to date."
echo ""

read -p "Press [Enter] when ready..."

