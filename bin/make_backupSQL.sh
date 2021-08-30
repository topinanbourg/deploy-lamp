#!/bin/sh
#
#  * Une sauvegarde quotidienne,
#  * puis on suprimmera les backups obsolets de plus de 14 jours.
#

echo "make_backupSQL.sh must have a rewrite before launch, sorry."
exit


# load usefull common stuff
source ./utils.sh
# Chargement du fichier de config communes
source ./configSQL.sh

# #############################################
START_DATE=$(date +"%d/%m/%Y")
START_TIME=$(date +"%T")
# Timestamp du départ de lancement de ce script
TS_START_DATE=$(date +%s)

SCRIPTNAME=$(basename $0)

clear

printf "\n"
printf "Scriptname : "$SCRIPTNAME"\n"
printf "Start      : "$START_DATE" "$START_TIME"\n"
printf "\n"
# #############################################

# pour le nom du fichier de dump.sql
BDD_DUMP_DATE=$(date +"%Y-%m-%d-%Hh%M")

# création du dump SQL
printf " | Création du dump de '"$BDD_NAME"...'\n"
mysqldump -h $BDD_HOST -u $BDD_USER -p$BDD_PASS $BDD_NAME --add-drop-table > $BDD_DUMP_FOLDER/$SUB_FOLDER/$BDD_DUMP_DATE.sql

# reccup de la derniere ligne qui doit nous confirmer l'heure de fin
tail --lines=1 $BDD_DUMP_FOLDER/$SUB_FOLDER/$BDD_DUMP_DATE.sql

# #############################################
# reccap de fin
END_DATE=$(date +"%d/%m/%Y")
END_TIME=$(date +"%T")
benchEnd=$(date +%s)
benchDuration=$(( benchEnd - TS_START_DATE ))

printf "\n"
printf "Filename   : "$PREFIX_BACKUP_FILENAME$BDD_DUMP_DATE.sql"\n"
printf "path       : "$BDD_DUMP_FOLDER/$SUB_FOLDER"\n"
printf "Spend time : "$(displayTimeFromSec $benchDuration)"\n"
printf "End        : "$END_DATE" "$END_TIME"\n"
printf "\n"