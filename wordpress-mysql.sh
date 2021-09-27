kubectl create secret generic mysql-pass --from-file=password
kubectl create -f https://raw.githubusercontent.com/kubernetes/examples/master/mysql-wordpress-pd/local-volumes.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/examples/master/mysql-wordpress-pd/mysql-deployment.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/examples/master/mysql-wordpress-pd/wordpress-deployment.yaml


#create file password add passwd in it
