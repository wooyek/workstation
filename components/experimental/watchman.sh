#!/usr/bin/env bash

VERSION="v2022.01.24.00"

wget https://github.com/facebook/watchman/releases/download/${VERSION}/watchman-${VERSION}-linux.zip
unzip watchman-*-linux.zip
cd watchman-${VERSION}-linux
sudo mkdir -p /usr/local/{bin,lib} /usr/local/var/run/watchman
sudo cp bin/* /usr/local/bin
sudo cp lib/* /usr/local/lib
sudo chmod 755 /usr/local/bin/watchman
sudo chmod 2777 /usr/local/var/run/watchman
