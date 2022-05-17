# Deploy

## Installation

Copy files in folder `/home/debian`

```
.bash_aliases
.bashrc
.gitconfig
.gitignore
.profile
const.sh
install.sh
upgradePHP8.sh
```

.. and the folder `bin`

## Run

```bash
$ sudo su -
$ chmod +x /home/debian/install.sh
$ /home/debian/install.sh
```

you will be prompted to change some constant (in `const.sh`) and installation will proceed
(with few questions to answer during process)

## Check

After installation, you can check installed sofwares with the hostname defined in `const.sh`
(if DNS is well set)

```
# Hostname to set
defaultHostName="server.kalak.xyz"
```

https://server.kalak.xyz

## Upgrade to php8

to upgrade from php7 to php8

```bash
$ sudo su -
$ chmod +x /home/debian/upgradePHP8.sh
$ /home/debian/upgradePHP8.sh
```
