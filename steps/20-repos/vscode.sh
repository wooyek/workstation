#!/usr/bin/env bash

echo "----> Visual Studio Code"
echo "https://code.visualstudio.com/docs/setup/linux#_install-vs-code-on-linux"


sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
