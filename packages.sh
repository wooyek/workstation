#!/usr/bin/env bash

echo "----> Updating & upgrading"
sudo apt-get update
sudo apt-get upgrade -y

echo "----> Installing from packages.txt"
while read package; do
    echo "**** Installing $package"
    sudo apt install -ymf  "$package"
done <packages.txt
