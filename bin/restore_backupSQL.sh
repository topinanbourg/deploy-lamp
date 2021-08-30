#!/bin/sh
#
#  * Remise en place d'une sauvegarde SQL,
#

# is this file self-launched, or included ?
needHeaders=false
# load usefull common stuff
if [ -z ${commonsLoaded+x} ]; then
	source /root/bin/utils/commons.sh

	# we know this file is self-launched
	needHeaders=true
fi







folderForBackupsSQL="/var/www/backups"

# dans quel sous dossier chercher les backup
folderToUse=""
# le nom de dossier est il spécifié dans les arguments fournis ?
folderSetByArg=false
# y aura t'il le nom du backup à prendre dans la ligne de commande
backupToLoad=""
# l'argument "-y" pour éviter les confirmations
noInterractive=false
# List only availables files
listOnly=false

# Reccup des arguments fournis :
# ex :
# restore_backup.sh 20210801_12h06.sql -y
# restore_backup.sh -l

for ARGUMENT in "$@"
do
    if [ $ARGUMENT == "-y" ]; then
    	noInterractive=true
    	continue
    fi

    if [ $ARGUMENT == "-l" ]; then
    	listOnly=true
    	continue
    fi

    if [[ $ARGUMENT == "nh" || $ARGUMENT == "noHeaders" ]]; then
    	needHeaders=false
    	continue
    fi
    if [[ $ARGUMENT == "c" || $ARGUMENT == "color" ]]; then
    	displayWithColor=true
    	continue
    fi

	if echo $ARGUMENT | egrep -iq "*\.(sql)"; then
	    backupToLoad=$ARGUMENT
	else
		folderToUse=$ARGUMENT
		folderSetByArg=true
	fi
done


# #############################################
START_DATE=$(date +"%d/%m/%Y")
START_TIME=$(date +"%T")
# Timestamp du départ de lancement de ce script
TS_START_DATE=$(date +%s)

SCRIPTNAME=$(basename $0)


if [[ "$needHeaders" == true ]]; then
	clear

	printf "\n"
	printf "Scriptname : "$SCRIPTNAME"\n"
	printf "Start      : "$START_DATE" "$START_TIME"\n"
	printf "\n"
fi
# #############################################



