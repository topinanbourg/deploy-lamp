#!/bin/bash
#
if [ ${#sshKeysToAdd[@]} -eq 0 ]; then
    displayMsg " \e[93mNo\e[0m ssh key to add."

else
    # ajout de clef parmis celle ayant le droit de se connecter au server
    echo "Add ssh keys (to allow connection to server).."

    for sshKey in "${sshKeysToAdd[@]}"; do
       echo "$sshKey" >> /home/debian/.ssh/authorized_keys
       echo "$sshKey" >> /root/.ssh/authorized_keys
    done
    displayMsg " \e[92m"${#sshKeysToAdd[@]}"\e[0m ssh key added."
fi
