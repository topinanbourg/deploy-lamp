#!/bin/bash

# 
# this file contain some const
# 
 
# Enable color display
displayWithColor=true

# Hostname to set
defaultHostName="server.kalak.xyz"

# Git code hosting service:username
# ex : git@bitbucket.org:JosNo
# ex : git@github.com:topinanbourg
codeHosting="git@github.com:topinanbourg"

# NetData tokens
netdataToken="NetData-account-Token-Here"
netdataTokenRoomGeneral="room-general-hash-1234-123456789abcdef"
netdataTokenRoomCustom="room-custom-hash-1234-123456789abcdef"

# Git repo name, and subfolder name (to deploy, backups..)
repoName="lama"

# doit on ajouter des clefs ssh
declare -a sshKeysToAdd=(
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj2fUFXlX2M+d3yL6IcWJbHG9GcKHbMnbIMgOgIYfShP25Of8dMAoKQh4RtJc/CbKwa2Oyi5nRipdqUSDmSA+mBt58yPYGIdgyr4/hAiRRCBKoZjfZvjyHRkuW0dS6bdKLBnvJxMHhQg6av9sJCf1k0sA9JHgAhNdaXN3YFgirChnY8UA5I/uTmVwrx5fpiFBbyqLJ2PReok04k8uOQUtbo/aFd6XE4adELBmrc+2Kw9rbvqZ8JEQzu+sKAZ9CEO2WMQxTJMc/APm+cp3ZDXWNUUipZ9XdWQD75WQH5espJCaC8DU3YYolkQnxDT1XZ1l757O/o0R8yV4PKhxkP6k1 josno@w10-20221010"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCU38/eDLfHkQAYZKbQynOi+w1epcacid+jfy5oCTHPVPk51Kig3KDzF+gfOcXjzBZI15kyg/vBYSeHdKZHPqnyoiK17d/n4NaSlMXULR75lufGuQTgospJpcxtd4oI58n2i0hHtrueNaO/Xk97cngm+VQPmpjHx/3K3Gny0WAXUQ== JosNo2@TopMove"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/FYidiAvdx8Rw8LzJz4DcfRni4ngm70fRfcDLE8UUoMSnIwC+PrzbLou7cf40UUWfwph8mLjQdjLWflpTuqC72+ar4PkVl2/Z9s/+74MVtO0dYI7oWJLUpw3cooOVh4Qc67QqxLw8nr7qUxiGNYuiiaw8fYJ0kXbbihU8VrCBhZfui7J5sWWIC7pe3lgnscp9O0A4Y9RyHfEJcIcQaVEJF+x5bwMCxKTMoiLQuUhPubdYN14jov8AO2xgPJjJPF7wkeKEthbyySX0A3kA1m9ZvKTIiNxnRaKs13kvWUNZwmUrqJT3jHDJE0E1EDmuzCYMULJyZclPEIO2KNTvbLq9NkxBasX1zpneEe0lyXnMGenCmE0JYGsNqGEsciE6O8QhYapPGQQKtxACrlnImQWbvthjI80iICzRyMcwMHUJ9QkuvF1vOEE8Y4dMEdThyLICz//Syoaqv80sBvlHtxuES8R3yHUOm0PGuAKTGQXUdMT9QPszfkSFgr4uUu41gwiJnqytsZ7jRx3F91FcMgutrYGX+OVArCmvyzooFmawyX4Vka/4YKfLy/uFqo4HRFWRcZJ6vWc/l57c9+etlHyFxXyGd6RkkZDGWkUhIhUZxWQv5Kb5u+7Uzn+gIiJMVuNU4EprHNal06+t+P1+IicjAbjzzB6l7GDYQRumm8vEKQ== josselin.nauche@gmail.com"
)

# BDD cnx (will be overided to set "DB_HOST", ...)
default_DB_HOST="localhost"
default_DB_USER=$repoName
default_DB_PASS="unknow"
default_DB_NAME=$repoName"_db"

# where to find some backup sql to restore
folderToFetchBackUpSQL="/home/debian/backupSQL"
