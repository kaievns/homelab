#! /bin/sh

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.32.2+k3s1 K3S_TOKEN=[TOKEN] \
sh -s - server \
  --server https://[IP]:6443 \
  --cluster-init \
  --disable=servicelb \
  --disable-cloud-controller
