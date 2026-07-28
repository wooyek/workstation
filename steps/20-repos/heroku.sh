#!/usr/bin/env bash

echo "----> Heroku CLI"
echo "----> https://devcenter.heroku.com/articles/heroku-cli"

curl -fsSL https://cli-assets.heroku.com/channels/stable/apt/release.key | sudo gpg --dearmor -o /etc/apt/keyrings/heroku.gpg
echo "deb [signed-by=/etc/apt/keyrings/heroku.gpg] https://cli-assets.heroku.com/channels/stable/apt/ ./" | sudo tee /etc/apt/sources.list.d/heroku.list > /dev/null
sudo apt update
sudo apt install -y heroku
