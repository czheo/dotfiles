#!/bin/sh
# install from github

# check installed
if [ -e ~/.dotfiles ]; then
    echo "[ERROR] ~/.dotfiles existed!"
    echo "Please run:"
    echo "rm -rvf ~/.dotfiles"
    exit 1
fi

# download src
git clone https://github.com/czheo/dotfiles ~/.dotfiles || { echo "git clone failed!"; exit 1; }

# install
/bin/sh ~/.dotfiles/install-local.sh
