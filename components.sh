#!/usr/bin/env bash

mkdir -p $PACKAGES_SOURCE
for i in components/*.sh; do
    echo "»»»» Installing $i" | boxes -d ada-box
    bash $i
done
