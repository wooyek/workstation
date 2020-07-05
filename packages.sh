#!/usr/bin/env bash

echo "----> Updating & upgrading"
sudo apt-get update
sudo apt-get upgrade -y

sudo apt install boxes

echo "----> Installing from packages.txt"
while read package; do
    echo "Installing $package" | boxes -d ada-box
    sudo apt install -ymf  "$package"
done <packages.txt
