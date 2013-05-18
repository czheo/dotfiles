# install dotfiles into your home directory
install : bashrc bash_profile vimrc gitconfig gitignore screenrc 
	make clean
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	ln -s ~/.dotfiles/screenrc ~/.screenrc
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/gitignore ~/.gitignore
	mkdir ~/.vim
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim -c "BundleInstall"
	source ~/.bashrc

clean :
	rm -rfv ~/.bash_profile ~/.bashrc ~/.vimrc ~/.screenrc ~/.gitconfig ~/.gitignore
	rm -rfv ~/.vim
