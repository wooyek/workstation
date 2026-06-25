#!/usr/bin/env bash

echo "----> OpenVPN 3 Linux"
echo "----> https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux"


source /etc/os-release
echo $UBUNTU_CODENAME

wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
apt-key add openvpn-repo-pkg-key.pub

wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$UBUNTU_CODENAME.list
apt update
apt install openvpn3