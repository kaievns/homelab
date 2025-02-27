#! /bin/sh

https://kubernetes.github.io/dashboard

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard
helm repo update

helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard \
  -n kubernetes-dashboard --create-namespace \
  -f cluster/dashboard/values.yaml