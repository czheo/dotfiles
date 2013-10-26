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

color_yellow='\[\e[0;33m\]'
color_bblue='\[\e[1;34m\]'
color_close='\[\e[m\]'

export PS1=`echo -e "$color_yellow[\u@\h]$color_close$color_bblue[\w]$color_close\n$color_yellow:)$color_close "`
export PS2='> '
export PS4='+ '

export LSCOLORS="GxdxFxdxCxDxDxhbadExEx"

if [ -f ~/.git_completion.bash ]; then
    . ~/.git_completion.bash
else
    wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git_completion.bash
    . ~/.git_completion.bash
fi

# bash config on this machine
if [ -f ~/.bash_this.sh ]; then
    . ~/.bash_this.sh
else
    touch ~/.bash_this.sh
fi
