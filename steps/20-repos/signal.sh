#!/usr/bin/env bash

echo "----> Signal Desktop"

# Signal officially ships only the xenial suite — it works on all Ubuntu releases.
curl -fsSL https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor -o /usr/share/keyrings/signal-desktop-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null
sudo apt update
sudo apt install -y signal-desktop
