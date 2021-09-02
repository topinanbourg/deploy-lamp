#!/bin/bash
#
# some functions:
#    jumpto
#    basename
#    displayMsg
#    displayTimeFromSec
#    getVerboseLevel & setVerboseLevel
#    checkVars
#
# parsing arguments:
#    "v", "vv" or "vvv" to set verbosity level
#    "c" or "color"     to enable color output
#    
# set var "commonsLoaded" to true
# to check if this file is already loaded
# 
# exemple of use:
#
# if [ -z ${commonsLoaded+x} ]; then
#     source ./commons.sh
# fi
#
scriptName=`basename "$0"`

# echo -e "\e[91m*** rouge ***\e[0m"
# echo -e "\e[92m*** vert  ***\e[0m"
# echo -e "\e[93m*** jaune ***\e[0m"
# echo -e "\e[94m*** bleu  ***\e[0m"


# la sortie est elle à colorer
if [ -z ${displayWithColor+x} ]; then
    # set var only if not already set
    displayWithColor=false
fi

# Niveau d'infos que l'on souhaite
# de 0 à 3
verboseLevel=0

v=false
vv=false
vvv=false

function getVerboseLevel {
    echo $verboseLevel
}

function setVerboseLevel {
    verboseLevel=$1
    if [ $verboseLevel -eq 3 ]; then
        v=true
        vv=true
        vvv=true
    elif [ $verboseLevel -eq 2 ]; then
        v=true
        vv=true
    elif [ $verboseLevel -eq 1 ]; then
        v=true
    fi
}

# displayMsg
#    Affichage d'un texte avec ou sans couleurs
#    en fonction de "displayWithColor"
#
function displayMsg {
    local message="$@"
    if [ $displayWithColor == false ]; then
        IFS='_'
        message=$(echo -e $message | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
        unset IFS
    fi
    echo -e "$message"
}

# exemple of use :
#
# jumpto "end"
#
# will go to line:
#
# : end:
# 
# https://stackoverflow.com/a/31269848
function jumpto
{
    # echo "JUMPTO $0 $1"
    label=$1
    cmd=$(sed -n "/: $label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}


# basename
#    le nom du fichier extrait de son full path
#    /var/www/backups/cdc7_2021-08-17-08h21.sql
#    =>               cdc7_2021-08-17-08h21.sql
function basename
{
    echo $(rev <<< "$1" | cut -f1 -d'/' | rev)
}

# displayTimeFromSec
# exemples de formatage :
# 1day 14h 25m 12s
# 2days 14h 25m 12s
# le nombre de jours (si > 0) +
#       14h 25m 12s
#       14h 25m
#           25min 12s
#                 12s
#
function displayTimeFromSec {
	local duration=$1
    local s=0
    local m=0
    local h=0
    local d=0
    local out=""

    if [ $duration -gt 60 ]; then
        if [ $duration -gt 3600 ]; then
            h=$(( duration / 3600 ))
            duration=$(( duration - (h * 3600) ))
            if [ $h -gt 24 ]; then
                d=$(( h / 24 ))
                h=$(( h - (d * 24) ))
                if [ $d -gt 1 ]; then
                    out="${d}days "
                else
                    out="${d}day "
                fi
            fi
        fi
        m=$(( duration / 60 ))
        duration=$(( duration - (m * 60) ))

    fi
    s=$duration

    if [ $h -gt 0 ]; then
        if [ $h -lt 10 ]; then
            out="${out}0${h}h "
        else
            out="${out}${h}h "
        fi
        if [ $m -lt 10 ]; then
            out="${out}0${m}m "
        else
            out="${out}${m}m "
        fi
        if [ $s -lt 10 ]; then
            out="${out}0${s}s "
        else
            out="${out}${s}s "
        fi
    else
        if [ $m -gt 0 ]; then
            out="${out}${m}min ${s}s"
        else
            out="${out}${s}s"
        fi
    fi
	echo $out
}

# checkVars
#    check if vars name are set and not empty
#    
function checkVars
{
    for varname in "$@"
    do
        if [ -z "${!varname}" ]; then
            displayMsg "Missing var \e[91m"$varname"\e[0m."
            exit
        fi
    done
}

# reccup des argument passés
for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)

    case "$KEY" in
        vvv)                setVerboseLevel 3 ;;
        vv)                 setVerboseLevel 2 ;;
        v)                  setVerboseLevel 1 ;;
        color)              displayWithColor=true ;;
        c)                  displayWithColor=true ;;
        *)
    esac
done

# Timestamp du départ de lancement de ce script
TS_START_DATE=$(date +%s)

commonsLoaded=true
