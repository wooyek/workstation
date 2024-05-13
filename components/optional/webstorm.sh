#!/usr/bin/env bash

echo "----> WebStorm"

WEBSTORM_VERSION=2018.3.4

mkdir -p /data/opt/
cd ~
mkdir -p /data/$USER/Pobrane/software
#mkdir -p /data/$USER/.WebStorm$WEBSTORM_VERSION/
#ln -s /data/$USER/.WebStorm$WEBSTORM_VERSION/

sudo tar -xzf ~/Pobrane/software/WebStorm-*.tar.gz -C /data/opt/

# echo "----> PyCharm FISH integration"
# ln -s ~/.config/fish/fishd.$(hostname) /data/opt/WebStorm-$PYCHARM_VERSION/plugins/terminal/fish/fishd.$(hostname)
ln -s ~/.config/fish/fishd.$(hostname) /data/opt/WebStorm/plugins/terminal/fish/fishd.$(hostname)
