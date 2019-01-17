#!/usr/bin/env bash

echo "----> mkvtoolnix"
echo "----> https://mkvtoolnix.download/downloads.html"

source /etc/os-release
echo $UBUNTU_CODENAME

wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | sudo apt-key add -
sudo apt-add-repository 'deb https://mkvtoolnix.download/ubuntu/$UBUNTU_CODENAME/ ./'
sudo apt-add-repository 'deb-src https://mkvtoolnix.download/ubuntu/$UBUNTU_CODENAME/ ./'
sudo apt install -y mkvtoolnix mkvtoolnix-gui

