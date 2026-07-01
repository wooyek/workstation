#!/usr/bin/env bash

# Install pacman packages listed in lists/arch.txt
cd "$(dirname "$0")/../.." || exit 1

echo "----> Installing from lists/arch.txt"
total=$(grep -cve '^[[:space:]]*#' -e '^[[:space:]]*$' lists/arch.txt)
i=0
while read -r package; do
    case "$package" in
        ''|\#*) continue ;;
    esac
    i=$((i + 1))
    echo "**** [$i/$total] Installing $package"
    sudo pacman -S --needed --noconfirm "$package"
done <lists/arch.txt
