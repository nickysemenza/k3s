.PHONY: sync
sync:
    fluxctl --k8s-fwd-ns=flux sync