# install dotfiles into your home directory
install : clean install-screen install-git install-bash install-vim

install-bash : bash_profile bashrc screenrc
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/bashrc ~/.bashrc
	. ~/.bash_profile

install-vim : vimrc
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	mkdir ~/.vim
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim +BundleInstall +qall

install-screen : screenrc tmux.conf
	ln -s ~/.dotfiles/screenrc ~/.screenrc
	ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

install-git : gitignore gitconfig
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/gitignore ~/.gitignore

clean :
	rm -rfv ~/.bash_profile ~/.vimrc ~/.screenrc ~/.gitconfig ~/.gitignore ~/.git_completion.bash ~/.bashrc ~/.tmux.conf
	rm -rfv ~/.vim

.PHONY:install install-bash install-vim install-screen install-git clean
