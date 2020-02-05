#!/usr/bin/env bash

echo "----> Docker"
echo "----> https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce"

# Move docker folder
# https://forums.docker.com/t/how-do-i-change-the-docker-image-installation-directory/1169
# https://linuxconfig.org/how-to-move-docker-s-default-var-lib-docker-to-another-directory-on-ubuntu-debian-linux

sudo ln -s /data/docker /var/lib/docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
source /etc/os-release
echo $UBUNTU_CODENAME
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable"
sudo apt-get update -y && sudo apt-get install docker-ce -y
sudo usermod -aG docker $USER

