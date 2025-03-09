sudo dnf upgrade --refresh -y
sudo dnf install nano btop -y
sudo dnf remove cockpit -y
sudo dnf install wireguard-tools -y

echo "Disabling swap...."
sudo swapoff -a
sudo dnf remove zram-generator -y

echo "Punching holes in firewall....."
sudo systemctl enable firewalld
sudo systemctl start firewalld

sudo firewall-cmd --permanent --add-service=dns
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

sudo firewall-cmd --permanent --add-port=6443/tcp #apiserver
sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16 #pods
sudo firewall-cmd --permanent --zone=trusted --add-source=10.43.0.0/16 #services

sudo firewall-cmd --permanent --zone=trusted --add-source=192.168.68.1 #node1
sudo firewall-cmd --permanent --zone=trusted --add-source=192.168.68.2 #node2
sudo firewall-cmd --permanent --zone=trusted --add-source=192.168.68.3 #node3

sudo firewall-cmd --reload

echo "Setting up passwordless sudo...."
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-$USER-for-sudo-password"

echo "Rebooting now ...."
sudo reboot