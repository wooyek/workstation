#!/usr/bin/env bash

echo "----> PyCharm"

PYCHARM_VERSION=2018.5

mkdir -p /data/opt/
cd ~
mkdir -p /data/$USER/.PyCharm$PYCHARM_VERSION/
mkdir -p /data/$USER/Pobrane/software
ln -s /data/$USER/.PyCharmPYCHARM_VERSION/

sudo tar -xzf ~/Pobrane/software/pycharm-professional-$PYCHARM_VERSION.tar.gz -C /data/opt/

echo "----> PyCharm FISH integration"
ln -s ~/.config/fish/fishd.$(hostname) /data/opt/pycharm-$PYCHARM_VERSION/plugins/terminal/fish/fishd.$(hostname)

