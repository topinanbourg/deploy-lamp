#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
    echo "These script $0 must be run into a launcher."
    exit
fi

# will set "backupSqlReady" var if one, and only one backup is found

# if one file is ready for (and only one)
# var "backupSqlReady" can be set by "cpBackupsSQL.sh"
if [ -n "$backupSqlReady" ]; then
    # check required vars
    checkVars "folderForBackupsSQL"

    displayMsg "Backup SQL \e[93m$backupSqlReady\e[0m to load.."

    # ~/bin/restore_backupSQL.sh nh c
    ~/bin/restore_backupSQL.sh $repoName nh c
    # ~/bin/restore_backupSQL.sh $repoName $backupSqlReady nh c
fi
