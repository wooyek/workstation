#!/usr/bin/env bash

# Homebrew (Linuxbrew) + formulae listed in lists/brew.txt.
# Some casks (lm-studio, codex, gcloud-cli) do install on Linuxbrew and are
# used here — prefix such a line with "--cask".
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
while read -r package || [ -n "$package" ]; do
    [ -z "$package" ] && continue
    i=$((i + 1))
    echo "**** [$i/$total] Installing $package"
    # A fully qualified owner/tap/formula no longer auto-taps — tap it first.
    case "$package" in
        */*/*) brew tap "${package%/*}" ;;
    esac
    brew install $package
done <lists/brew.txt

# Brew's fontconfig (a cairo/harfbuzz/openjdk dependency) is newer than the
# system's and writes cache-12 files, the format whose cache-9 symlinks
# made plasmashell segfault in FcCharSetHasChar (see
# 70-desktop/chrome-fontconfig.sh — Chrome was the writer that did it).
# Brew is kept off the shared cachedirs too, defensively. Re-applied every
# run because a fontconfig upgrade may restore the stock fonts.conf.
brew_fonts_conf="$(brew --prefix)/etc/fonts/fonts.conf"
if [ -f "$brew_fonts_conf" ]; then
    echo "----> Isolating brew fontconfig cache in ~/.cache/fontconfig-brew"
    sed -i \
        -e 's|<cachedir prefix="xdg">fontconfig</cachedir>|<cachedir prefix="xdg">fontconfig-brew</cachedir>|' \
        -e '\|<cachedir>~/.fontconfig</cachedir>|d' \
        "$brew_fonts_conf"
fi

# Brew's bin precedes /usr/bin on PATH, so pin the interactive fc-* tools
# to the system copies — they then read the cache Plasma reads.
echo "----> Pinning fc-* in fish to the system fontconfig"
mkdir -p ~/.config/fish/functions
for tool in fc-cache fc-list fc-match fc-query fc-scan fc-pattern; do
    tee ~/.config/fish/functions/$tool.fish > /dev/null <<FISH
# Managed by workstation/steps/40-brew.sh — edit there, not here.
function $tool --wraps /usr/bin/$tool --description 'system $tool, not Homebrew'
    /usr/bin/$tool \$argv
end
FISH
done
