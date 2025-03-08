#! /usr/bin

sudo firewall-cmd --permanent --zone=trusted --add-source=10.244.0.0/16 #pods  
sudo firewall-cmd --permanent --zone=trusted --add-source=10.96.0.0/12 #services

if sudo firewall-cmd  --info-service=k0s ; then
    echo "Already have the firewall rules setup"
else
    echo "Setting up the k0s firewall rules"

    sudo firewall-cmd --permanent --new-service=k0s
    sudo firewall-cmd --permanent --service=k0s --set-description="K0S Firewall Rules"  
    sudo firewall-cmd --permanent --service=k0s --add-port=2380/tcp # etcd
    sudo firewall-cmd --permanent --service=k0s --add-port=6443/tcp # kube-api
    sudo firewall-cmd --permanent --service=k0s --add-port=9443/tcp # controller <-> controller

    sudo firewall-cmd --permanent --service=cilium --add-port=51871/udp # WireGuard encryption tunnel endpoint

    sudo firewall-cmd --permanent --add-service=k0s

    sudo firewall-cmd --reload
fi
