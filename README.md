## Setup

### Terraform

```bash
terraform apply -var-file variables.tfvars
```

```bash
ansible-playbook \
  --inventory inventories/inventory.yml \
  --extra-vars @configs/config.yml \
  roles/main.yml
```

## Complete

```bash
openshift-install wait-for bootstrap-complete --log-level=debug --dir=install_dir/

openshift-install wait-for install-complete --log-level=debug --dir=install_dir/
```

```bash
export KUBECONFIG=~/install_dir/auth/kubeconfig

. <(oc completion bash)
. <(kubectl completion bash)
```

```bash
oc get csr

oc get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc adm certificate approve
```