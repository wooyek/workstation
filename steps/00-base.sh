#!/usr/bin/env bash

# Base system: directories the other steps assume, apt refresh,
# and the SSH server.

echo "----> Creating workstation directories"
mkdir -p "$HOME/Downloads/Packages"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/fish/completions"

echo "----> Updating & upgrading apt"
sudo apt-get update
sudo apt-get upgrade -y

echo "----> Enabling SSH server"
sudo apt-get install -y openssh-server
sudo systemctl enable --now ssh
