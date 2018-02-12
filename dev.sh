#!/usr/bin/env bash



# Settings > Create desktop entry
# /data/opt/pycharm-2017.3.2/bin/pycharm.sh
# /data/opt/WebStorm-172.3317.70/bin/webstorm.sh


# Heroku CLI
# https://devcenter.heroku.com/articles/heroku-cli#debian-ubuntu
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh


# Docker
# - https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce
sudo ln -s /data/docker /var/lib/docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
source /etc/os-release
echo $UBUNTU_CODENAME
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable"
sudo apt-get update -y && sudo apt-get install docker-ce -y
sudo usermod -aG docker $USER

# Python

sudo pip3 install wheel pip setuptools -U
sudo pip2 install wheel pip setuptools virtualenv  -U
curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python3
pipsi install legit 
pipsi install pew
pipsi install pipenv
pipsi install invoke
pipsi install bump2version
pipsi install tox


# Bash completitions
curl https://raw.githubusercontent.com/pyinvoke/invoke/master/completion/bash -o /etc/bash_completion.d/

# Installl PyEnv
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash


# IDE spellchecker dictionaries
aspell --lang pl dump master | aspell --lang pl expand | tr ' ' '\n' | sudo tee /usr/share/dictionaries-common/polish.dic

# Pycharm
mkdir -p /data/opt/
cd ~ 
ln -s /data/$USER/.PyCharm2017.3/
ln -s /data/$USER/.WebStorm2017.3/
tar -xzf ~/Pobrane/software/pycharm-professional-2017.3.2.tar.gz -C /data/opt/
tar -xzf ~/Pobrane/software/WebStorm-2017.2.tar.gz -C /data/opt/
# This is neded to start fish shell from PyCharm
sudo ln -s ~/.config/fish/fishd.hagrid /data/opt/pycharm-2017.3.2/plugins/terminal/fish/fishd.hagrid
