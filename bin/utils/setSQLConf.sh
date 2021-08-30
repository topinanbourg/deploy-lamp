#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
	echo "These script must be run into a launcher."
	exit
fi

# check required vars
checkVars "REPO_NAME" "DB_HOST" "DB_USER" "DB_PASS" "DB_NAME"


folderForBackupsSQL="/var/www/backups/"$REPO_NAME

# construction de l'arbo pour les backups
mkdir -p $folderForBackupsSQL


displayMsg "Folder \e[92m"$folderForBackupsSQL"\e[0m created.";

# file name to fill
confFile=$folderForBackupsSQL"/confSQL.sh"

# create file
cat > $confFile<< EOF
#!/bin/bash
#
# auto generated file to configure DB acces
#

EOF

# Vars names to set
fieldnames=("DB_HOST" "DB_USER" "DB_PASS" "DB_NAME")

# fill values
for field in ${fieldnames[@]}
do
	currentValue=${!field}
    echo $field"="$currentValue>>$confFile;
done

displayMsg "File \e[92mconfSQL.sh\e[0m created.";
