#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

pacman_install \
    hyprland \
    hyprpicker \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    qt5-wayland \
    qt6-wayland \
    polkit-gnome \
    gnome-keyring

pacman_install \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    swappy \
    jq \
    brightnessctl \
    pavucontrol \
    wireplumber \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    network-manager-applet \
    networkmanager \
    blueman \
    bluez \
    bluez-utils \
    udiskie \
    gammastep \
    geoclue \
    trash-cli \
    qalculate-gtk

aur_install \
    ydotool \
    throne

enable_service NetworkManager.service
enable_service bluetooth.service
