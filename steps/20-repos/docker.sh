#!/usr/bin/env bash

echo "----> Docker"
echo "----> https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce"

# Move docker folder
# https://www.ibm.com/docs/en/z-logdata-analytics/5.1.0?topic=software-relocating-docker-root-directory
#sudo systemctl stop docker
#sudo systemctl stop docker.socket
#sudo systemctl stop containerd
# bat /etc/docker/daemon.json
# echo "{"data-root": "/new_dir_structure/docker"}" | sudo tee /etc/docker/daemon.json

# https://forums.docker.com/t/how-do-i-change-the-docker-image-installation-directory/1169
# sudo ln -s /data/docker /var/lib/docker

# https://linuxconfig.org/how-to-move-docker-s-default-var-lib-docker-to-another-directory-on-ubuntu-debian-linux
# This change will not be preseved after a an update
# sudo systemctl stop docker.service
# sudo systemctl stop docker.socket
# sudo rsync -aqxP /var/lib/docker/ /work/docker
# subl /lib/systemd/system/docker.service
# ExecStart=/usr/bin/dockerd --data-root /work/docker -H fd:// --containerd=/run/containerd/containerd.sock
# sudo systemctl daemon-reload
# sudo systemctl start docker
# ps aux | grep -i docker | grep -v grep


# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# https://docs.docker.com/engine/install/linux-postinstall/
echo "----> Docker groups for non sudo users"
sudo usermod -aG docker $USER
newgrp docker

echo "----> Testing docker install"
docker run hello-world

echo "----> Testing docker-compose install"
docker-compose --version
