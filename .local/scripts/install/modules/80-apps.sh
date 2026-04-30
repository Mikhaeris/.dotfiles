#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    mpv \
    imv \
    feh \
    file-roller \
    nm-connection-editor

aur_install \
    zen-browser-bin \
    vesktop-bin
