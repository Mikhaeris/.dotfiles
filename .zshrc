# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
#unsetopt beep notify
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/mikhaeris/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall


eval "$(starship init zsh)"

# Source yazi wrapper if exists
[[ -f ~/.config/yazi/wrapper.sh ]] && source ~/.config/yazi/wrapper.sh

