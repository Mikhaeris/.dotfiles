# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export HISTFILE="$HOME/.cache/bash/.bash_history"

trap '[[ -f ~/.config/bash/.bash_logout ]] && . ~/.config/bash/.bash_logout' EXIT
