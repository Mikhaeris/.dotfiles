#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    ttf-jetbrains-mono-nerd \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-mono \
    noto-fonts \
    noto-fonts-emoji \
    noto-fonts-cjk \
    ttf-carlito \
    ttf-material-symbols-variable-git || true

aur_install \
    ttf-times-new-roman \
    ttf-rubik \
    ttf-figtree \
    adwaita-fonts || warn "Some fonts were not found in AUR — check package names in paru manually"

if ! fc-list | grep -qi "Material Symbols"; then
    aur_install ttf-material-symbols-variable || true
fi

info "Updating font cache"
fc-cache -f
ok "Fonts installed"
