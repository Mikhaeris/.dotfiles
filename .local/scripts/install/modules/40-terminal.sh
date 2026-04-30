#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    kitty \
    zsh \
    starship \
    zsh-autosuggestions \
    zsh-fast-syntax-highlighting

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Installing oh-my-zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    ok "oh-my-zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

link_plugin() {
    local src="$1" name="$2"
    if [[ -d $src && ! -e "$ZSH_CUSTOM/plugins/$name" ]]; then
        ln -s "$src" "$ZSH_CUSTOM/plugins/$name"
        ok "Linked plugin $name"
    fi
}
link_plugin /usr/share/zsh/plugins/zsh-autosuggestions     zsh-autosuggestions
link_plugin /usr/share/zsh/plugins/fast-syntax-highlighting fast-syntax-highlighting

if [[ "$SHELL" != *zsh ]]; then
    info "Switching default shell to zsh"
    chsh -s "$(command -v zsh)" "$USER" || warn "Failed to change shell, do it manually: chsh -s \$(which zsh)"
fi
