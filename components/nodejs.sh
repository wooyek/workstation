#!/usr/bin/env bash

echo "----> Node.js + npm + nvm"

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
# this will need a new session for `nvm` to work
nvm install node

npm install -g gulp