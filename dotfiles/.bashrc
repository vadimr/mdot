# __m4__

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=10000
shopt -s histappend
shopt -s checkwinsize

TERM=screen-256color
export LANG="en_US.UTF-8"

export PATH="REPDIR/bin:$PATH"

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

alias p="python3"
# export MATPLOTLIBRC="REPDIR/matplotlibrc"
# export PYTHONPATH="$PYTHONPATH:REPDIR/py"

vim_fg="vim -f"
export EDITOR="$vim_fg"
export VISUAL="$vim_fg"

source "REPDIR/git/git-completion.bash"
source "REPDIR/git/git-prompt.sh"
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
alias g="git status"

alias ls="ls --color=auto"
alias ll="ls -alhF"
alias la="ls -A"
alias l="ls -CF"
alias l1="ls -1"

alias diff="colordiff"

alias m="make -j"

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

alias gpr="git pull --rebase"
alias gpush="git push origin HEAD"
alias gst="git stash"
alias gsp="git stash pop"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--info hidden'
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
# [ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash

if [[ $- == *i* ]]; then # Check if interactive shell
  bind '"\ej": ". znav\n"'
fi

export NNN_TRASH=2

n(){
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -x "$@"

    if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
