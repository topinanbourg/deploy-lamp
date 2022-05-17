#!/bin/bash

# exemple de lancement :
# 
# sudo su -
# chmod +x /home/debian/install.sh
# /home/debian/install.sh
 
# ############
echo ""
echo "Please review constants before processing"
read -p "Press [Enter] when ready..."
nano /home/debian/const.sh
# Some const
source /home/debian/const.sh
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

# install Netstats
source ./bin/utils/installNetstats.sh

# add config for git and repos
source ./bin/utils/initGitConfig.sh

# git clone repoName
source ./bin/utils/gitClone.sh

# ask for DB credentials
source ./bin/utils/askCredentials.sh
# ask if we need create DB user/database
source ./bin/utils/creatSQLUser.sh
# Create conf for DB backups
source ./bin/utils/setSQLConf.sh

# Copy stored DB backups
source ./bin/utils/cpBackupsSQL.sh

# if "backupSqlReady" load it
source ./bin/utils/loadBackupSQL.sh

# git clone deploy to save modified file
repoName="deploy"
source ./bin/utils/gitClone.sh

# create virtual host for deploy
source ./bin/utils/addApacheDefaultVHost.sh

# enable virtual host for this repo
source ./bin/addApacheVHost.sh

displayMsg "Install: all \e[92mdone\e[0m."
echo ""
echo ""
echo ""
echo "# #### #### ####"
echo ""

# Reccap de l'installation
source ./bin/reccap_install.sh

# copy modified files to repo
cp /root/.bash_aliases        /var/www/deploy/
cp /root/.bashrc              /var/www/deploy/
cp /root/.profile             /var/www/deploy/
cp /root/.gitconfig           /var/www/deploy/
cp /root/const.sh             /var/www/deploy/
cp /root/install.sh           /var/www/deploy/
cp -r /root/bin               /var/www/deploy/
