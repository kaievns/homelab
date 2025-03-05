#! /bin/sh

helm repo add cnpg https://cloudnative-pg.github.io/charts
helm upgrade --install cnpg \
  --namespace cnpg-system \
  --create-namespace \
  cnpg/cloudnative-pg

kubectl apply -f "$(dirname -- "$0")/longhorn-postgres.yaml"
