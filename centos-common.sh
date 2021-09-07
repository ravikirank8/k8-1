#!/bin/sh


#Notes:

 #   Setting SELinux in permissive mode by running setenforce 0 and sed ... effectively disables it. This is required to allow containers to access the host filesystem, which is needed by pod networks for example. You have to do this until SELinux support is improved in the kubelet.

#    You can leave SELinux enabled if you know how to configure it but it may require settings that are not supported by kubeadm.



# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
#Letting iptables see bridged traffic

#Make sure that the br_netfilter module is loaded. This can be done by running lsmod | grep br_netfilter

#To load it explicitly call sudo modprobe br_netfilter.

#Linux Node's iptables to correctly see bridged traffic, you should ensure net.bridge.bridge-nf-call-iptables is set to 1 


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

#Install the yum-utils package (which provides the yum-config-manager utility) and set up the stable repository.

#==========================================
#iam installing container runtime.

sudo yum install -y yum-utils

 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

#======================================

#Configure the Docker daemon, in particular to use systemd for the management of the container’s cgroups.

sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF


sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

#you will install these packages on all of your machines:

#  kubeadm: the command to bootstrap the cluster.

# kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.

#kubectl: the command line util to talk to your cluster.

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF



sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes


