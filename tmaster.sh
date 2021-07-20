#Get ip addr of network adapter eth0
ipaddr=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`

#kubeadm init = >This command initializes a Kubernetes control-plane node.
# --apiserver-advertise-address = The IP address the API Server will advertise it's listening on. If not set the default network interface will be used.
#--dry-run => Don't apply any changes; just it gives output  what it will done
# --pod-network-cidr = Specify range of IP addresses for the pod network. If set, the control plane will automatically allocate CIDRs for every node.

#Static pods are pods created and managed by kubelet daemon on a specific node without API server observing them.
#If the static pod crashes, kubelet restarts them. Control plane is not involved in lifecycle of static pod.
#Kubelet also tries to create a mirror pod on the kubernetes api server for each static pod so that the static pods are visible i.e., when you do kubectl get pod for example, the mirror object of static pod is also listed

kubeadm init --apiserver-advertise-address=$ipaddr --pod-network-cidr=192.168.0.0/16

sleep 5

echo "Please run this kubeadm join token in workernode0,1,2,so on to join to master......................"

kubeadm token create --print-join-command > /tmp/worker-join
