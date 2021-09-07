#



ipaddr=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`

kubeadm config images pull

#Initializing your control-plane node

#The control-plane node is the machine where the control plane components run, including etcd (the cluster database) and the API Server (which the kubectl command line tool communicates with).

#(Recommended) If you have plans to upgrade this single control-plane kubeadm cluster to high availability you should specify the --control-plane-endpoint to set the shared endpoint for all control-plane nodes. Such an endpoint can be either a DNS name or an IP address of a load-balancer.
#Choose a Pod network add-on, and verify whether it requires any arguments to be passed to kubeadm init. Depending on which third-party provider you choose, you might need to set the --pod-network-cidr to a provider-specific value. See Installing a Pod network add-on.
#(Optional) Since version 1.14, kubeadm tries to detect the container runtime on Linux by using a list of well known domain socket paths. To use different container runtime or if there are more than one installed on the provisioned node, specify the --cri-socket argument to kubeadm init. See Installing runtime.
#(Optional) Unless otherwise specified, kubeadm uses the network interface associated with the default gateway to set the advertise address for this particular control-plane node's API server. To use a different network interface, specify the --apiserver-advertise-address=<ip-address> argument to kubeadm init. To deploy an IPv6 Kubernetes cluster using IPv6 addressing, you must specify an IPv6 address, for example --apiserver-advertise-address=fd00::101
#(Optional) Run kubeadm config images pull prior to kubeadm init to verify connectivity to the gcr.io container image registry.

kubeadm init --apiserver-advertise-address=$ipaddr --pod-network-cidr=192.168.0.0/16


echo "Please run this kubeadm join token in workernode0,1,2,so on to join to master......................"

kubeadm token create --print-join-command > /tmp/worker-join


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config



# Install Calico Network Plugin

curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml

# Install Metrics Server

#kubectl apply -f https://raw.githubusercontent.com/scriptcamp/kubeadm-scripts/main/manifests/metrics-server.yaml

# Install Kubernetes Dashboard

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml



#Initializing your control-plane node

#The control-plane node is the machine where the control plane components run, including etcd (the cluster database) and the API Server (which the kubectl command line tool communicates with).

#(Recommended) If you have plans to upgrade this single control-plane kubeadm cluster to high availability you should specify the --control-plane-endpoint to set the shared endpoint for all control-plane nodes. Such an endpoint can be either a DNS name or an IP address of a load-balancer.
#Choose a Pod network add-on, and verify whether it requires any arguments to be passed to kubeadm init. Depending on which third-party provider you choose, you might need to set the --pod-network-cidr to a provider-specific value. See Installing a Pod network add-on.
#(Optional) Since version 1.14, kubeadm tries to detect the container runtime on Linux by using a list of well known domain socket paths. To use different container runtime or if there are more than one installed on the provisioned node, specify the --cri-socket argument to kubeadm init. See Installing runtime.
#(Optional) Unless otherwise specified, kubeadm uses the network interface associated with the default gateway to set the advertise address for this particular control-plane node's API server. To use a different network interface, specify the --apiserver-advertise-address=<ip-address> argument to kubeadm init. To deploy an IPv6 Kubernetes cluster using IPv6 addressing, you must specify an IPv6 address, for example --apiserver-advertise-address=fd00::101
#(Optional) Run kubeadm config images pull prior to kubeadm init to verify connectivity to the gcr.io container image registry.


#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

