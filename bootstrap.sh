#! /bin/sh

nodes=( 
    kai@192.168.68.1
    kai@192.168.68.2 
    kai@192.168.68.3
)

rm -rf logs/
mkdir logs/

run_on_all_nodes () {
    for node in "${nodes[@]}"; do
        echo "Running $1\n-------------------------" >> logs/$node.log
        ssh $node 'bash -s' < $1 >> logs/$node.log 2>&1 &
    done
    wait
}

echo "Running initial setups"
run_on_all_nodes infrastructure/k0s-prep.sh
sleep 10

k0sctl apply --config infrastructure/k0s-config.yaml
k0sctl kubeconfig --config infrastructure/k0s-config.yaml >  ~/.kube/config

ecoh "Running the post-install patches"
run_on_all_nodes infrastructure/k0s-post.sh
sleep 5

echo "Running Cilium prep scripts"
# run_on_all_nodes cluster/cilium/setup.sh
./cluster/cilium/install

echo "Running Longhorn prep scripts"
run_on_all_nodes cluster/longhorn/setup.sh
./cluster/longhorn/install
sleep 60

./cluster/observability/install
# # # sleep 10

./cluster/cloudnative-pg/install.sh