#!/usr/bin/env bash

echo "----> doctl"
echo "----> https://docs.digitalocean.com/reference/doctl/how-to/install/"


cd /tmp/
wget https://github.com/digitalocean/doctl/releases/download/v1.79.0/doctl-1.79.0-linux-amd64.tar.gz
tar xf /tmp/doctl-1.79.0-linux-amd64.tar.gz
sudo mv /tmp/doctl /usr/local/bin

# doctl auth init --context bravelabs