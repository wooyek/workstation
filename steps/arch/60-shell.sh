#!/usr/bin/env bash

# Fish shell + oh-my-fish + theme (Arch).
cd "$(dirname "$0")/../.." || exit 1

sudo pacman -S --needed --noconfirm fish

echo "----> Setting fish as default shell (re-login to continue)"
chsh -s "$(which fish)"

fish fish_setup.fish
