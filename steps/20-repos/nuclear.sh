#!/usr/bin/env bash

echo "----> Nuclear"
echo "----> https://github.com/nukeop/nuclear/releases"

# Nuclear ships no apt repo — fetch the latest amd64 .deb straight
# from GitHub releases and install it. Idempotent: re-running reinstalls
# whatever the latest release currently is.

deb_url=$(curl -fsSL https://api.github.com/repos/nukeop/nuclear/releases/latest |
    grep -oE '"browser_download_url": *"[^"]+_amd64\.deb"' |
    grep -oE 'https://[^"]+')

if [ -z "$deb_url" ]; then
    echo "**** Could not resolve Nuclear .deb URL — skipping"
    exit 0
fi

deb_path=$(mktemp --suffix=.deb)
echo "**** Downloading $deb_url"
curl -fsSL -o "$deb_path" "$deb_url"
sudo gdebi -n "$deb_path"
rm -f "$deb_path"
