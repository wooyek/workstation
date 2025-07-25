#!/usr/bin/env bash

echo "----> Spotify"
echo "----> https://www.spotify.com/pl/download/linux/"

# Installing with snap does not support media keys

curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update
sudo apt-get install -y spotify-client
