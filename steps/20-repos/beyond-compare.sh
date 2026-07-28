#!/usr/bin/env bash

echo "----> Beyond Compare"
echo "----> https://www.scootersoftware.com/kb/linux_install"

curl -fsSL https://www.scootersoftware.com/scootersoftware-keyring.gpg | sudo dd of=/usr/share/keyrings/scootersoftware-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/scootersoftware-keyring.gpg] https://www.scootersoftware.com/ bcompare4 non-free" | sudo tee /etc/apt/sources.list.d/scootersoftware.list > /dev/null
sudo apt update
sudo apt install -y bcompare
