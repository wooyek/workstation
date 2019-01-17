#!/usr/bin/env bash

echo "----> postgresql"

sudo apt-get install -y postgresql postgresql-contrib postgis
sudo ufw allow 5432
