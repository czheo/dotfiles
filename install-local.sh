#!/bin/sh
# install locally

# clean
rm -rfv ~/.bash_profile \
        ~/.bashrc \
        ~/.vimrc \
        ~/.screenrc \
        ~/.gitconfig \
        ~/.gitignore \
        ~/.git_completion.bash \
        ~/.git-completion.bash \
        ~/.git-prompt.sh \
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
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
echo "Installing vim plugins ..."
vim +BundleInstall +qall 2&> /dev/null
if [ $? ]; then
    echo "successfully installed!" 
else
    echo "[ERROR] when runing \"vim +BundleInstall +qall > /dev/null 2>&1\""
fi

# install bin
cp -ir ~/.dotfiles/bin/ ~/bin
