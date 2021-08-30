#!/bin/bash
#
echo ""
echo ""
echo "Now, we will update system, this can take a long time,"
read -p "so, take a cofee, and press [Enter] when ready..."
clear

# reccup de la maj des paquets
dnf update -y

# install needed packages
dnf install -y curl
dnf install -y nano

# install de git
dnf install -y git

clear
echo ""
echo "Operatin system up to date."
echo ""

git --version

read -p "Press [Enter] when ready..."
clear

