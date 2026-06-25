#!/usr/bin/env bash

echo "----> Installing from snap.txt"
while read package; do
    echo "**** Installing $package"
    sudo snap install $package
done <snap.txt
