#ocatant dashboard
#https://www.techcrumble.net/2020/05/how-to-run-vmware-project-octant-as-a-service-for-remote-access/
#https://tech.davidfield.co.uk/two-guis-for-viewing-your-kubernetes-environment/
#ps aux | grep kubectl
#kill -9 proxy


wget -c https://github.com/vmware-tanzu/octant/releases/download/v0.24.0/octant_0.24.0_Linux-64bit.tar.gz


mkdir -p /usr/lib/systemd/system 

cd /usr/lib/systemd/system 

cat <<EOF | sudo tee octant.service
[Unit]
Description=octant

[Service]
Environment="HOME=/root"
Environment="OCTANT_ACCEPTED_HOSTS=192.46.210.89"
Environment="KUBECONFIG=/root/.kube/config"
Environment="OCTANT_LISTENER_ADDR=0.0.0.0:8900"
Environment="OCTANT_DISABLE_OPEN_BROWSER=true"
Environment="PATH=/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
WorkingDirectory=/usr/local/bin/
ExecStart=/usr/local/bin/octant
Type=simple
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 755 -R /usr/lib/systemd/system/octant.service

sudo systemctl enable octant.service
sudo systemctl start octant.service
sudo systemctl status octant.service

 #http://<masterip:8900
