#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/../common.sh"

aur_install \
    matugen-bin \
    quickshell-git \
    caelestia-shell-git \
    caelestia-cli-git
