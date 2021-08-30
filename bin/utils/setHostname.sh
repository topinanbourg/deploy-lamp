#!/bin/bash

if [ -z ${commonsLoaded+x} ]; then
	echo "These script must be run into a launcher."
	exit
fi

# check required var
checkVars "defaultHostName"

# Correction du nom de la machine
: waitForNewHostname:
newHostName=""
echo ""
echo ""
echo "Correct host name"
displayMsg -e "Fill new name, or leave blank to use \e[92m"$defaultHostName"\e[0m"
echo -n
read userinput
if [ "$userinput" == "" ]; then
	newHostName=$defaultHostName
else
	newHostName=$userinput
	echo ""
	displayMsg -e "Use \e[92m"$newHostName"\e[0m as new host name ?"
	echo "(y)es / (n)o"
	echo -n
	read userinput
	# Check if user want to proceed
	if [[ $userinput != "y" && $userinput != "Y" ]]; then
		jumpto "waitForNewHostname"
	fi
fi

hostnamectl set-hostname $newHostName
