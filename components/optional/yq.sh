#!/usr/bin/env bash

echo "----> yq"
echo "----> https://github.com/mikefarah/yq#plain-binary"

VERSION=v4.2.0 
BINARY=yq_linux_amd64
wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq && chmod +x /usr/bin/yq
