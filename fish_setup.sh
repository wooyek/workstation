#!/usr/bin/env bash

# Nerdfonts
# cd ~/.local/share/fonts && curl -fLo "Sauce Code Pro Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf
# cd ~/.local/share/fonts && curl -fLo "Sauce Code Pro Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf

sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update -y && sudo apt-get install fish -y

echo "Changing defautl shell, re-login to conitunue"
chsh -s $(which fish)
fish fish_setup.fish
