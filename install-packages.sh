#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

# Update the package listing, so we know what package exist:
apt-get update

# Install security updates:
apt-get -y upgrade

# Hackish things to make things working
touch /usr/share/man/man1/maildirmake.maildrop.1.gz
touch /usr/share/man/man8/deliverquota.maildrop.8.gz
touch /usr/share/man/man1/lockmail.maildrop.1.gz
touch /usr/share/man/man5/maildir.maildrop.5.gz
touch /usr/share/man/man7/maildirquota.maildrop.7.gz


# Install a new package, without unnecessary recommended packages:
apt-get -y install --no-install-recommends \
    fetchmail \
    maildrop \
    mpack \
    ca-certificates \
    inetutils-ping \
    cron \
    rsyslog
# Add packages to install

# Delete cached files we don't need anymore:
apt-get clean
rm -rf /var/lib/apt/lists/*
