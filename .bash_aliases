
###
### liste d'alias utils
### cf : http://linux-attitude.fr/post/bashrc-collaboratif
###
### PAS D'ESPACE AUTORISE AVANT NI APRÈS LE SIGNE "="
###

# Quelle distribution ( version )
alias distrib='lsb_release -dc'

## Processus:
# Sécurités bash:
alias killall='killall -i' # confirmation

# Sécurité ( ne pas écraser un lien par un autre ! )
alias ln='ln -i'

# Sécurité ( utiliser www-data pour svn, git, hg et composer)
alias svn='sudo -u www-data svn'
alias git='sudo -u www-data git'
alias up='git fetch; git merge'
alias composer='sudo -u www-data composer'

# git en plus court
alias st='sudo -u www-data git status '
alias co='sudo -u www-data git checkout '
alias ci='sudo -u www-data git commit '

# Lister les liens symbolique ( répertoire courant )
alias liens_symboliques='ls -l $(find . -type l)'

# Souvent je frappe trop vite et manque l'espace..
alias psax='ps ax -o user,pid,command'
alias psaux='ps aux'
alias psauxw='ps auxww -o user,pid,command'
alias psaxw='ps axww'

alias chown='chown -h'
# -h : pour un lien, change le propriétaire/groupe du lien lui même

# pour redonner a apache les droits sur le dossier courrant
alias chw='chown www-data:www-data . -R'

# Internet : connexion au réseau ADSL ( dhcp ) et mise à l'heure système
alias maj_date='date +%Hh%Mm%Ss && /usr/sbin/ntpdate -s fr.pool.ntp.org && echo +%Hh%Mm%Ss'

### Répertoires, fichiers,:
### Pour les gros doigts
alias cd-='cd -'
alias cd..='cd ..'
alias ..=' cd ..'
alias vdir='ls --color=auto --format=vertical'

# Remonter d'un dossier et ls
#alias up="cd .. && ls -lAh --color"

## ls --color=auto supprime la couleur dans un pipe ( less, more )
alias ls='ls -CFlAh --color'
# -A : affiche aussi les fichiers commençant par un point
# -h : affiche la taille avec B/K/M/G;
# -F : affiche un caractère à la fin du nom indiquant le type de fichier
alias l='ls -CF'
alias l1='ls -1'
alias lh='ls -lh'
alias ll='ls -l'

# Classé par date
alias lt='ls -lt'
alias lot='ls -ot'

# par date inversé
alias ltr='ls -ltr'
alias ltrh='ls -ltrh'
alias lotr='ls -otr'
alias lotrh='ls -otrh'

# Affiche les fichiers cachés, mais pas . ni ..
alias la='ls -A'
alias lla='ls -lA'

# ne lister QUE les fichiers cachés
alias la+='ls -Ad .*'
alias lla+='ls -Adl .*'

# ls -l sauf les groupes
alias lo='ls -o'
alias loh='ls -oh'

#Trier (tout) par taille: (n'accepte aucun argument )
alias lsS='ls -lSrAh --color'

# like windows
alias cls='clear'
alias cd..='cd ..'

#
# NAVIGUER AVEC HISTORIQUE DES RÉPERTOIRES (pushd dirs et popd)
#
# Liste l'historique des répertoires avec son N°
alias dir='dirs -v'

# Ajoute le répertoire courant à l'historique
# ou va au répertoire désiné par son N° (visible par dirs -v)
alias pu+='dirs -v ; pushd'
alias pu+?='echo -e "Affiche la pile (dirs) et lance pushd \n pushd /un/chemin/ ajoute ce chemin à la pile et y va \n pushd +N° va à cette adresse\n"'

##
## pushd pour fainéant = dirs préalable puis pushd avec un nombre sans "+" ou un chemin!
## limite 1 : les autres options de pushd nécessitent pushd..
## limite 2 : on perd l'autocomplétion bien utile dans la recherche de répertoire et l'expansion du tilde ~
## limite 3 : inadapté pour ajouter un répertoire !
## l'opération let permet de différencier un nombre ; 2>/dev/null nettoie l'affichage d'erreur résultant dans le cas contraire
#alias pu='dirs -v && read -p ">" && echo $REPLY && let n=$REPLY+0 2>/dev/null && pushd +$REPLY || pushd $REPLY'
#alias pu?='echo "Affiche la pile et prend un numéro (sans signe +) ou un chemin (même sans guillemet), et va dans le répertoire correspondant."'
#alias pushd?='echo "pushd" && echo "pushd /un/nouveau/chemin/ ajoute ce répertoire à la pile et y va " && echo "pushd -n /nouveau/chemin/ ajoute ce répertoire à la pile sans changer le répertoire courant" && echo "pushd +X va à l adresse n°X " '
## popd ( = enlève le répertoire )
## alias po='popd -n'
## popd pour fainéant: affiche dirs puis prend un numéro (ou "+" pour sortir)
#alias po='dirs -v && echo " + pour annuler" && read -p "Ôter>" && popd +$REPLY 2>/dev/null || if [[ ! $REPLY == + ]] ; then echo "donnez un nombre valide ou [+] pour annuler" ;fi '
#alias po?='echo "(po=popd -n) ( -n = ne change pas le répertoire courant)" && echo "popd +0 enlève le 1er" && echo "popd -0 enlève le dernier"'

