sudo su

cat <<EOF > /etc/rancher/k3s/registries.yaml
mirrors:
  registry.homelab:
    endpoint:
      - http://192.168.68.89/v2
EOF

systemctl restart k3s