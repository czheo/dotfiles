#!/bin/sh

# check installed
if [ -e ~/.dotfiles ]; then
    echo "~/.dotfiles existed!"
    echo -n "proceed anyway?(y/n)"
    read input
    if [ $input = "y" ]
    then
        echo "proceeding..."
    else
        echo "exit!"
        exit 1
    fi
fi

# download src
mkdir ~/.dotfiles
git clone git://github.com/czheo/dotfiles.git ~/.dotfiles

# clean
rm -rfv ~/.bash_profile \
        ~/.vimrc \
        ~/.screenrc \
        ~/.gitconfig \
        ~/.gitignore \
        ~/.git_completion.bash \
        ~/.bashrc \
        ~/.tmux.conf \
        > /dev/null 2>&1
rm -rfv ~/.vim \
        > /dev/null 2>&1

# bash
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bashrc ~/.bashrc
. ~/.bash_profile

# vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
mkdir ~/.vim
git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Installing vim plugins ..."
vim +BundleInstall +qall > /dev/null

# screen & tmux
ln -s ~/.dotfiles/screenrc ~/.screenrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

# git
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore ~/.gitignore
