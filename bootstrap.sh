#! /bin/sh

ssh kai@192.168.68.1 'bash -s' < infrastructure/k0s-prep.sh
ssh kai@192.168.68.2 'bash -s' < infrastructure/k0s-prep.sh
ssh kai@192.168.68.3 'bash -s' < infrastructure/k0s-prep.sh

k0sctl apply --config infrastructure/k0s-config.yaml

k0sctl kubeconfig --config infrastructure/k0s-config.yaml >  ~/.kube/config

./cluster/matallb/install
./cluster/traefik/install