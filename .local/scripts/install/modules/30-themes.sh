#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    papirus-icon-theme \
    adw-gtk-theme \
    qt5ct \
    qt6ct \
    kvantum \
    nwg-look

aur_install \
    bibata-cursor-theme

pacman_install adwaita-icon-theme || true