: listFoldersAvailables:
# Recherche de la liste des dossiers dispo
cmd='ls '$folderForBackupsSQL'/* -d -t -1'
prefixLength=${#folderForBackupsSQL}

# liste des backups possibles
foldersList=($(eval $cmd))
foldersCount=${#foldersList[@]}

if [ $foldersCount -eq 0 ]; then
    displayMsg "\e[92mNo folder\e[0m found to restore folder."
    displayMsg "\e[93mAbort\e[0m."
    jumpto "end"
fi
if [ "$folderToUse" == "" ]; then
    displayMsg "\e[92m"$foldersCount"\e[0m folders availables :\n"
fi

# pour le cas où l'on connait le dossier à utiliser
# l'a t on trouvé
folderFound=false
foldersIndex=0

for folder in "${foldersList[@]}"; do
    (( foldersIndex++ ))

    # la date du fichier extraite de son nom
    # /var/www/backups/cdc7
    # =>               cdc7
	# filename=$(rev <<< "$backup" | cut -f1 -d'/' | rev)
	filename=$(basename $folder)

    if [ "$folderToUse" != "" ]; then
        # pour le cas où l'on connait le fichier à charger
        if [ "$folderToUse" == "$filename" ]; then
            # c'est bien ce fichier
            folderFound=true
            # on conservera le nom complet (path inclu)
            folderToUse=$filename
            break
        else
            continue
        fi
        displayMsg "Folder : \e[93m$folder\e[0m"
    else
		if [[ "$listOnly" == true ]]; then
        	displayMsg "  "$filename
        else
        	displayMsg "\e[92m "$foldersIndex"\e[0m : "$filename
        fi
    fi

done

# on ne souhaitait que la liste
if [[ "$listOnly" == true ]]; then
	jumpto "end"
fi

# pour le cas où l'on pensais savoir quel fichier charger, mais qu'il n'a pas été trouvé
if [ "$folderToUse" != "" ] && [ $folderFound == false ]; then
    displayMsg "Folder \e[93m$folderToUse\e[0m \e[91mNot found\e[0m, abort."
	jumpto "end"
else
	if [ "$folderToUse" == "" ]; then

		: inputFolderNumber:
		printf "\n"
	    displayMsg "Enter number to select folder contenning backup file to load"
	    displayMsg '(between "\e[93m1\e[0m" and "\e[93m'$foldersIndex'\e[0m" or "\e[93mA\e[0m" to abort)\e[93m\n'
	    echo -n
		read userinput
	    displayMsg "\e[0m"

		# checks that user want abort
		if [[ $userinput == "a" || $userinput == "A" ]]; then
			displayMsg "  \e[93mAbort\e[0m"
			jumpto "end"
		fi

		# checks that the input is within the desired range
		if [[ $userinput -lt 1 || $userinput -gt $foldersIndex ]]; then
			clear
			printf "\n"
	    	displayMsg "The file number \e[91m$userinput\e[0m is not valide."

			# jumpto "inputFileNumber"
			jumpto "listFolderAvailables"

		else
		    # insert your grep and ping stuff here
	        displayMsg " Need to use folder n°\e[92m"$userinput"\e[0m"
	        foldersIndexToload=$userinput-1
	        folderToUse=(${foldersList[$foldersIndexToload]})
			folderToUse=$(basename $folderToUse)
		fi
	fi
fi

# on doit maintenant avoir notre dossier ou trouver les backups
if [ "$folderToUse" == "" ]; then
    displayMsg "\e[91mUnexpected behaviour\e[0m, abort."
	jumpto "end"
fi

displayMsg " Need to use folder \e[92m"$folderToUse"\e[0m"



if [[ "$listOnly" == true ]] && [ ! -z $backupToLoad ] ; then
    displayMsg "Error while parssing arguments, you must set file to restore \e[92m"OR"\e[0m List availables."
	displayMsg "  \e[93mAbort\e[0m"
	jumpto "end"
fi

: listFilesAvailables:

# Recherche de la liste des backups dispo
cmd='ls '$folderForBackupsSQL'/'$folderToUse'/*.sql -d -t -1'

fullPrefix=$folderForBackupsSQL'/'$folderToUse
prefixLength=${#fullPrefix}

# liste des backups possibles
backupsList=($(eval $cmd))
backupsCount=${#backupsList[@]}

if [ $backupsCount -eq 0 ]; then
    displayMsg "\e[92mNo files\e[0m found to restore backup."
    displayMsg "\e[93mAbort\e[0m."
    jumpto "end"
fi
if [ "$backupToLoad" == "" ] && [ $backupsCount -gt 1 ] && [ $folderSetByArg == false ]; then
    displayMsg "\e[92m"$backupsCount"\e[0m files availables :\n"
fi

# pour le cas où l'on connait le backup à charger
# l'a t on trouvé
backupFound=false
backupsIndex=0

for backup in "${backupsList[@]}"; do
    (( backupsIndex++ ))

    # la date du fichier extraite de son nom
    # /var/www/backups/cdc7_2021-08-17-08h21.sql
    # =>               cdc7_2021-08-17-08h21.sql
	# filename=$(rev <<< "$backup" | cut -f1 -d'/' | rev)
	filename=$(basename $backup)

    if [ "$backupToLoad" != "" ]; then
        # pour le cas où l'on connait le fichier à charger
        if [ "$backupToLoad" == "$filename" ]; then
            # c'est bien ce fichier
            backupFound=true
            # on conservera le nom complet (path inclu)
            backupToLoad=$backup
            break
        else
            continue
        fi
        displayMsg "File : \e[93m$backup\e[0m"
    else
		if [[ "$listOnly" == true ]]; then
        	displayMsg "  "$filename
        else
			if [ $backupsCount -eq 1 ] && [ $folderSetByArg == true ]; then
	        	backupToLoad=$filename
            	backupFound=true
        	else
				if [ $backupsCount -eq 1 ]; then
        			displayMsg " Backup file available \e[92m"$filename"\e[0m"
	        		backupToLoad=$filename
            		backupFound=true
	        	else
        			displayMsg "\e[92m "$backupsIndex"\e[0m : "$filename
        		fi
        	fi
        fi
    fi

done

# on souhaitait que la liste
if [[ "$listOnly" == true ]]; then
	jumpto "end"
fi

# pour le cas où l'on pensais savoir quel fichier charger, mais qu'il n'a pas été trouvé
if [ "$backupToLoad" != "" ] && [ $backupFound == false ]; then
    displayMsg "File \e[93m$backupToLoad\e[0m \e[91mNot found\e[0m, abort."
	jumpto "end"
else
	if [ "$backupToLoad" == "" ]; then

		: inputFileNumber:
		printf "\n"
	    displayMsg "Enter number to select backup file to load"
	    displayMsg '(between "\e[93m1\e[0m" and "\e[93m'$backupsIndex'\e[0m" or "\e[93mA\e[0m" to abort)\e[93m\n'
	    echo -n
		read userinput
	    displayMsg "\e[0m"

		# checks that user want abort
		if [[ $userinput == "a" || $userinput == "A" ]]; then
			displayMsg "  \e[93mAbort\e[0m"
			jumpto "end"
		fi

		# checks that the input is within the desired range
		if [[ $userinput -lt 1 || $userinput -gt $backupsIndex ]]; then
			clear

			printf "\n"
			printf "Scriptname : "$SCRIPTNAME"\n"
			printf "Start      : "$START_DATE" "$START_TIME"\n"
			printf "\n"
	    	displayMsg "The file number \e[91m$userinput\e[0m is not valide."

			# jumpto "inputFileNumber"
			jumpto "listFilesAvailables"

		else
		    # insert your grep and ping stuff here
	        displayMsg " Need to load backup file n°\e[92m"$userinput"\e[0m"
	        backupsIndexToload=$userinput-1
	        backupToLoad=(${backupsList[$backupsIndexToload]})
		fi
	fi
fi

# on doit maintenant avoir notre fichier à charger
if [ "$backupToLoad" == "" ]; then
    displayMsg "\e[91mUnexpected behaviour\e[0m, abort."
	jumpto "end"
fi

filename=$(basename $backupToLoad)
displayMsg " Backup file to use \e[92m"$filename"\e[0m"

# reccup de la derniere ligne qui doit nous confirmer l'heure de fin
tail --lines=1 $folderForBackupsSQL/$folderToUse/$filename

if [ "$noInterractive" == true ]; then
	jumpto "loadDump"
fi

printf "\n"
displayMsg "Can we proceed with this file?"


if [ $backupsCount -eq 1 ]; then
	# pas de selection d'autre fichier possible
	displayMsg "(\e[93my\e[0m)es or \e[93ma\e[0mbort"
else
	displayMsg "(\e[93my\e[0m)es, \e[93ms\e[0melect another file or \e[93ma\e[0mbort"
fi
echo -n
read userinput
displayMsg "\e[0m"

# Check if user want to select another file
if [[ $userinput == "s" || $userinput == "S" ]]; then
	if [ $backupsCount -gt 1 ]; then
		jumpto "listFilesAvailables"
	fi
else
	# Check if user want to proceed
	if [[ -z $userinput || $userinput == "y" || $userinput == "Y" ]]; then
		jumpto "loadDump"
	fi
fi

# checks that user want abort
if [[ $userinput == "a" || $userinput == "A" ]]; then
	displayMsg "  \e[93mAbort\e[0m"
	jumpto "end"
else
	displayMsg "Unexpedted choice \e[93mAbort\e[0m"
	jumpto "end"
fi

: loadDump:

displayMsg " Load DB conf.."
source $folderForBackupsSQL'/'$folderToUse'/confSQL.sh'
# verif du chargement de la config de BDD
checkVars "DB_HOST" "DB_USER" "DB_PASS" "DB_NAME"

displayMsg " Start import dump.."

# Importation du dump SQL
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME < $folderForBackupsSQL/$folderToUse/$filename

if [[ "$selfLaunch" == true ]]; then
	displayMsg "Import file \e[92m$folderToUse\e[0m/\e[92m$filename\e[0m done."
else
	benchEnd=$(date +%s)
	benchDuration=$(( benchEnd - TS_START_DATE ))
	displayMsg "Import file \e[92m$folderToUse\e[0m/\e[92m$filename\e[0m done ("$(displayTimeFromSec $benchDuration)")."
fi

: end:
# #############################################
# reccap de fin
END_DATE=$(date +"%d/%m/%Y")
END_TIME=$(date +"%T")
benchEnd=$(date +%s)
benchDuration=$(( benchEnd - TS_START_DATE ))


if [[ "$selfLaunch" == true ]]; then
	printf "\n"
	printf "Spend time : "$(displayTimeFromSec $benchDuration)"\n"
	printf "End        : "$END_DATE" "$END_TIME"\n"
	printf "\n"
fi
