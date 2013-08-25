export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ `uname` = "Linux" ];then
    alias ls='ls -F --color'
elif [ `uname` = "Darwin" ];then
    alias ls='ls -GF'
fi
alias la='ls -a'
alias ll='ls -l'
alias vi='vim'
alias md='mkdir'

export PS1='\[\e[1;33m\][\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[1;33m\]]\n:)\[\e[m\] '
export PS2='> '
export PS4='+ '

export LSCOLORS="GxdxFxdxCxDxDxhbadExEx"

if [ -f ~/.git_completion.bash ]; then
    source ~/.git_completion.bash
else
    wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git_completion.bash
    source ~/.git_completion.bash
fi

# bash config on this machine
if [ -f ~/.bash_this ]; then
     . ~/.bash_this
fi
