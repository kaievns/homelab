#! /bin/sh

kubectl create namespace observability

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus-stack prometheus-community/kube-prometheus-stack \
  -n observability -f cluster/observability/prometheus.yaml


helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install loki grafana/loki-stack -n observability -f cluster/observability/loki.yaml