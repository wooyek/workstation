#!/usr/bin/env bash

# Install AUR packages listed in lists/aur.txt using yay (pre-installed
# on Omarchy). Skipped cleanly when no AUR helper is available.
cd "$(dirname "$0")/../.." || exit 1

if ! command -v yay >/dev/null 2>&1; then
    echo "yay not found — skipping AUR packages (install an AUR helper to enable)"
    exit 0
fi

echo "----> Installing from lists/aur.txt"
total=$(grep -cve '^[[:space:]]*#' -e '^[[:space:]]*$' lists/aur.txt)
i=0
while read -r package; do
    case "$package" in
        ''|\#*) continue ;;
    esac
    i=$((i + 1))
    echo "**** [$i/$total] Installing $package"
    yay -S --needed --noconfirm "$package"
done <lists/aur.txt
