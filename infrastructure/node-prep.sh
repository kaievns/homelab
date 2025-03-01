sudo dnf upgrade --refresh
sudo dnf install nano btop

echo "Disabling swap...."
sudo swapoff -a
sudo dnf remove zram-generator

echo "Punching holes in firewall....."
sudo firewall-cmd --permanent --add-service=http  
sudo firewall-cmd --permanent --add-service=https  
  
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

echo "Rebooting now ...."
sudo reboot