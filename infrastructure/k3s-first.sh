#! /bin/sh

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.32.2+k3s1 sh -s - server \
  --selinux \
  --cluster-init \
  --flannel-backend=wireguard-native \
  --disable=servicelb,metrics-server \
  --disable-cloud-controller
