HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=10000
shopt -s histappend
shopt -s checkwinsize

TERM=screen-256color
export LANG="en_US.UTF-8"

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

PATH="$PATH:$HOME/.vrutls/bin"

vim_fg="vim -f"
export EDITOR="$vim_fg"
export VISUAL="$vim_fg"

alias ls="ls --color=auto"
alias ll="ls -alhF"
alias la="ls -A"
alias l="ls -CF"
alias l1="ls -1"

alias g="git status"
alias p="python3"
alias diff="colordiff"
alias rr=". ranger"

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
