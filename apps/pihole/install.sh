#! /bin/sh

source "$(dirname -- "$0")/.env"

kubectl create namespace pihole
kubectl -n pihole create secret generic pihole-admin \
	--from-literal="password=$ADMIN_PASSWORD"


helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
helm repo update

helm install pihole mojo2600/pihole  -n pihole -f "$(dirname -- "$0")/values.yaml"