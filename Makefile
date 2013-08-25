# install dotfiles into your home directory
install : bash_profile vimrc gitconfig gitignore screenrc bashrc
	make clean
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	ln -s ~/.dotfiles/screenrc ~/.screenrc
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/gitignore ~/.gitignore
	bash ~/.bash_profile
	mkdir ~/.vim
	git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim -c "BundleInstall"

install-bash : bash_profile bashrc screenrc
	rm -vf ~/.bash_profile ~/.bashrc ~/.screenrc
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/screenrc ~/.screenrc

clean :
	rm -rfv ~/.bash_profile ~/.vimrc ~/.screenrc ~/.gitconfig ~/.gitignore ~/.git_completion.bash ~/.bashrc
	rm -rfv ~/.vim
