#!/bin/sh
#
#  Config de la BDD
#  données utilisées pour la création et la restauration de backup SQL
#

# accès au serveur SQL
DB_HOST=localhost
DB_USER=prestashop_admin
DB_PASS=mBtlIfSwLmYXRw3Z6ZXVRRYSsglWZQEYVDCzvUEcdG
# Le nom de la base à sauvegarder
DB_NAME="prestashop_db"

# Où sauvegarder les archives
DB_DUMP_FOLDER="/var/www/backups"
SUB_FOLDER=cdc7

# dossiers destination
if [ ! -d "$BDD_DUMP_FOLDER/$SUB_FOLDER" ]; then
	# le répertoire n'existe pas
	# Création du sous dossier
	mkdir -p "$BDD_DUMP_FOLDER/$SUB_FOLDER"
fi
