sudo dnf upgrade --refresh
sudo dnf install nano btop

echo "Disabling swap...."
sudo swapoff -a
sudo dnf remove zram-generator

echo "Punching holes in firewall....."
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
  
sudo firewall-cmd --reload

echo "Rebooting now ...."
sudo reboot