# UTILISER L'HISTORIQUE DES COMMANDES:
# relancer une commande par son N°
alias fcs='fc -s'

# less avec 4 espaces par tabulation ( au lieu de 8 )
alias less='less -x4'

# less -R accepte la couleur:
alias less='less -R'

# COPIES:
# Copier le plus récent,(u =update) et numéroter (si au moins une sauvegarde existe déjà):
alias cpb='cp -au --backup=t'
alias cpbkp='cpb'

# occupation disque humainement lisible
alias dfh='df -hT | egrep "%|/"'

# Idem, Sans afficher les partitions virtuelles:
alias df-='df -hT | egrep Sys. && ( df -hT | egrep "^/dev/|^[[:blank:]]" | egrep "^/dev/|[[:digit:]][[:digit:]]*%") '

# Idem, avec nombre des partitions physiques:
#alias df+='df -hT 2>&1 | egrep "^/dev|^[[:blank:]]" && (echo -n "Partitions physiques: " ; df -hT | egrep ^/dev/ | wc -l )'

# Un autre df+
alias df+="df | egrep Dispo && df -Th | egrep '^[/]|^[[:blank:]]|tmp$' |egrep '[^[:blank:]]*%|VG_tout-.*$'"

# Sophistiqué (couleur)
alias df!="df -hT | egrep '^/dev/[^[:blank:]]*$|[^[:blank:]Uti]*%|[^[:blank:]]*fs|ext[234]'"

# tmpfs:
alias tmpfs='df -hT | egrep "Type|tmpfs"'
alias tmp='df -hT | egrep /tmp$ | egrep [[:digit:]]*% '

# espace répertoire
# lisible sans sous-répertoires
alias du1='du -h --max-depth=1'

# lisible détaillé
alias duh='du -h'

# lisible total seulement
alias dus='du -sh'
alias dush='du -sh'

### Liste des partitions montées ou non ! (à l'allumage )
alias partitions='cat /proc/partitions'

####### PAQUETS DEBIAN ########
# l'intéret de certains alias est douteux
# j'utilise surtout search et show, update, upgrade, install
##### apt et dpkg #####

# liste des fichiers d' un package installé:
alias listi='dpkg -L '

# liste des fichiers d' un package -installé ou non- ( dépend de apt-file ):
alias list='apt-file list '

# search avec indication d'installation (+ ou -) (dépend de mon script debintall):
alias search='/usr/local/bin/debinstall'

# search + show ! :
alias search+='apt-cache --full search '

# Recherche sur le nom de paquet seulement:
alias searchn='apt-cache search --names-only'

# nom de fichier=> quel Package ? (dépend de apt-file )
alias searchpack='apt-file search'

# infos sur le paquet:
alias show='apt-cache show'

# liste des versions disponibles d'un paquet ( dépend de apt-show-versions): :
alias showversions='apt-show-versions -a | grep -i'

# liste des paquets qui vont ètre mis à jour ( dépend de apt-show-versions):
# (avec apt-get upgrade et dist-upgrade):
alias showupdate='apt-show-versions -u'

# dépendances d'un paquets:
alias depends='apt-cache depends'

# # Pour les 3 suivants, il faut configurer sudo (visudo):
# Mises à jour ordinaires:
alias upgrade='sudo aptitude update && sudo aptitude safe-upgrade'

# update
alias update='sudo aptitude update'

#install
alias install='sudo aptitude install'

####### MATERIEL #######

#Température des disques
alias temphd='for i in a b ; do sudo hddtemp /dev/sd$i ; done'

# cpuinfo
alias cpuinfo+='less /proc/cpuinfo'
alias cpuinfo='less /proc/cpuinfo | egrep "processor|cpu MHz|physical id|core id|^$"'


####### Raccourcis chemins #######
alias repwww='cd /var/www'
alias cdwww='cd /var/www'
alias www='cd /var/www'
alias phab='cd /var/www/tnt/apps/phabricator/phabricator'
alias cdc='cd /var/www/curiositas'
