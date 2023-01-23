# Setup Bastion (HAProxy, Nginx, OC, kubectl)

## Step 1 - Install Requirements

```bash
sudo apt-get update

sudo apt-get install -y vim curl wget nginx haproxy bind9-utils dnsutils net-tools telnet bash-completion jq
```

## Step 2 - Prepare OKD Installer / OC / Kubectl

```bash
OKD_VERSION="4.11.0-0.okd-2023-01-14-152430"

rm -rf archives
mkdir -p archives

wget "https://github.com/okd-project/okd/releases/download/${OKD_VERSION}/openshift-client-linux-${OKD_VERSION}.tar.gz" -O archives/os-client-linux.tar.gz
wget "https://github.com/okd-project/okd/releases/download/${OKD_VERSION}/openshift-install-linux-${OKD_VERSION}.tar.gz" -O archives/os-linux-install.tar.gz

clear

ls -lh archives

```

```bash
sudo rm -f /usr/local/bin/*

sudo tar -xf archives/os-client-linux.tar.gz -C /usr/local/bin
sudo tar -xf archives/os-linux-install.tar.gz -C /usr/local/bin

clear

ls -lh /usr/local/bin

```

```bash
sudo chmod 755 /usr/local/bin
sudo rm -f /usr/local/bin/README.md

clear

ls -lh /usr/local/bin

```

## Step 3 - Prepare `install-config.yaml` File

```bash
rm -rf install_dir
mkdir -p install_dir

cat >install_dir/install-config.yaml <<"EndOfMessage"
apiVersion: v1
baseDomain: seems.cloud
metadata:
  name: okd
compute:
  - hyperthreading: Enabled
    name: worker
    replicas: 2
controlPlane:
  hyperthreading: Enabled
  name: master
  replicas: 3
networking:
  clusterNetwork:
    - cidr: 10.128.0.0/14
      hostPrefix: 23
  networkType: OpenShiftSDN
  serviceNetwork:
    - 172.30.0.0/16
platform:
  none: { }
fips: false
pullSecret: '{"auths":{"registry.access.redhat.com":{"auth":"XXXXXXXXXXXXX"}}}'
sshKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxMR6x6rHclUBQI3IQVPZN8xjkAVVAZmS1PV/hNg/XPc5sl5fI7/3FLmwu+A9PDuiPu5++60Ns4NtYJcd+hVQ9m/htl6DGPeUoflin1pmVFSfKMUctTRWsl+e2ldt3CVmTgFclLABdLDR+cSb3jSqNXgonzjNcWbTfhrsSnqNuD+2GxXpGZXc4rYDloSrlGVOx0mEiyJrMocJFuVlh1JB8Os0KNnx5qD56h5zIRLGkhHhgXIO5kJ+hNB+vF3FV2Fq9Ar47+DrQiD/o9/h17HFDvD0tzze1GLYAJs4QcFJJPKdWM1kHyXa/p9TIFLc3rVnCrVx1NihgaEhiY+d452otV0p1Bq1tvotfPJ92BDSNlF7A1YuJNYqRkNNpwSPMznPQtVkeRCHTNH5MmMqhPptGEPLiDlkMUZeFFjTKz0IDo6QCX05WBl+SXYLo1l2R9jCoKstmoKvlsFY6fcYpSYj78X9E4bIX++LSLiG9oGXwg2xoZTlwofhqjnI+xc9tMiU='
EndOfMessage

clear

cat install_dir/install-config.yaml

```

```bash
openshift-install create manifests --log-level=debug --dir=install_dir/
openshift-install create ignition-configs --log-level=debug --dir=install_dir/

clear
```

```bash
sudo rm -rf /var/www/html/*

sudo cp -R install_dir/* /var/www/html/

sudo chmod 644 /var/www/html/*
sudo chmod 755 /var/www/html/auth
sudo chmod 644 /var/www/html/auth/*

clear

ls -lh /var/www/html/
ls -lh /var/www/html/auth

```

## Step 3 - Prepare Nginx, HAProxy

