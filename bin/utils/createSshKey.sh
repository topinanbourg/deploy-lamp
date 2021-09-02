#!/bin/bash

# Creation & affichage de la clef ssh (à ajouter dans Bitbucket)
echo "Create ssh key (to add in Bitbucket)"
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

echo ""
echo ""
echo "Copy this public key to Bitbucket:"
echo ""
cat /root/.ssh/id_rsa.pub
echo ""
read -p "Press [Enter] when ready..."
