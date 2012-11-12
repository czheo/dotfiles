# alias ls='ls -GF'         # freebsd
alias ls='ls -F --color'    # centos
alias la='ls -a'
alias ll='ls -l'
alias vi='vim'

export PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]:)\[\e[m\] '
export PS2='> '
export PS4='+ '

export LSCOLORS="GxdxFxdxCxDxDxhbadExEx"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# show screens
screen -ls

# bash config on this machine
if [ -f ~/.bash_this ]; then
     . ~/.bash_this
fi
