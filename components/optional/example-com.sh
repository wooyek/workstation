#!/usr/bin/env bash

echo "----> Setting up example.com domain alias for localhost"
echo "127.0.0.1	dev.example.com gandalf.example.com" | sudo tee -a /etc/hosts
echo "127.0.0.1	t1.example.com t2.example.com t3.example.com t4.example.com t5.example.com" | sudo tee -a /etc/hosts
