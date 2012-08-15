dotfiles for linux configuration
===========================

initialize configurations on a new machine
------------------

create ~/.dotfiles and clone files from git

	mkdir ~/.dotfiles
	git clone git://github.com/czheo/dotfiles.git ~/.dotfiles

create link files for bashrc, bash_profile, vimrc, vim

	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/vimrc ~/.vimrc		

get vim plugins using git submodule
	
	mkdir ~/.vim
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

plugins installed
-----------------

	plugin			basic usage
	vundle			:BundleInstall
	zencoding		<c-y>,
	NERDTree		:e
	tcomment		<c-_><c-_>

plugin management for vim
-----------------------
using vundle: https://github.com/gmarik/vundle
	
	vi
	:BundleInstall
