# Dotfiles

Arch setup, but mb work on other distro

This is configuration to work with keyboad, all stuff in this philosofy

## Requrements

```
pacman -S git stow zsh
```

some other stuf


## Instalation

in home directory
```
git clone git@github.com:Mikhaeris/.dotfiles.git
cd .dotfiles
```
### font

```
sudo pacman -S ttf-jetbrains-mono-nerd
fc-cache -fv
```

### zsh

```
sudo pacman -S zsh
```

#### starship

```
sudo pacman -S starship
```

### Stow control

In .dotfiles folder
to create symlink
```
stow .
```
delete symlinks
```
stow -D .
```

### power-profiles-daemon

link:
```
https://wiki.archlinux.org/title/CPU_frequency_scaling#power-profiles-daemon
```
repo:
```
https://gitlab.freedesktop.org/upower/power-profiles-daemon#power-profiles-daemon
```
man:
```
https://manpages.debian.org/unstable/power-profiles-daemon/powerprofilesctl.1.en.html
```

#### Smal use

enable:
```
sudo systemctl enable --now power-profiles-daemon
```

list power profiles:
```
powerprofilesctl list

```

set profile:
```
powerprofilesctl set [profile in command above]
```

### Sound

install
```
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack pipewire-jack wireplumber
```
activate services
```
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```
control
```
sudo pacman -S pavucontrol easyeffects
```

### tmux

update tpm pligind:
```
<leader> I
```

# All instruments

hyprland  - wm
kitty     - terminal

tmux
nvim
yazi
zsh


# some tools

## temperature

install:
```
sudo pacman -S lm_sensors
```

set:
```
sudo sensors-detect
```

use:
```
sensors
```

## player control
to enable keyboard prev stop next button (for music and other content)
```
sudo pacman -S playerctl
```


## gtk theme
?install:
```
paru -S nwg-look
```

```
sudo pacman -S papirus-icon-theme
```

## qt theme
install:
```
sudo pacman -S qt5ct qt6ct

```
install style:
```
yay -S breeze breeze5 breeze-icons breeze-gtk qt6ct-kde qt5ct-kde
```

## pywalfox
install:
```
paru -S pywalfox

```
run:
```
pywalfox install
```

# Mutagen theme
install:
```
paru -S matugen-bin
```
for set theme:
```
matugen image <whatever_wallpaper_you_want>
```

# Bar config

install and make eww
```
in repo
```

install:
```
sudo pacman -S wl-clipboard ...

```
