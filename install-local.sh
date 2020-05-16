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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
echo "Installing vim plugins ..."
vim +PlugInstall +qa 2&> /dev/null
if [ $? ]; then
    echo "Vim plugins installation succeeded" 
else
    echo "Vim plugins installation failed!!!" 
fi

# install bin
cp -ir ~/.dotfiles/bin/ ~/bin
