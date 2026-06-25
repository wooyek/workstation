#!/usr/bin/env bash

# Install any local .deb packages dropped in ~/Downloads/Packages.

PACKAGES_SOURCE="$HOME/Downloads/Packages"
mkdir -p "$PACKAGES_SOURCE"

echo "----> Installing local .deb files from $PACKAGES_SOURCE"
for deb in "$PACKAGES_SOURCE"/*.deb; do
    [ -e "$deb" ] || continue
    echo "**** Installing $deb"
    sudo gdebi -n "$deb"
done
