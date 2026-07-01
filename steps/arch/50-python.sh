#!/usr/bin/env bash

# Python tooling on Arch: pipx apps + shared venv home.
# No KDE plasma-workspace env file here — Omarchy runs Hyprland, so the
# WORKON_HOME export belongs in the shell/desktop config instead.
cd "$(dirname "$0")/../.." || exit 1

echo "----> Ensuring pipx"
sudo pacman -S --needed --noconfirm python-pipx
pipx ensurepath

echo "----> Installing from lists/pipx.txt"
total=$(grep -cve '^[[:space:]]*$' lists/pipx.txt)
i=0
while read -r package; do
    [ -z "$package" ] && continue
    i=$((i + 1))
    echo "**** [$i/$total] Installing $package with pipx"
    pipx install --force "$package"
done <lists/pipx.txt

echo "----> Shared virtualenv home"
sudo mkdir -p /home/venvs
sudo chown -R "$USER:$USER" /home/venvs
