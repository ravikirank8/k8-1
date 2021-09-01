#! /bin/bash

#The Kubernetes scheduler determines the best available node on which to deploy newly created pods. If memory swapping is allowed to occur on a host system, this can lead to performance and stability issues within Kubernetes.
# disable swap

sudo swapoff -a
# keeps the swap off during reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


#Update the apt package index and install packages to allow apt to use a repository over HTTPS
sudo apt-get update -y

 sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  
  sudo apt-get update -y

#sudo apt-get install -y kubelet=$KUBERNETES_VERSION kubectl=$KUBERNETES_VERSION kubeadm=$KUBERNETES_VERSION

#kubeadm: the command to bootstrap the cluster.
#kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.
#kubectl: the command line util to talk to your cluster

sudo apt-get install -y kubelet kubeadm kubectl

#apt-mark will mark or unmark a software package as being automatically installed and it is used with option hold
sudo apt-mark hold kubelet kubeadm kubectl

#echo "Please run this kubeadm join token in workernode0,1,2,so on to join to master......................"

#kubeadm token create --print-join-command


#number of cores your cpu is using (k8 require 2 cores for master to run otherwise installation fails)
#cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l
