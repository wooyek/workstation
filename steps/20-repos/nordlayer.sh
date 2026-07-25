#!/usr/bin/env bash

echo "----> NordLayer VPN"

# NordLayer publishes a release .deb that installs the repo + key.
TMP_DEB="$(mktemp --suffix=.deb)"
curl -fsSL -o "$TMP_DEB" https://downloads.nordlayer.com/linux/latest/debian/pool/main/nordlayer-release_1.0.0_all.deb
sudo apt install -y "$TMP_DEB"
rm -f "$TMP_DEB"
sudo apt update
sudo apt install -y nordlayer nordlayer-tray
