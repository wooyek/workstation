#!/usr/bin/env bash

# Base system for Arch / Omarchy: directories the other steps assume,
# a full system sync, base build tooling, and the SSH server.

echo "----> Creating workstation directories"
mkdir -p "$HOME/Downloads/Packages"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/fish/completions"

echo "----> Syncing & upgrading pacman"
sudo pacman -Syu --noconfirm

echo "----> Base build tooling"
sudo pacman -S --needed --noconfirm base-devel git curl

echo "----> Enabling SSH server"
sudo pacman -S --needed --noconfirm openssh
sudo systemctl enable --now sshd
