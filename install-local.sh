#!/bin/sh
# install locally

# clean
rm -rfv ~/.bash_profile \
        ~/.vimrc \
        ~/.screenrc \
        ~/.gitconfig \
        ~/.gitignore \
        ~/.git_completion.bash \
        ~/.git-prompt.sh \
        ~/.bashrc \
        ~/.tmux.conf \
        > /dev/null 2>&1
rm -rfv ~/.vim \
        > /dev/null 2>&1

# bash
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bashrc ~/.bashrc

# screen & tmux
ln -s ~/.dotfiles/screenrc ~/.screenrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

# git
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore ~/.gitignore

# vim
mkdir ~/.vim
git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s ~/.dotfiles/vimrc ~/.vimrc
echo "Installing vim plugins ..."
vim +BundleInstall +qall > /dev/null
if [ $? ]; then
    echo "successfully installed!" 
fi
