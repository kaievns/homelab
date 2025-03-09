sudo dnf upgrade --refresh -y
sudo dnf install nano btop -y
sudo dnf remove cockpit -y

echo "Disabling swap...."
sudo swapoff -a
sudo dnf remove zram-generator -y

echo "Punching holes in firewall....."
sudo firewall-cmd --permanent --add-service=dns
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

sudo firewall-cmd --reload

echo "Setting up passwordless sudo...."
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-$USER-for-sudo-password"

echo "Rebooting now ...."
sudo reboot