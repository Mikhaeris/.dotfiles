#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    neovim \
    tree-sitter \
    tree-sitter-cli \
    luajit \
    lua-language-server \
    stylua

pacman_install \
    gcc \
    clang \
    cmake \
    make \
    gdb \
    python \
    python-pip \
    nodejs \
    npm \
    jdk-openjdk \
    maven \
    gradle \
    texlive-basic \
    texlive-latex \
    nasm

if command -v npm >/dev/null 2>&1; then
    if ! npm list -g --depth=0 2>/dev/null | grep -q browser-sync; then
        info "Installing browser-sync globally (required for live-server in nvim)"
        sudo npm install -g browser-sync
    fi
fi

ok "Neovim is ready. Mason will install LSP/DAP on first :Mason run."
