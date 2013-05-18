IS_EN=true;     # -----------> EDIT HERE! if language is Japanese
if [ $IS_EN ]
then
    # english os
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
else
    # japanese os
    export LC_ALL=ja_JP.UTF-8
    export LANG=ja_JP.UTF-8
fi

ls -GF > /dev/null 2>&1 && alias ls='ls -GF'                # unix based
ls -F --color > /dev/null 2>&1 && alias ls='ls -F --color'  # linux based
alias la='ls -a'
alias ll='ls -l'
alias vi='vim'
alias md='mkdir'

export PS1='\[\e[1;33m\][\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[1;33m\]]\n:)\[\e[m\] '
export PS2='> '
export PS4='+ '

export LSCOLORS="GxdxFxdxCxDxDxhbadExEx"

# bash config on this machine
if [ -f ~/.bash_this ]; then
     . ~/.bash_this
fi
