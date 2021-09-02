#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
    echo "These script must be run into a launcher."
    exit
fi

# check required vars
checkVars "default_DB_HOST" "default_DB_USER" "default_DB_PASS" "default_DB_NAME"


# demande des credentials
while [ true ]; do

    clear

    DB_HOST=""
    DB_USER=""
    DB_PASS=""
    DB_NAME=""
    fieldnames=("DB_HOST" "DB_USER" "DB_PASS" "DB_NAME")

    # these vars are set before
    # default_DB_HOST="localhost"
    # default_DB_USER="prestashop_admin"
    # default_DB_PASS="unknow"
    # default_DB_NAME="prestashop_db"

    echo ""
    echo ""
    echo "Please fill DB credentials with informations from api"
    echo "How to use api are describe here: https://docs.ovh.com/fr/public-cloud/applications-preinstallees/#details-de-connexion-a-lapplication"
    echo ""
    displayMsg "Fill new value, or leave \e[92mdefault\e[0m"
    echo ""



    for field in ${fieldnames[@]}
    do
        if [ -z "${!field}" ]; then
            # if var is empty
            defaultFieldValue="default_$field"
            # set default value
            eval "$field"='${!defaultFieldValue}'
        fi
        currentValue=${!field}
        displayMsg " $field: \e[92m"$currentValue"\e[0m";
        echo -n
        read userinput
        if [ -n "$userinput" ]; then
            # update value if user input is'nt empty
            eval "$field"='$userinput'
        fi
    done

    echo ""
    echo "Are theses values ok:"
    for field in ${fieldnames[@]}
    do
        currentValue=${!field}
        displayMsg "    $field: \e[92m"$currentValue"\e[0m"
    done
    echo ""

    displayMsg "(\e[93my\e[0m)es or fill another values ?"
    echo -n
    read userinput
    # Check if user want to proceed
    if [[ -z $userinput || $userinput == "y" || $userinput == "Y" ]]; then
        break
    fi

done
