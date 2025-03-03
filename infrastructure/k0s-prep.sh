#! /usr/bin

if sudo firewall-cmd  --info-service=k0s ; then
    echo "Already have the firewall rules setup"
else
    echo "Setting up the k0s firewall rules"
    
    sudo firewall-cmd --permanent --zone=trusted --add-source=10.244.0.0/16 #pods  
    sudo firewall-cmd --permanent --zone=trusted --add-source=10.96.0.0/12 #services

    sudo firewall-cmd --permanent --new-service=k0s
    sudo firewall-cmd --permanent --service=k0s --set-description="K0S Firewall Rules"  
    sudo firewall-cmd --permanent --service=k0s --add-port=179/tcp # kube-router
    sudo firewall-cmd --permanent --service=k0s --add-port=2380/tcp # etcd
    sudo firewall-cmd --permanent --service=k0s --add-port=6443/tcp # kube-api
    sudo firewall-cmd --permanent --service=k0s --add-port=9443/tcp # controller <-> controller
    sudo firewall-cmd --permanent --service=k0s --add-port=10250/tcp # metrics server

    #sudo firewall-cmd --permanent --service=k0s --add-port=8132/tcp # konnectivity
    #sudo firewall-cmd --permanent --service=k0s --add-port=8133/tcp # konnectivity

    sudo firewall-cmd --permanent --add-service=k0s
    
    sudo firewall-cmd --reload
fi