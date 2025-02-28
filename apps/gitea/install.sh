#! /bin/sh

source "$(dirname -- "$0")/.env"

helm repo add gitea-charts https://dl.gitea.com/charts/
helm repo update

kubectl create namespace gitea

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: admin-creds
  namespace: gitea
data:
  username: $ADMIN_USER
  password: $ADMIN_PASS
---
apiVersion: v1
kind: Secret
metadata:
  name: action-token
  namespace: gitea
data:
  token: $ACTION_TOKEN
EOF


kubectl create secret generic gitea-themes -n gitea --from-file="/Users/kai/Downloads/gitea-themes"
kubectl apply -f "$(dirname -- "$0")/crds.yaml"

helm install gitea gitea-charts/gitea -n gitea  -f "$(dirname -- "$0")/values.yaml"
