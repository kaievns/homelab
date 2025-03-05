#! /bin/sh

echo "SELinux setup ...."

sudo dnf install -y container-selinux

DATA_DIR="/var/lib/k0s"
sudo semanage fcontext -a -t container_runtime_exec_t "${DATA_DIR}/bin/containerd.*"
sudo semanage fcontext -a -t container_runtime_exec_t "${DATA_DIR}/bin/runc"
sudo restorecon -R -v ${DATA_DIR}/bin
sudo semanage fcontext -a -t container_var_lib_t "${DATA_DIR}/containerd(/.*)?"
sudo semanage fcontext -a -t container_ro_file_t "${DATA_DIR}/containerd/io.containerd.snapshotter.*/snapshots(/.*)?"
sudo restorecon -R -v ${DATA_DIR}/containerd

sudo cat <<EOF | sudo tee -a /etc/k0s/containerd.toml

[plugins."io.containerd.grpc.v1.cri"]
  enable_selinux = true

EOF

sudo k0s stop
sudo k0s start