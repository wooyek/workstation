#!/usr/bin/env bash

# Chrome 154 (2026-09-26) statically links its own fontconfig, newer than
# the system's 2.17. On start it writes cache-12 files into the shared
# ~/.cache/fontconfig and replaces cache-9 with symlinks to them; the system
# library reads those as its own format, and plasmashell and kwin_wayland
# segfault in FcCharSetHasChar on the next start. Reproduced 2026-10-06 with
# a headless Chrome on a freshly rebuilt cache.
#
# Chrome honours FONTCONFIG_FILE, so it gets the system's font dirs and rules
# with a private cachedir. The variable is set by a shim diverted over the
# chrome binary rather than over the google-chrome launcher: the launcher
# writes its own path into CHROME_WRAPPER, which Chrome copies into web-app
# .desktop files, so a diverted launcher would leak .distrib paths there.
# dpkg-divert keeps the shim in place across Chrome upgrades.

set -euo pipefail

echo "----> Isolating Chrome's bundled fontconfig cache"

step_dir="$(cd "$(dirname "$0")" && pwd)"
install -Dm644 "$step_dir/chrome-fonts.conf" "$HOME/.config/fontconfig-chrome/fonts.conf"

chrome_bin=/opt/google/chrome/chrome
if [ ! -e "$chrome_bin" ]; then
    echo "     Chrome not installed — font config staged for later"
    exit 0
fi

if ! dpkg-divert --list "$chrome_bin" | grep -q .; then
    sudo dpkg-divert --local --rename --divert "$chrome_bin.distrib" --add "$chrome_bin"
fi
sudo install -m755 "$step_dir/chrome-shim" "$chrome_bin"

# A cache Chrome already poisoned keeps crashing Plasma until rebuilt by the
# system fontconfig, so heal it here rather than wait for the next crash.
if find "$HOME/.cache/fontconfig" -type l -print -quit 2>/dev/null | grep -q .; then
    echo "     rebuilding ~/.cache/fontconfig poisoned by an earlier Chrome"
    rm -rf "$HOME/.cache/fontconfig"
    /usr/bin/fc-cache -r
fi

echo "     restart Chrome so the running instance picks up the shim"
