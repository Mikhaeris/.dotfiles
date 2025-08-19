#!/usr/bin/env zsh

set -euo pipefail

packages=(
  base
  base-devel
  bibata-cursor-theme-bin
  brillo
  dnsmasq
  efibootmgr
  fastfetch
  fd
  firefox
  fzf
  gdb
  git
  grim
  grub
  gtk-layer-shell
  hyprland
  hyprlock
  hyprpaper
  imagemagick
  ipset
  jq
  kitty
  libdbusmenu-gtk3
  linux
  linux-firmware
  linux-headers
  matugen-bin
  neovim
  network-manager-applet
  networkmanager
  noto-fonts
  noto-fonts-emoji
  nwg-look
  openssh
  pamixer
  papirus-icon-theme
  paru
  paru-debug
  pavucontrol
  pipewire
  pipewire-alsa
  pipewire-pulse
  playerctl
  poppler
  power-profiles-daemon
  python-gobject
  python-pywalfox
  qbittorrent
  qt5-wayland
  qt5ct
  qt6ct
  resvg
  ripgrep
  rofi-wayland
  sddm
  slurp
  socat
  starship
  stow
  tmux
  otf-font-awesome
  ttf-fira-sans
  ttf-fira-code
  ttf-firacode-nerd
  ttf-dejavu
  noto-fonts-cjk
  noto-fonts-extra
  ttf-jetbrains-mono-nerd
  ttf-liberation
  udiskie
  unzip
  watchexec
  wayland-protocols
  wayland-utils
  wireplumber
  wl-clipboard
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  yazi
  zoxide
  zsh
)

to_pacman=()
to_paru=()

for pkg in "${packages[@]}"; do
  pacman -Qi -- "$pkg" &>/dev/null && continue

  if pacman -Si -- "$pkg" &>/dev/null; then
    to_pacman+=("$pkg")
  elif paru -Si -- "$pkg" &>/dev/null; then
    to_paru+=("$pkg")
  else
    printf 'skip: %s (not found)\n' "$pkg" >&2
  fi
done

pacman -Syu --noconfirm --needed -- "${to_pacman[@]}"

(( ${#to_paru[@]} )) && paru --needed --noconfirm -- "${to_paru[@]}"
