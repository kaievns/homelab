#! /bin/sh

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.32.2+k3s1 sh -s - server \
  --cluster-init \
  --disable=servicelb \
  --disable-cloud-controller
