#!/usr/bin/env bash

echo "----> Installing PIPX"
echo "----> https://github.com/pypa/pipx?tab=readme-ov-file#on-linux"

sudo apt install pipx

#export PIPX_HOME=/data/$USER/.local/pipx
# python3 -m pip install --user pipx
# python3 -m userpath append ~/.local/bin
#python3 -m pip install --user pipx
#python3 -m pipx ensurepath
#fish set -U fish_user_paths ~/.local/bin

echo "----> Installing from pipx.txt"
while read package; do
    echo "**** Installing $package with PIPX"
    pipx install --force "$package"
done <components/pipx.txt
