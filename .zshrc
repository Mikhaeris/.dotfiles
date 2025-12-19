# ------------------------------------------------------ #
#          _________    _______     __    __             #
#         /_____   /   /  ___  \   |  |  |  |            #
#              /  /   |  /   /_/   |  |  |  |            #
#             /  /    |  \_____    |  |__|  |            #
#            /  /      \_____  \   |   __   |            #
#           /  /        __   \  |  |  |  |  |            #
#          /  /______  / /___/  |  |  |  |  |            #
#         /_________/  \_______/   |__|  |__|            #
#                                                        #
# ------------------------------------------------------ #

# ------------------------------------------------------ #
#           __                                     __    #
#    ____  / /_     ____ ___  __  __   ____  _____/ /_   #
#   / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \  #
#  / /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /  #
#  \____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/   #
#                          /____/                        #
# ------------------------------------------------------ #

# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# ZSH_THEME="robbyrussell"
eval "$(starship init zsh)"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
  git
  sudo
  web-search
  archlinux
  copyfile
  copybuffer
  dirhistory
  zsh-autosuggestions
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.utf8

# History
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Source yazi wrapper if exists
[[ -f ~/.config/yazi/wrapper.sh ]] && source ~/.config/yazi/wrapper.sh

alias vim='nvim'
alias pkgup="sudo pacman -Syu --noconfirm && yay -Syu --noconfirm"
