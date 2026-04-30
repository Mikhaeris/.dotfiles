#!/usr/bin/env bash

if [[ -t 1 ]]; then
    C_RESET=$'\033[0m'
    C_BLUE=$'\033[1;34m'
    C_GREEN=$'\033[1;32m'
    C_YELLOW=$'\033[1;33m'
    C_RED=$'\033[1;31m'
    C_BOLD=$'\033[1m'
else
    C_RESET=""; C_BLUE=""; C_GREEN=""; C_YELLOW=""; C_RED=""; C_BOLD=""
fi

info()    { echo "${C_BLUE}[i]${C_RESET} $*"; }
ok()      { echo "${C_GREEN}[✔]${C_RESET} $*"; }
warn()    { echo "${C_YELLOW}[!]${C_RESET} $*" >&2; }
err()     { echo "${C_RED}[✘]${C_RESET} $*" >&2; }
section() { echo; echo "${C_BOLD}=== $* ===${C_RESET}"; }

pacman_install() {
    [[ $# -eq 0 ]] && return 0
    info "pacman: installing $*"
    sudo pacman -S --needed --noconfirm "$@"
}

aur_install() {
    [[ $# -eq 0 ]] && return 0
    if ! command -v paru >/dev/null 2>&1; then
        err "paru is not installed. Run module 00-base first."
        return 1
    fi
    info "AUR: installing $*"
    paru -S --needed --noconfirm "$@"
}

enable_service() {
    local svc="$1"
    info "systemctl enable --now $svc"
    sudo systemctl enable --now "$svc"
}
