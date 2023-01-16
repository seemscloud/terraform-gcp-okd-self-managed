```bash
mkdir -p archives

OKD_VERSION="4.11.0-0.okd-2023-01-14-152430"

wget "https://github.com/okd-project/okd/releases/download/${OKD_VERSION}/openshift-client-linux-${OKD_VERSION}.tar.gz" -O archives/os-client-linux.tar.gz
wget "https://github.com/okd-project/okd/releases/download/${OKD_VERSION}/openshift-install-linux-${OKD_VERSION}.tar.gz" -O archives/os-linux-install.tar.gz

sudo tar -xvf archives/os-client-linux.tar.gz -C /usr/local/bin
sudo tar -xvf archives/os-linux-install.tar.gz -C /usr/local/bin

sudo apt-get update

sudo apt-get install -y nginx net-tools \
  bind9-utils dnsutils \
  curl wget telnet

mkdir -p install_dir

cat >install_dir/install-config.yaml <<EndOfMessage
apiVersion: v1
baseDomain: seems.cloud
metadata:
  name: lorem
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

openshift-install create manifests --log-level=debug --dir=install_dir/

openshift-install create ignition-configs --log-level=debug --dir=install_dir/

openshift-install wait-for bootstrap-complete --log-level=debug --dir=install_dir/

openshift-install gather bootstrap \
  --master afj5kcvn1-master-0.seems.cloud \
  --master afj5kcvn1-master-1.seems.cloud \
  --master afj5kcvn1-master-2.seems.cloud

```