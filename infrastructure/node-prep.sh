sudo dnf upgrade --refresh
sudo dnf install nano btop
sudo dnf remove cockpit

echo "Disabling swap...."
sudo swapoff -a
sudo dnf remove zram-generator

echo "Punching holes in firewall....."
sudo firewall-cmd --permanent --add-service=dns
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

sudo firewall-cmd --reload

echo "Rebooting now ...."
sudo reboot