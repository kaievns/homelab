echo "Setting up passwordless sudo...."
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-$USER-for-sudo-password"

echo "Running updates"
sudo apt update
sudo apt upgrade -y
sudo apt install nano btop -y

echo "Disabling snaps"
sudo systemctl stop snapd
sudo systemctl mask snapd
sudo apt remove --purge snapd -y
sudo apt-mark hold snapd

echo "Disabling swap...."
sudo swapoff -a
sudo nano /etc/fstab

echo "Punching holes in the firewall....."
sudo apt install ufw -y
sudo ufw enable

sudo ufw allow from 192.168.68.0/24 to any port 22 comment "SSH: allow SSH access from home"
sudo ufw allow from 192.168.68.0/24 to any port 53 comment "DNS: from home for pihole"

sudo ufw allow from 192.168.68.0/24 to any port 80 comment "Traefik HTTP access from home"
sudo ufw allow from 192.168.68.0/24 to any port 443 comment "Traefik HTTPS access from home"

sudo ufw allow from 192.168.68.0/24 to any port 6443 comment "K3S: kubes api from home"

sudo ufw allow from 10.42.0.0/16 to any comment "K3S: pods"
sudo ufw allow from 10.43.0.0/16 to any comment "K3S: services"
sudo ufw allow from 192.168.68.0/28 to any comment "K3S: other direct node to node traffic"

## patching Grub
sudo nano /etc/default/grub
sudo update-grub

echo "Rebooting now ...."
sudo reboot