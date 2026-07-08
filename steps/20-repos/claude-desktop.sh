#!/usr/bin/env bash

echo "----> Claude Desktop (beta)"
echo "https://code.claude.com/docs/en/desktop-linux"

sudo curl -fsSLo /usr/share/keyrings/claude-desktop-archive-keyring.asc https://downloads.claude.ai/claude-desktop/key.asc
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/claude-desktop-archive-keyring.asc] https://downloads.claude.ai/claude-desktop/apt/stable stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop.list > /dev/null
sudo apt update
sudo apt install -y claude-desktop
