#!/usr/bin/env bash

echo "----> Datagrip"

sudo snap install datagrip --classic
ln -s /var/lib/snapd/desktop/applications/datagrip_datagrip.desktop ~/.local/share/applications 