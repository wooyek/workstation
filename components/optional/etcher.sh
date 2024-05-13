#!/usr/bin/env bash

echo "----> balena-io/etcher"
echo "----> https://github.com/balena-io/etcher#debian-and-ubuntu-based-package-repository-gnulinux-x86x64"

curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash
sudo apt-get update
sudo apt-get install balena-etcher-electron
