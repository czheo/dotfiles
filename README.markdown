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
	ln -s ~/.dotfiles/screenrc ~/.screenrc

get vim plugins using git submodule
	
	mkdir ~/.vim
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	
install vundle
	
	vi
	:BundleInstall

plugins installed
-----------------

	plugin			basic usage
	vundle			:BundleInstall,:BundleClean
	sparkup			<c-e>,<c-x>
	NERDTree		:e
	tcomment		<c-_><c-_>

plugin management for vim
-----------------------

using vundle: https://github.com/gmarik/vundle

basic usage of screen
----------------------

all commands are preceded by <c-a>

Basics:
0~9:		switches between windows
<c-n>:		next window
backspace:	previous window
<c-a>:		last window you were on
A:			change window name
K:			kill window
c:			create window
[,]:		copy mode

Seperation:
S:			seperate region
tab:		switch region
X:			close region


screen -ls:	list available sessions
screen -r:	attach a detached session
