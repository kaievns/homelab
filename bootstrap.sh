#! /bin/sh

ssh kai@192.168.68.1 'bash -s' < infrastructure/k0s-prep.sh
ssh kai@192.168.68.2 'bash -s' < infrastructure/k0s-prep.sh
ssh kai@192.168.68.3 'bash -s' < infrastructure/k0s-prep.sh

k0sctl apply --config infrastructure/k0s-config.yaml

k0sctl kubeconfig --config infrastructure/k0s-config.yaml >  ~/.kube/config

sleep 30

ssh kai@192.168.68.1 'bash -s' < infrastructure/k0s-post.sh
ssh kai@192.168.68.2 'bash -s' < infrastructure/k0s-post.sh
ssh kai@192.168.68.3 'bash -s' < infrastructure/k0s-post.sh

sleep 30

./cluster/traefik/install
sleep 10

./cluster/metallb/install
sleep 20

ssh kai@192.168.68.1 'bash -s' < cluster/longhorn/setup.sh
ssh kai@192.168.68.2 'bash -s' < cluster/longhorn/setup.sh
ssh kai@192.168.68.3 'bash -s' < cluster/longhorn/setup.sh

./cluster/longhorn/install
sleep 60

./cluster/observability/install
# sleep 10