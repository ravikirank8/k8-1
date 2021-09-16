user=kubeuser

if id -u "$user" >/dev/null 2>&1; then
    echo 'user exists'
    
else

sudo useradd -s /bin/bash -d /home/kubeuser/ -m -G sudo kubeuser
passwd kubeuser

fi
