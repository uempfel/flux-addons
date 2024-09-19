# Central Flux showcase

## Take a look at the files generated
* [addons-repo](https://github.com/uempfel/addon-consumer-a/blob/main/clusters/dev/flux-system/addons-repo.yaml)
* [root kustomization](https://github.com/uempfel/addon-consumer-a/blob/main/clusters/dev/flux-system/kustomization.yaml)
* [patches](https://github.com/uempfel/addon-consumer-a/blob/main/clusters/dev/flux-system/patches/gotk-sync.yaml)
* [addons](https://github.com/uempfel/addon-consumer-a/blob/main/clusters/dev/addons.yaml)

## Adapt values in consumer repo
Create the following file and the run `flux reconcile source git addons && flux reconcile ks flux-system --with-source && flux reconcile hr ingress-nginx -n ingress-nginx`

```yaml
# clusters/dev/ingress-nginx-values.yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: ingress-nginx-values
  namespace: ingress-nginx
data:
  values.yaml: |
    controller:
      replicaCount: 5
---
```


