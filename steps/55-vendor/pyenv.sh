#!/usr/bin/env bash

# pyenv — retained for legacy Python project maintenance.
# Self-updating. https://github.com/pyenv/pyenv-installer

echo "----> pyenv"

if [ ! -d "$HOME/.pyenv" ]; then
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
fi
