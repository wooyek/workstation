#!/usr/bin/env bash

# Homebrew (Linuxbrew) + formulae listed in lists/brew.txt.
# Casks are macOS-only and are intentionally not used here.
cd "$(dirname "$0")/.." || exit 1

if ! command -v brew >/dev/null 2>&1; then
    echo "----> Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "----> Installing from lists/brew.txt"
total=$(grep -cve '^[[:space:]]*$' lists/brew.txt)
i=0
while read -r package; do
    [ -z "$package" ] && continue
    i=$((i + 1))
    echo "**** [$i/$total] Installing $package"
    brew install $package
done <lists/brew.txt
