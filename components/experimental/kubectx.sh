#!/usr/bin/env bash

echo "----> kubectx"
echo "----> https://github.com/ahmetb/kubectx#apt-debian"


sudo git clone https://github.com/ahmetb/kubectx /usr/local/kubectx
sudo ln -s /usr/local/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /usr/local/kubectx/kubens /usr/local/bin/kubens