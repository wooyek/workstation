#!/usr/bin/env bash

# Ensure the directories the other bootstrap scripts assume exist.
# Each step runs in its own `bash x.sh` process, so per-script
# variables (e.g. PACKAGES_SOURCE in local.sh) are not shared —
# the dirs they depend on are created here once, up front.

echo "----> Creating workstation directories"

mkdir -p "$HOME/Downloads/Packages"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/fish/completions"
