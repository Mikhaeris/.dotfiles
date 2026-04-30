#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

if [[ ! -d "$DOTFILES_DIR/.config" ]]; then
    err "Directory not found: $DOTFILES_DIR/.config"
    err "Specify path manually: DOTFILES_DIR=/path/to/dotfiles ./install.sh 90-dotfiles"
    exit 1
fi

info "Using DOTFILES_DIR=$DOTFILES_DIR"

BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$1" dest="$2"
    if [[ -e $dest && ! -L $dest ]]; then
        mkdir -p "$BACKUP_DIR"
        info "Backing up $dest -> $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    elif [[ -L $dest ]]; then
        rm "$dest"
    fi
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    ok "$dest -> $src"
}

mkdir -p "$HOME/.config"
for entry in "$DOTFILES_DIR/.config"/*; do
    [[ -e $entry ]] || continue
    name="$(basename "$entry")"
    link "$entry" "$HOME/.config/$name"
done

for f in .gtkrc-2.0; do
    [[ -e "$DOTFILES_DIR/$f" ]] || continue
    link "$DOTFILES_DIR/$f" "$HOME/$f"
done

if [[ -d $BACKUP_DIR ]]; then
    info "Old files are stored in $BACKUP_DIR"
fi
