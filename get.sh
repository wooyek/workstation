#!/usr/bin/env bash

sudo apt-get install -y git
git clone https://github.com/wooyek/workstation.git
cd workstation || exit 1
bash bootstrap.sh
