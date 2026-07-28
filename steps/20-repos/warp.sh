#!/usr/bin/env bash

echo "----> Warp terminal"
echo "----> https://docs.warp.dev/getting-started/getting-started-with-warp"

curl -fsSL https://releases.warp.dev/linux/keys/warp.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/warpdotdev.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" | sudo tee /etc/apt/sources.list.d/warpdotdev.list > /dev/null
sudo apt update
sudo apt install -y warp-terminal
