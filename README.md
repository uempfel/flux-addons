# Central Flux showcase

## Adapt values in consumer repo
Create the following file and the run `flux reconcile source git addons && flux reconcile ks flux-system --with-source && flux reconcile hr ingress-nginx -n ingress-nginx`

```yaml
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


