#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
    echo "These script $0 must be run into a launcher."
    exit
fi

# check required vars
checkVars "DB_HOST" "DB_USER" "DB_PASS" "DB_NAME"

echo ""
echo "Must we create the DB acces and database in mysql?"
displayMsg "(\e[93my\e[0m)es or no?"
echo -n
read userinput
# Check if user want to proceed
if [[ -z $userinput || $userinput == "y" || $userinput == "Y" ]]; then
    mysql --execute "CREATE DATABASE $DB_NAME;"
    mysql --execute "GRANT ALL ON "$DB_NAME".* TO '"$DB_USER"'@'"$DB_HOST"' IDENTIFIED BY '"$DB_PASS"' WITH GRANT OPTION;"
    mysql --execute "FLUSH PRIVILEGES;"
    displayMsg "Acces granted to \e[92m"$DB_USER"'@'"$DB_HOST"\e[0m for database \e[92m"$DB_NAME"\e[0m."
fi
