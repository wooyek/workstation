#!/usr/bin/env bash
# Python

echo "----> Updating PIP"
sudo pip3 install wheel pip setuptools -U
#sudo pip2 install wheel pip setuptools virtualenv  -U

# echo "----> Installing Bash completitions"
# curl https://raw.githubusercontent.com/pyinvoke/invoke/master/completion/bash -o /etc/bash_completion.d/

echo "----> Installl PyEnv"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

# Run this in fish to setup path
# set -a fish_user_paths /data/$USER/.pyenv/bin/

echo "----> IDE spellchecker dictionaries"
aspell --lang pl dump master | aspell --lang pl expand | tr ' ' '\n' | sudo tee /usr/share/dictionaries-common/polish.dic

