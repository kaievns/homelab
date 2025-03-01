curl -sfL https://get.k3s.io | sh -s - server \
  --cluster-init \
  --disable=servicelb \
  --disable-cloud-controller

sudo cat /var/lib/rancher/k3s/server/node-token

sudo kubectl config view --raw

#   curl -sfL https://get.k3s.io | K3S_TOKEN=[TOKEN] \
#   sh -s - server \
#   --server https://192.168.68.1:6443 \
#   --cluster-init \
#   --disable=servicelb \
#   --disable-cloud-controller
