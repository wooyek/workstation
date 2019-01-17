#!/usr/bin/env bash

echo "----> Installing PIPSI"

#curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python3
#PATH=/home/$USER/.local/bin:$PATH

echo "----> Installing from pipsi.txt"
while read package; do
    echo "**** Installing $package with PIPSI"
    pipsi uninstall --yes "$package"
    pipsi install "$package"
done <pipsi.txt