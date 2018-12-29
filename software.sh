#!/usr/bin/env bash

sudo apt-get update 
sudo apt-get upgrade -y

sudo apt install -ymf keepass2 mono-complete sublime-text gparted shutter banshee inkscape pinta calibre krusader baobab vlc vlc-plugin-samba 
sudo apt install -ymf make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev
sudo apt install -ymf fish git git-flow unzip nano build-essential libffi-dev python-dev python-pip python-virtualenv python3 python3-dev python3-pip python3-venv 
sudo apt install -ymf spatialite-bin libsqlite3-mod-spatialite libproj-dev libfreexl-dev libgdal-dev gdal-bin software-properties-common aspell-pl ruby-compass libpq-dev 
sudo apt install -ymf chromium-chromedriver xvfb default-jre handbrake shutter nfs-common graphviz fish screenfetch pandoc mercurial gdebi-core
sudo apt install -ymf samba kdenetwork-filesharing openssh-server
sudo apt install -ymf krusader ark
sudo apt install -ymf libgoo-canvas-perl python-gpgme 
sudo apt install -ymf spotify dropbox pcscd

echo "127.0.0.1	dev.example.com gandalf.example.com" | sudo tee -a /etc/hosts
echo "127.0.0.1	t1.example.com t2.example.com t3.example.com t4.example.com t5.example.com" | sudo tee -a /etc/hosts

# KeePass2 plugins 
# https://github.com/pfn/keepasshttp/
# http://lechnology.com/software/keeagent/

sudo mkdir /usr/lib/keepass2/plugins
sudo cp /data/$USER/Pobrane/software/KeePassPlugins/*.plgx /usr/lib/keepass2/plugins/


# https://www.sublimetext.com/docs/3/linux_repositories.html
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# mkvtoolnix
# https://mkvtoolnix.download/downloads.html

wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | sudo apt-key add -
sudo apt-add-repository 'deb https://mkvtoolnix.download/ubuntu/bionic/ ./'
sudo apt-add-repository 'deb-src https://mkvtoolnix.download/ubuntu/bionic/ ./'
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


# echo "»»» Syncing software instals from main workstation"
# rsync -e ssh -vzrPp janusz@hagrid.local:/data/$USER/Pobrane/software /data/$USER/Pobrane/software

mkdir -p /data/$USER/Pobrane/software
sudo gdebi /data/$USER/Pobrane/software/bcompare-4.2.3.22587_amd64.deb
sudo gdebi /data/$USER/Pobrane/software/atom-amd64.deb
sudo gdebi /data/$USER/Pobrane/software/code_1.16.0-1504714880_amd64.deb
sudo gdebi /data/$USER/Pobrane/software/gitbook-editor-7.0.12-linux-x64.deb
sudo gdebi /data/$USER/Pobrane/software/google-chrome-stable_current_amd64.deb
sudo gdebi /data/$USER/Pobrane/software/skypeforlinux-64.deb
sudo gdebi /data/$USER/Pobrane/software/vagrant_2.0.1_x86_64.deb
sudo gdebi /data/$USER/Pobrane/software/virtualbox-5.1_5.1.28-117968-Ubuntu-xenial_amd64.deb
