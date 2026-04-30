#!/usr/bin/env bash
# Usage
#   ./install.sh              # install all
#   ./install.sh 40-terminal  # install one module
#   ./install.sh --list       # show list of modules

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

MODULES_DIR="$SCRIPT_DIR/modules"

list_modules() {
    info "Available modules:"
    for f in "$MODULES_DIR"/*.sh; do
        [[ -f $f ]] || continue
        echo "  - $(basename "$f" .sh)"
    done
}

run_module() {
    local module_path="$1"
    local module_name
    module_name="$(basename "$module_path" .sh)"

    section "▶ Module: $module_name"
    if bash "$module_path"; then
        ok "Module '$module_name' completed"
    else
        err "Module '$module_name' failed"
        return 1
    fi
}

case "${1:-}" in
    --list|-l)
        list_modules
        exit 0
        ;;
    -h|--help)
        cat <<EOF
install.sh — system installation from dotfiles

Usage:
  $0                  install everything (all modules in order)
  $0 <module>         install a single module (e.g.: 40-terminal)
  $0 --list           show list of modules
  $0 --help           this help
EOF
        exit 0
        ;;
esac

if [[ $EUID -eq 0 ]]; then
    err "Do not run the script as root. sudo is used internally when needed."
    exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
    err "pacman not found. This script is intended only for Arch Linux and derivatives."
    exit 1
fi

case "${1:-}" in
    "")
        section "Starting full installation"
        for module in "$MODULES_DIR"/*.sh; do
            [[ -f $module ]] || continue
            run_module "$module"
        done
        section "✔ Installation completed"
        info "Reboot or re-login to apply all changes."
        ;;
    *)
        target="$MODULES_DIR/${1}.sh"
        if [[ ! -f $target ]]; then
            err "Module '$1' not found."
            list_modules
            exit 1
        fi
        run_module "$target"
        ;;
esac
