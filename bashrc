export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=~/.dotfiles/bin:~/bin:$PATH
export EDITOR='vim'
export LESS=-Ri # recognize colorized output from grep and case-insensitive
export HISTSIZE=99999
export HISTFILESIZE=99999

# so you can `export some_dir=~/some/dir` and `cd some_dir`
# https://stackoverflow.com/a/39839346/1061751
shopt -s cdable_vars

# alias
if [ $(uname) = "Linux" ]; then
  alias ls='ls -F --color'
elif [ $(uname) = "Darwin" -o $(uname) = "FreeBSD" ]; then
  alias ls='ls -GF'
fi
alias l='ls'
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -alh'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias md='mkdir -p'
alias rmd='rm -rvf'
alias em='emacs'

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
function __tmux_pane() {
  if [ -n "${TMUX+set}" ]; then
    echo "[tmux${TMUX_PANE}]"
  fi
}
export PS1="${red}[\t]"
export PS1="$PS1${ylw}[\u@\h]"
export PS1="$PS1${green}[\w]"
export PS1="$PS1${red}\$(__git_ps1)${clr}"
export PS1="$PS1\$(__tmux_pane)"
export PS1="$PS1 \$(__files) files"
export PS1="$PS1\n${ylw}:)${clr} "
export PS2='> '
export PS4='+ '

# ls color
export LSCOLORS="GxdxFxdxCxDxDxhbadExEx"

# git-completion
# auto-complete git commands
if [ ! -f ~/.git-completion.bash ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
. ~/.git-completion.bash

# git-prompt
# show git current branch for you
if [ ! -f ~/.git-prompt.sh ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi
. ~/.git-prompt.sh

# helper functions
function crun {
  rm -rf $1
  make $1 && ./$1
}

function dot {
  cd ~/.dotfiles
}

function sb {
  source ~/.bashrc
}

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
