#!/usr/bin/env bash

echo "----> minikube"
echo "----> https://minikube.sigs.k8s.io/docs/start/"

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

# https://minikube.sigs.k8s.io/docs/drivers/docker/
minikube config set driver docker