#!/usr/bin/env bash

echo "----> Installing from brew.txt"
while read package; do
    echo "**** Installing $package"
    brew install $package
done <brew.txt
