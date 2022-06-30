#!/usr/bin/env bash

curl https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key | sudo apt-key add -
sudo add-apt-repository 'deb https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./'
sudo apt update
sudo apt install rancher-desktop