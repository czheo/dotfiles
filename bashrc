export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=~/bin:$PATH
export EDITOR='vim'
export LESS=-Ri # recognize colorized output from grep and case-insensitive

# alias
if [ `uname` = "Linux" ];then
    alias ls='ls -F --color'
elif [ `uname` = "Darwin" -o `uname` = "FreeBSD" ];then
    alias ls='ls -GF'
fi
alias l='ls'
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -alh'
alias v='vim'
alias vi='vim'
alias md='mkdir'
alias rmd='rm -rvf'
alias em='emacs'

# helper functions
function crun {
  rm -rf $1;
  make $1 && ./$1;
}

# prompt
intro="\[\033["
outro="\]"
red=$intro"31m"$outro
green=$intro"32m"$outro
ylw=$intro"33m"$outro
blue=$intro"34m"$outro
clr=$intro"39;49;00m"$outro
function __files() {
    ls -l | grep "^[-d]" | wc -l | tr -d " "
}
export PS1="${red}[\t]${ylw}[\u@\h]${green}[\w]${red}\$(__git_ps1)${clr} \$(__files) files\n${ylw}:)${clr} "
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

if [ -f ~/.bashrc.local ]; then
     . ~/.bashrc.local
fi
