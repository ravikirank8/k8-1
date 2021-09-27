Network polices : 

By default, pods are non-isolated; they accept traffic from any source.

Pods become isolated by having a NetworkPolicy that selects them.

From the point of view of a Kubernetes pod, ingress is incoming traffic to the pod, and egress is outgoing traffic from the pod.

In Kubernetes network policy, you create ingress and egress “allow” rules independently (egress, ingress, or both).
