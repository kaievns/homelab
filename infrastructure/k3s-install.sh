curl -sfL https://get.k3s.io | sh -s - server \
  --cluster-init \
  --disable=servicelb \
  --disable-cloud-controller

sudo cat /var/lib/rancher/k3s/server/node-token

sudo kubectl config view --raw

#   curl -sfL https://get.k3s.io | K3S_TOKEN=K1011622e10a30411f70f3273727817cf84bb473fd3a688d4328ebaf30ef213d36a::server:5a38aa3bb9c1440b336c8cc926baf409 \
#   sh -s - server \
#   --server https://192.168.68.1:6443 \
#   --cluster-init \
#   --disable=servicelb \
#   --disable-cloud-controller
