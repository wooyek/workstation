#!/usr/bin/env bash

# Self-managing installers — each tool ships its own install + upgrade
# path (rustup/cargo, uv, starship, zoxide, tx, pyenv). Kept OUT of the
# apt/brew/snap lists so the package manager and the tool's own updater
# do not fight over the same binary.
cd "$(dirname "$0")/.." || exit 1

for installer in steps/55-vendor/*.sh; do
    echo "»» $installer"
    bash "$installer"
done
