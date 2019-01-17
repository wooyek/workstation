#!/usr/bin/env bash

echo "----> Updating & upgrading"
sudo apt-get update
sudo apt-get upgrade -y

echo "----> Installing from packages.txt"
while read package; do
    echo "**** Installing $package"
    sudo apt install -ymf  "$package"
done <packages.txt

# KeePass2 plugins
# https://github.com/pfn/keepasshttp/
# http://lechnology.com/software/keeagent/

sudo mkdir -p /usr/lib/keepass2/plugins
sudo cp /data/$USER/Pobrane/software/KeePassPlugins/*.plgx /usr/lib/keepass2/plugins/

