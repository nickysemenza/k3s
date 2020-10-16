

# install steps

1. install tailscale on all nodes
2. ensure passwordless sudo is enabled
3. ensure passwordless ssh is enabled


```bash
# master node (in cloud so it's universally reachable w/o DynDNS)
k3sup install --ip `dig k.ts.nickysemenza.com +short` \
  --user root \
  --k3s-extra-args '--disable traefik --flannel-iface tailscale0 --node-ip 100.72.162.64 --node-label location=cloud' --k3s-version 'v1.19.2+k3s1'

# worker node #1
k3sup join --ip `dig plum.lan.nickysemenza.com +short` \
  --server-ip `dig k.ts.nickysemenza.com +short` --user nicky --server-user root \
  --k3s-extra-args '--flannel-iface tailscale0 --node-ip 100.111.250.62 --node-label location=home' --k3s-version 'v1.19.2+k3s1'
```

k taint nodes apricot arm=true:NoExecute
k taint nodes apricot arm=true:NoSchedule



```
k3sup install --ip `dig plum.ts.nickysemenza.com +short` \
  --user nicky \
  --k3s-extra-args '--disable traefik --node-label location=home' --k3s-version 'v1.19.2+k3s1'
```


> k apply -f https://github.com/fluxcd/helm-controller/releases/download/v0.1.1/helm-controller.yaml
namespace/helm-system created
customresourcedefinition.apiextensions.k8s.io/buckets.source.toolkit.fluxcd.io created
customresourcedefinition.apiextensions.k8s.io/gitrepositories.source.toolkit.fluxcd.io created
customresourcedefinition.apiextensions.k8s.io/helmcharts.source.toolkit.fluxcd.io created
customresourcedefinition.apiextensions.k8s.io/helmreleases.helm.toolkit.fluxcd.io created
customresourcedefinition.apiextensions.k8s.io/helmrepositories.source.toolkit.fluxcd.io created
role.rbac.authorization.k8s.io/helm-leader-election-role created
clusterrole.rbac.authorization.k8s.io/helm-manager-role created
clusterrole.rbac.authorization.k8s.io/helm-reconciler-role created
rolebinding.rbac.authorization.k8s.io/helm-leader-election-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/helm-manager-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/helm-reconciler-rolebinding created
service/source-controller created
deployment.apps/helm-controller created
deployment.apps/source-controller created



### inspiration
* https://github.com/bjw-s/k8s-gitops
* https://github.com/billimek/k8s-gitops
* https://github.com/onedr0p/k3s-gitops