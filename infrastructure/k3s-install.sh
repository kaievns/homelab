sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16 #pods  
sudo firewall-cmd --permanent --zone=trusted --add-source=10.43.0.0/16 #services  
sudo firewall-cmd --permanent --new-service=k3s  
sudo firewall-cmd --permanent --service=k3s --set-description="K3S Firewall Rules"  
sudo firewall-cmd --permanent --service=k3s --add-port=2379/tcp  
sudo firewall-cmd --permanent --service=k3s --add-port=2380/tcp  
sudo firewall-cmd --permanent --service=k3s --add-port=6443/tcp  
sudo firewall-cmd --permanent --service=k3s --add-port=8472/udp
sudo firewall-cmd --permanent --service=k3s --add-port=10250/tcp  
sudo firewall-cmd --permanent --service=k3s --add-port=51820/udp  
sudo firewall-cmd --permanent --service=k3s --add-port=51821/udp  
sudo firewall-cmd --permanent --add-service=k3s
  
sudo firewall-cmd --reload

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
