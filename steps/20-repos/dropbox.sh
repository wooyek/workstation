#!/usr/bin/env bash

echo "----> Dropbox"

# Dropbox signs its repo with key 5044912E (fetched from keyserver).
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/dropbox.gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/dropbox.gpg] https://linux.dropbox.com/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/dropbox.list > /dev/null
sudo apt update
sudo apt install -y dropbox
