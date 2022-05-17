#!/bin/bash

# install des libs NetStats
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

# Démarage du service
systemctl start netdata

# Ajout du server à la War room "Général"
eval "netdata-claim.sh -token="$netdataToken"  -rooms="$netdataTokenRoomGeneral" -url=https://app.netdata.cloud"
# Ajout du server à la War room "Custom"
eval "netdata-claim.sh -token="$netdataToken"  -rooms="$netdataTokenRoomCustom" -url=https://app.netdata.cloud"
