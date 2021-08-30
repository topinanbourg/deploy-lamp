#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
	echo "These script must be run into a launcher."
	exit
fi

# will set "backupSqlReady" var if one, and only one backup is found

# copy backup to load (if wanted)
if [ -n "$folderToFetchBackUpSQL" ]; then
	# check required vars
	checkVars "folderForBackupsSQL"

	displayMsg "Copy sql backup(s) to load.."

	cmd='cp '$folderToFetchBackUpSQL'/*.sql '$folderForBackupsSQL'/'
	eval $cmd

	# list copied files
	cmd='ls '$folderForBackupsSQL'/*.sql -d -t -1'

	prefixLength=${#folderForBackupsSQL}

	# liste des backups possibles
	backupsList=($(eval $cmd))
	backupsCount=${#backupsList[@]}

	if [ $backupsCount -eq 0 ]; then
	    displayMsg "\e[92mNo files\e[0m found to restore backup."
	else
		if [ $backupsCount -gt 1 ]; then
			displayMsg "\e[92m"$backupsCount"\e[0m files availables :\n"
		fi

		for backup in "${backupsList[@]}"; do
			filename=$(basename $backup)

			if [ $backupsCount -gt 1 ]; then
				displayMsg "    $filename"
			else
	        	displayMsg "File \e[93m$filename\e[0m ready to restore."
	        	backupSqlReady=$filename
			fi
	    done

	fi
fi
