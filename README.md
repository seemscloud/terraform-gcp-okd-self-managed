## Prepare Bastion as Load Balancer

```bash
sudo apt-get update

sudo apt-get install -y vim curl wget nginx haproxy bind9-utils dnsutils net-tools telnet bash-completion
```

```bash
mkdir -p archives archives/okd archives/fcos

OKD_VERSION="4.11.0-0.okd-2023-01-14-152430"
FCOS_VERSION="37.20221225.3.0"

wget "https://github.com/okd-project/okd/releases/download/${OKD_VERSION}/openshift-client-linux-${OKD_VERSION}.tar.gz" -O archives/okd/os-client-linux.tar.gz
wget "https://github.com/okd-project/okd/releases/download/${OKD_VERSION}/openshift-install-linux-${OKD_VERSION}.tar.gz" -O archives/okd/os-linux-install.tar.gz
wget "https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${FCOS_VERSION}/x86_64/fedora-coreos-${FCOS_VERSION}-metal.x86_64.raw.xz" -O archives/fcos/rhcos.raw.gz
wget "https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${FCOS_VERSION}/x86_64/fedora-coreos-${FCOS_VERSION}-metal.x86_64.raw.xz.sig" -O archives/fcos/rhcos.raw.gz.sig

sudo tar -xf archives/okd/os-client-linux.tar.gz -C /usr/local/bin
sudo tar -xf archives/okd/os-linux-install.tar.gz -C /usr/local/bin
sudo cp archives/fcos/* /var/www/html

sudo chmod 755 /usr/local/bin/*
sudo chmod 644 /var/www/html/*
sudo rm -f /var/www/html/*.html
sudo rm -f /usr/local/bin/README.md

ls -lh /usr/local/bin
ls -lh /var/www/html

```

```bash
mkdir -p install_dir

cat >install_dir/install-config.yaml <<"EndOfMessage"
apiVersion: v1
baseDomain: seems.cloud
metadata:
  name: okd
compute:
  - hyperthreading: Enabled
    name: worker
    replicas: 0
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
pullSecret: '{"auths":{"fake":{"auth": "bar"}}}'
sshKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxMR6x6rHclUBQI3IQVPZN8xjkAVVAZmS1PV/hNg/XPc5sl5fI7/3FLmwu+A9PDuiPu5++60Ns4NtYJcd+hVQ9m/htl6DGPeUoflin1pmVFSfKMUctTRWsl+e2ldt3CVmTgFclLABdLDR+cSb3jSqNXgonzjNcWbTfhrsSnqNuD+2GxXpGZXc4rYDloSrlGVOx0mEiyJrMocJFuVlh1JB8Os0KNnx5qD56h5zIRLGkhHhgXIO5kJ+hNB+vF3FV2Fq9Ar47+DrQiD/o9/h17HFDvD0tzze1GLYAJs4QcFJJPKdWM1kHyXa/p9TIFLc3rVnCrVx1NihgaEhiY+d452otV0p1Bq1tvotfPJ92BDSNlF7A1YuJNYqRkNNpwSPMznPQtVkeRCHTNH5MmMqhPptGEPLiDlkMUZeFFjTKz0IDo6QCX05WBl+SXYLo1l2R9jCoKstmoKvlsFY6fcYpSYj78X9E4bIX++LSLiG9oGXwg2xoZTlwofhqjnI+xc9tMiU='
EndOfMessage
```

```bash
openshift-install create manifests --log-level=debug --dir=install_dir/
openshift-install create ignition-configs --log-level=debug --dir=install_dir/

sudo cp -R install_dir/* /var/www/html/
sudo chmod 644 /var/www/html/*
sudo service nginx restart

```

```bash
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

listen stats
    bind :9000
    mode http
    stats enable
    stats uri /

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
    bind              :8080
    default_backend   http_ingress

backend http_ingress
    mode      tcp
    balance   leastconn
    server    master-0    worker-0.seems.cloud:80   check
    server    master-1    worker-1.seems.cloud:80   check
    server    master-2    worker-2.seems.cloud:80   check
    
frontend https_ingress
    mode              tcp
    bind              :8443
    default_backend   https_ingress

backend https_ingress
    mode      tcp
    balance   leastconn
    server    master-0    worker-0.seems.cloud:8443   check
    server    master-1    worker-1.seems.cloud:8443   check
    server    master-2    worker-2.seems.cloud:8443   check
EndOfMessage

sudo service haproxy restart

```

## Install Node

#### Run on bastion node

```bash
openshift-install wait-for bootstrap-complete --log-level=debug --dir=install_dir/

```

#### Prepare Bootstrap / Master / Worker

```bash
sudo umount /boot
sudo mount /dev/sda3 /boot/

sudo -i su -
```

```bash
ADDR="10.100.101.8"
GW="10.100.101.1"
NETMASK="255.255.255.255"
NAMESERVER="169.254.169.254"

INST_URL="http://10.100.100.2:80"

INST_TYPE="bootstrap"
# INST_TYPE="master"
# INST_TYPE="worker"

INST_ENABLED="coreos.inst=yes"
INST_DEV="coreos.inst.install_dev=/dev/sdb"
INST_IMAGE="coreos.inst.image_url=${INST_URL}/rhcos.raw.gz"
INST_IGN="coreos.inst.ignition_url=${INST_URL}/${INST_TYPE}.ign"

COREOS_INST="${INST_ENABLED} ${INST_DEV} ${INST_IMAGE} ${INST_IGN}"

echo "${COREOS_INST} ip=${ADDR} gw=${GW} netmask=${NETMASK} nameserver=${NAMESERVER}"

# edit loader to add 'coreos.inst' string

```

