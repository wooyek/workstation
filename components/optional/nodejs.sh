#!/usr/bin/env bash

echo "----> Node.js + npm + nvm"

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

# this will need a new session for `nvm` to work
bash nvm install --lts
# bash nvm use --delete-prefix v10.16.1
bash npm install gulp-cli -g

