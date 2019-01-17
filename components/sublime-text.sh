#!/usr/bin/env bash

echo "----> sublime-text"
echo "----> https://www.sublimetext.com/docs/3/linux_repositories.html"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

