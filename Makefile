# install dotfiles into your home directory
install : bash_profile vimrc gitconfig gitignore screenrc 
	make clean
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	ln -s ~/.dotfiles/screenrc ~/.screenrc
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/gitignore ~/.gitignore
	source ~/.bash_profile
	mkdir ~/.vim
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim -c "BundleInstall"

clean :
	rm -rfv ~/.bash_profile ~/.vimrc ~/.screenrc ~/.gitconfig ~/.gitignore ~/.git_completion.bash
	rm -rfv ~/.vim
