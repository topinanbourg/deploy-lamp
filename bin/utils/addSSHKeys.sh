#!/bin/bash
#
if [ ${#sshKeysToAdd[@]} -eq 0 ]; then
    displayMsg " \e[93mNo\e[0m ssh key to add."

else
    # ajout de clef parmis celle ayant le droit de se connecter au server
    echo "Add ssh keys (to allow connection to server).."

    existingKey=0
    addedKey=0
    fileToCheck="/home/debian/.ssh/authorized_keys"

    for sshKey in "${sshKeysToAdd[@]}"; do

        # extract comment from key
        # 
        # ssh-rsa AAAAB3N...AXUQ== User@Machine
        # ->                       User@Machine
        commentKey=$(echo $sshKey | cut -d' ' -f3)

        # is these comment already in file
        grepReturn=$(grep "$commentKey" "$fileToCheck")

        if [ "$grepReturn" == "" ]; then 
            (( addedKey++ ))
            echo "$sshKey" >> /home/debian/.ssh/authorized_keys
            displayMsg "  \e[92m"$commentKey"\e[0m added."
        else
            (( existingKey++ ))
            displayMsg "  \e[93m"$commentKey"\e[0m already present."
        fi
    done

    # display summarize
    if [ $existingKey -gt 0 ]; then
        displayMsg "  \e[92m"$existingKey"\e[0m ssh key already in place."
    fi

    if [ $addedKey -eq 0 ]; then
        displayMsg "  \e[93mNo\e[0m ssh key to add."
    else
        displayMsg "  \e[92m"$addedKey"\e[0m ssh key added."
    fi

    displayMsg "Copy authorized_keys from \e[93mdebian\e[0m to \e[92mroot\e[0m user."
    cp /home/debian/.ssh/authorized_keys /root/.ssh/authorized_keys
    chown -R root:root /root/.ssh
fi
