#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    fzf \
    zoxide \
    fastfetch \
    btop \
    tmux \
    ripgrep \
    fd \
    bat \
    eza \
    git-delta \
    lazygit

pacman_install \
    yazi \
    ffmpeg \
    7zip \
    poppler \
    imagemagick \
    jq \
    p7zip

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d $TPM_DIR ]]; then
    info "Cloning tpm into $TPM_DIR"
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
    ok "tpm installed. Start tmux and press prefix + I to install plugins."
else
    ok "tpm is already installed"
fi