```bash
sudo rm -f /etc/nginx/sites-available/default
sudo rm -f /etc/haproxy/haproxy.cfg

cat <<"EndOfMessage" | sudo tee /etc/nginx/sites-available/default
server {
        listen 8080 default_server;
        listen [::]:8080 default_server;

        root /var/www/html;

        index index.html index.htm;
}
EndOfMessage

cat <<"EndOfMessage" | sudo tee /etc/haproxy/haproxy.cfg
global
    log       /dev/log    local0
    log       /dev/log    local1 notice
    chroot    /var/lib/haproxy
    stats     socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats     timeout 30s
    user      haproxy
    group     haproxy
    daemon

defaults
    option  forwardfor      except 127.0.0.0/8
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          300s
    timeout server          300s
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 20000


listen stats
    bind :9000
    mode http
    stats enable
    stats uri /


frontend kube_api
    mode            tcp
    bind            :6443
    default_backend kube_api

backend kube_api
    mode      tcp
    balance   leastconn
    server    bootstrap   bootstrap-0.seems.cloud:6443  check
    server    master-0    master-0.seems.cloud:6443   check
    server    master-1    master-1.seems.cloud:6443   check
    server    master-2    master-2.seems.cloud:6443   check


frontend kube_config_server
    mode              tcp
    bind              :22623
    default_backend   kube_config_server

backend kube_config_server
    mode      tcp
    balance   leastconn
    server    bootstrap   bootstrap-0.seems.cloud:22623  check
    server    master-0    master-0.seems.cloud:22623   check
    server    master-1    master-1.seems.cloud:22623   check
    server    master-2    master-2.seems.cloud:22623   check


frontend http_ingress
    mode              tcp
    bind              :80
    default_backend   http_ingress

backend http_ingress
    mode      tcp
    balance   leastconn
    server    worker-0    worker-0.seems.cloud:80   check
    server    worker-1    worker-1.seems.cloud:80   check


frontend https_ingress
    mode              tcp
    bind              :443
    default_backend   https_ingress

backend https_ingress
    mode      tcp
    balance   leastconn
    server    worker-0    worker-0.seems.cloud:443   check
    server    worker-1    worker-1.seems.cloud:443   check
EndOfMessage

clear 

ls -lh /etc/haproxy/haproxy.cfg
ls -lh /etc/nginx/sites-available/default
```

```bash
sudo service haproxy restart
sudo service nginx restart

clear

sudo service haproxy status
sudo service nginx status

```

## Step 4 - Wait for Bootstrap Complete

```bash
openshift-install wait-for bootstrap-complete --log-level=debug --dir=install_dir/

```

```bash
openshift-install wait-for install-complete --log-level=debug --dir=install_dir/

```

## Step 5 - Sign Worker Nodes CSR

```bash
export KUBECONFIG=~/install_dir/auth/kubeconfig

. <(oc completion bash)
. <(kubectl completion bash)
```

```bash
oc get csr

oc get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc adm certificate approve
```

## Problems

### Kernel Parameters

```bash
ssh -o "StrictHostKeyChecking=no" core@bootstrap-0.seems.cloud

```

```bash
cat <<"EndOfMessage" | sudo tee /etc/sysctl.conf
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_base_mss = 1024
net.ipv4.ip_no_pmtu_disc=1
net.ipv4.ip_forward_use_pmtu=0
net.ipv4.route.min_pmtu=552
EndOfMessage

sudo sysctl -w net.ipv4.tcp_mtu_probing=1
sudo sysctl -w net.ipv4.tcp_base_mss=1024
sudo sysctl -w net.ipv4.ip_no_pmtu_disc=1
sudo sysctl -w net.ipv4.ip_forward_use_pmtu=0
sudo sysctl -w net.ipv4.route.min_pmtu=552

clear

sysctl net.ipv4.tcp_mtu_probing
sysctl net.ipv4.tcp_base_mss
sysctl net.ipv4.ip_no_pmtu_disc
sysctl net.ipv4.ip_forward_use_pmtu
sysctl net.ipv4.route.min_pmtu

```

### Fix for Network Interfaces

```bash
ADDRESSES=$(oc get nodes -o=jsonpath='{.items[*].status.addresses[0].address}')

for ADDRESS in $ADDRESSES; do 
  ssh -o "StrictHostKeyChecking=no" core@${ADDRESS} sudo ethtool -K ens4 tx-udp_tnl-segmentation off
  ssh -o "StrictHostKeyChecking=no" core@${ADDRESS} sudo ethtool -K ens4 tx-udp_tnl-csum-segmentation off  
  ssh -o "StrictHostKeyChecking=no" core@${ADDRESS} sudo ethtool -K ens4 tx-checksum-ip-generic off
done
``` 
