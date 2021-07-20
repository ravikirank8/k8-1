  System load:  0.0               Processes:              105
  Usage of /:   3.9% of 78.22GB   Users logged in:        0
  Memory usage: 6%                IP address for eth0:    172.105.34.198
  Swap usage:   0%                IP address for docker0: 172.17.0.1

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

 * Canonical Livepatch is available for installation.
   - Reduce system reboots and improve kernel security. Activate at:
     https://ubuntu.com/livepatch

65 packages can be updated.
37 of these updates are security updates.
To see these additional updates run: apt list --upgradable


Last login: Mon Jul 19 03:36:08 2021 from 223.185.70.55
root@localhost:~# ls
k8
root@localhost:~# clear
root@localhost:~# ls
k8
root@localhost:~# cd k8/
root@localhost:~/k8# ls
common.txt.sh  kubeadm-ubuntu-rrk  master.txt.sh
root@localhost:~/k8# cd kubeadm-ubuntu-rrk/
root@localhost:~/k8/kubeadm-ubuntu-rrk# ls
common.sh  master.sh  minikube-linux-amd64  minikube.sh
root@localhost:~/k8/kubeadm-ubuntu-rrk# vi master.sh
#! /bin/bash

ipaddr=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`

kubeadm init --apiserver-advertise-address=$ipaddr --pod-network-cidr=192.168.0.0/16

sleep 5

echo "Please run this kubeadm join token in workernode0,1,2,so on to join to master......................"

kubeadm token create --print-join-command > /tmp/worker-join


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config



# Install Calico Network Plugin

"master.sh" 38L, 898C                                         1,1           Top
