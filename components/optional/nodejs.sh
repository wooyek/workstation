#!/usr/bin/env bash

echo "----> Node.js + npm + nvm"
evho "https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# this will need a new session for `nvm` to work
bash nvm install --lts
# bash nvm use --delete-prefix v10.16.1
# bash npm install gulp-cli -g

