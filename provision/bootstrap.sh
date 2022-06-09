#!/usr/bin/env bash

# Functions
DATE() {
  date '+%Y-%m-%d %H:%M:%S'
}

# Variables
IP=`ip -o addr show up primary scope global | while read -r num dev fam addr rest; do echo [$(DATE)] [Info] [System] ${addr%/*}; done`
VM_USER=vagrant
KUBERNETES_VERSION=1.22.10
CONTAINERD_VERSION=1.6.6-1

# Non-Interactive Installation
export DEBIAN_FRONTEND=noninteractive

# Install packages to allow apt to use a repository over HTTPS
echo "[$(DATE)] [Info] [System] Installing tools..."
apt -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    bash-completion &> /dev/null

echo "[$(DATE)] [Info] [Containerd] Installing Containerd..."

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &> /dev/null
apt-key fingerprint 0EBFCD88 &> /dev/null

# Set up the stable repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" &> /dev/null

# Install Containerd
apt -y update &> /dev/null
apt -y install containerd.io=$CONTAINERD_VERSION &> /dev/null

# Configure Containerd
cat <<EOF >/etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF >/etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system &> /dev/null

sed -i 's/cri//g' /etc/containerd/config.toml

# Enable and restart service
systemctl enable containerd &> /dev/null
systemctl restart containerd &> /dev/null

echo "[$(DATE)] [Info] [Kubernetes] Installing Kubernetes..."

# Add Kubernetes's official GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - &> /dev/null

# Set up repository
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list 
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Install Kubernetes
apt -y update &> /dev/null
apt -y install kubeadm=$KUBERNETES_VERSION-00 kubelet=$KUBERNETES_VERSION-00 kubectl=$KUBERNETES_VERSION-00 &> /dev/null

# Kubelet requires swap off
swapoff -a &> /dev/null
 
# Keep swap off after reboot
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab &> /dev/null

# Initialize Kubeadm
kubeadm init --kubernetes-version=v$KUBERNETES_VERSION &> /dev/null

# Copy admin.conf in order to comunicate to Kubernetes API
mkdir -p /home/$VM_USER/.kube &> /dev/null
cp -i /etc/kubernetes/admin.conf /home/$VM_USER/.kube/config &> /dev/null
chown -R $VM_USER:$VM_USER /home/$VM_USER/.kube &> /dev/null

# Export Path Kubeconfig
export KUBECONFIG=/home/$VM_USER/.kube/config

# Allow everything
kubectl taint nodes --all node-role.kubernetes.io/master- &> /dev/null
kubectl create clusterrolebinding permissive-binding \
 --clusterrole=cluster-admin \
 --user=admin \
 --user=kubelet \
 --group=system:serviceaccounts &> /dev/null

# Deploy Weave (network)
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" &> /dev/null

# Enable kubectl completion bash
echo "source <(kubectl completion bash)" >> /home/$VM_USER/.bashrc

# Clean unneeded packages
echo "[$(DATE)] [Info] [System] Cleaning unneeded packages..."
apt -y autoremove &> /dev/null

# Update file search cache
echo "[$(DATE)] [Info] [System] Updating file search cache..."
updatedb &> /dev/null

# Show IPs
echo "[$(DATE)] [Info] [System] IP Address on the machine..."
echo -e "$IP"

echo "[$(DATE)] [Info] [System] Enjoy it! :)"
