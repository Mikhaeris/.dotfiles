#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

info "Updating pacman and base tools"
sudo pacman -Syu --noconfirm

pacman_install \
    base-devel \
    git \
    curl \
    wget \
    unzip

if ! command -v paru >/dev/null 2>&1; then
    info "Installing paru (AUR helper)"
    tmp="$(mktemp -d)"
    git clone --depth=1 https://aur.archlinux.org/paru.git "$tmp/paru"
    (cd "$tmp/paru" && makepkg -si --noconfirm)
    rm -rf "$tmp"
    ok "paru installed"
else
    ok "paru is already installed"
fi
