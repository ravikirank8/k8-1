wget -c https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx

POD_NAME=$(kubectl get pods -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $POD_NAME -- /nginx-ingress-controller --version

kubectl -n default   get  svc

kubectl -n kubernetes-dashboard get svc

kubectl -n default edit  svc ingress-nginx-controller

type: LoadBalancer
externalIPs:
    - 80.11.12.10(masterip of node)
