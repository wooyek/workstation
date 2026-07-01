#!/usr/bin/env bash

# Install git with whatever package manager is available, then clone and
# bootstrap. Works on Debian/Kubuntu (apt) and Arch/Omarchy (pacman).
if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get install -y git
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm git
fi

git clone https://github.com/wooyek/workstation.git
cd workstation || exit 1
bash bootstrap.sh
