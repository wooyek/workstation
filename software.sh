#!/usr/bin/env bash

sudo apt-get update 
sudo apt-get upgrade -y

sudo apt install -y keepass2 dropbox git git-flow unzip nano build-essential libffi-dev python-dev python-pip python-virtualenv python3 python3-dev python3-pip python3-venv spatialite-bin libsqlite3-mod-spatialite libproj-dev libfreexl-dev libgdal-dev gdal-bin mono-complete software-properties-common aspell-pl ruby-compass libpq-dev chromium-chromedriver xvfb sublime-text gparted shutter banshee default-jre handbrake shutter libgoo-canvas-perl nfs-common inkscape python-gpgme pinta calibre graphviz fish make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev screenfetch pandoc mercurial snapd krusader spotify-client baobab vlc vlc-plugin-samba tortoisehg spotify-client

echo "127.0.0.1	dev.example.com gandalf.example.com" | sudo tee -a /etc/hosts
echo "127.0.0.1	t1.example.com t2.example.com t3.example.com t4.example.com t5.example.com" | sudo tee -a /etc/hosts

# KeePass2 plugins 
# https://github.com/pfn/keepasshttp/
# http://lechnology.com/software/keeagent/

sudo mkdir /usr/lib/keepass2/plugins
sudo cp /data/$USER/Pobrane/software/KeePassPlugins/*.plgx /usr/lib/keepass2/plugins/


# mkvtoolnix
# https://mkvtoolnix.download/downloads.html

wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | sudo apt-key add -
sudo apt-add-repository 'deb https://mkvtoolnix.download/ubuntu/xenial/ ./'
sudo apt-add-repository 'deb-src https://mkvtoolnix.download/ubuntu/xenial/ ./'
sudo apt install -y mkvtoolnix mkvtoolnix-gui


# Google Drive

sudo apt install -y software-properties-common dirmngr
sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
sudo apt-key update
sudo apt-get update
sudo apt-get install -y drive


# Node.js + npm + nvm

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
nvm install node


# YARN

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn
