#!/usr/bin/env bash

echo "----> Google Drive"

sudo apt install -y software-properties-common dirmngr
# sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./'
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
# sudo apt-key update

sudo add-apt-repository ppa:twodopeshaggy/drive
sudo apt-get update
sudo apt-get install -y drive
