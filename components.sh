#!/usr/bin/env bash

mkdir -p $PACKAGES_SOURCE
for i in components/*.sh; do
    echo "»»»» Installing $i"
    bash $i
done
