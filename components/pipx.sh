#!/usr/bin/env bash

echo "----> Installing PIPX"

python3 -m pip install --user pipx
python3 -m userpath append ~/.local/bin
#fish set -U fish_user_paths ~/.local/bin

echo "----> Installing from pipx.txt"
while read package; do
    echo "**** Installing $package with PIPSX"
    # ~/.local/bin/pipx uninstall "$package"
    ~/.local/bin/pipx install --force "$package"
done <components/pipx.txt
