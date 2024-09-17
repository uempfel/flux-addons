---
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: addons
  namespace: flux-system
spec:
  interval: 1m0s
  ref:
    branch: main
  url: https://github.com/uempfel/flux-addons.git
