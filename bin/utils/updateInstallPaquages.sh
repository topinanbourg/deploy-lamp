#!/bin/bash
#
echo ""
echo ""
echo "Now, we will update system, this can take a long time,"
read -p "so, take a cofee, and press [Enter] when ready..."

# reccup de la maj des paquets
displayMsg "\e[93mapt update\e[0m"
apt update

displayMsg "Install \e[92mcurl\e[0m & \e[92mnano\e[0m"
# install needed packages
apt install -y curl
apt install -y nano

# install apache
displayMsg "Install \e[92mApache\e[0m"
apt install -y apache2

# install firewall
displayMsg "Install firewall \e[92mufw\e[0m"
apt install -y ufw
displayMsg "  Allow \e[92mSSH\e[0m ports 21"
ufw allow in "SSH"
displayMsg "  Allow \e[92mWWW Full\e[0m ports 80,443"
ufw allow in "WWW Full"

# install mariaDB
displayMsg "Install \e[92mMariaDB\e[0m"
apt install -y mariadb-server
# secure install
mysql_secure_installation

# install PHP
displayMsg "Install \e[92mPHP\e[0m"
apt install -y php libapache2-mod-php php-mysql

# install certbot for let's encrypt
displayMsg "Install \e[92mCertbot\e[0m for let's encript"
apt install -y python-certbot-apache

# install de git
displayMsg "Install \e[92mgit\e[0m"
apt install -y git

echo ""
echo "Operatin system up to date."
echo ""

git --version

read -p "Press [Enter] when ready..."

