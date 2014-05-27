export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=~/bin:$PATH

# alias
if [ `uname` = "Linux" ];then
    alias ls='ls -F --color'
elif [ `uname` = "Darwin" -o `uname` = "FreeBSD" ];then
    alias ls='ls -GF'
fi
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias vi='vim'
alias md='mkdir'
alias rmd='rm -rvf'

# prompt
cred='\[\e[0;31m\]'
cyellow='\[\e[0;33m\]'
cbblue='\[\e[1;34m\]'
cclose='\[\e[m\]'
export PS1="${cyellow}[\u@\h]${cclose}${cbblue}[\w]${cclose}${cred}\$(__git_ps1)${cclose}\n${cyellow}:)${cclose} "
export PS2='> '
export PS4='+ '

# ls color
export LSCOLORS="GxdxFxdxCxDxDxhbadExEx"

# git-completion
# auto-complete git commands
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
else
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    . ~/.git-completion.bash
fi

# git-prompt
# show git current branch for you
if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
else
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
    . ~/.git-prompt.sh
fi

# bash config on this machine
if [ -f ~/.bash_this.sh ]; then
    . ~/.bash_this.sh
else
    touch ~/.bash_this.sh
fi
