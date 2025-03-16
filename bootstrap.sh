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
        run_on $node $1 &
    done
    wait
}

run_on() {
    echo "Running $2\n-------------------------" >> logs/$1.log
    ssh $1 'bash -s' < $2 >> logs/$1.log 2>&1
    echo "\nDONE\n" >> logs/$1.log
}

token="nothing"
for index in "${!nodes[@]}"; do
    if [[ $index -eq 0 ]]; then
        echo "Boostrapping the first node on ${nodes[$index]}"
        run_on ${nodes[$index]} infrastructure/k3s-first.sh

        echo "Waiting to boot..."
        sleep 30

        echo "Copying over the kubes config"
        ssh ${nodes[$index]} 'sudo k3s kubectl config view --raw' | \
            sed -e 's/127.0.0.1:6443/192.168.68.1:6443/' > ~/.kube/config

        token=$(ssh ${nodes[$index]} 'sudo cat /var/lib/rancher/k3s/server/node-token')
    else
        echo "Setting up ${nodes[$index]}"
        first="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "${nodes[0]}")"
        cat infrastructure/k3s-others.sh | sed -e "s/\[TOKEN\]/$token/" | sed -e "s/\[IP\]/$first/" > secondary.sh
        run_on ${nodes[$index]} secondary.sh
        rm secondary.sh
    fi

    ssh ${nodes[$index]} 'bash -s' < ./cluster/longhorn/setup.sh
    ssh ${nodes[$index]} 'bash -s' < ./apps/registry/setup.sh
done