#!/bin/bash

# exemple de lancement :
# 
# sudo su -
# chmod +x /home/debian/install_cdc7.sh
# /home/debian/install_cdc7.sh
 
# ############
# Some const
source ./const.sh
# ############
# let's go

echo "Copy shell profile options"
cp /home/debian/.ssh/authorized_keys /root/.ssh
cp /home/debian/.bash_aliases        /root/
cp /home/debian/.bashrc              /root/
cp /home/debian/.profile             /root/
cp /home/debian/.gitconfig           /root/

cp -r /home/debian/bin               /root/
cp /home/debian/const.sh             /root/
cp /home/debian/install.sh           /root/

chown -R root:root /root
chmod +x /root/bin/*.sh
chmod +x /root/bin/utils/*.sh

# go to root folder
cd /root

# load usefull common stuff
source ./bin/utils/commons.sh

# Reload current shell
echo "Reload current shell's profile"
source ~/.profile

# Creation & affichage de la clef ssh (à ajouter dans Bitbucket)
source ./bin/utils/createSshKey.sh

# ajout des clefs ssh pour se connecter au serveur
source ./bin/utils/addSSHKeys.sh

# Désactivation de la connexion SSH par mot de passe
source ./bin/utils/secureSSH.sh

# Correction du nom de la machine
source ./bin/utils/setHostname.sh

# update system and install curl/git
source ./bin/utils/updateInstallPaquages.sh

# add config for git and repos
source ./bin/utils/initGitConfig.sh

# git clone REPO_NAME
source ./bin/utils/gitClone.sh

# ask for DB credentials
source ./bin/utils/askCredentials.sh
# Create conf for DB backups
source ./bin/utils/setSQLConf.sh

# Copy stored DB backups
source ./bin/utils/cpBackupsSQL.sh

# if "backupSqlReady" load it
source ./bin/utils/loadBackupSQL.sh



# # mise en place du repo comme source du DocumentRoot de apache
# # echo "Change '<Directory "/var/www/prestashop">' to use '/var/www/curiositasv7' path in httpd.conf"
# # read -p "Press [Enter] when ready..."
# # nano /etc/ssh/sshd_config
# sed -i 's/#prestashop/curiositasv7/' /etc/httpd/conf/httpd.conf


# copy modified files to repo
cp /root/.bash_aliases        /var/www/deploy/
cp /root/.bashrc              /var/www/deploy/
cp /root/.profile             /var/www/deploy/
cp /root/.gitconfig           /var/www/deploy/
cp /root/const.sh             /var/www/deploy/
cp /root/install.sh           /var/www/deploy/
cp -r /root/bin               /var/www/deploy/
