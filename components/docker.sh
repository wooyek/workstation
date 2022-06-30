#!/usr/bin/env bash

echo "----> Docker"
echo "----> https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce"

# Move docker folder
# https://forums.docker.com/t/how-do-i-change-the-docker-image-installation-directory/1169

# https://linuxconfig.org/how-to-move-docker-s-default-var-lib-docker-to-another-directory-on-ubuntu-debian-linux
# sudo ln -s /data/docker /var/lib/docker

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# https://docs.docker.com/engine/install/linux-postinstall/
echo "----> Docker groups for non sudo users"
sudo usermod -aG docker $USER
newgrp docker

echo "----> Testing docker install"
docker run hello-world


echo "----> Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "----> Testing docker-compose install"
docker-compose --version