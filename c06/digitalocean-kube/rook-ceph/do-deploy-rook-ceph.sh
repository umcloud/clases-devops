# Deploy root-ceph operator
kubectl apply -f 00-node-custom-setup.yaml
(set -x; kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/operator.yaml)
# Wait for cluster CRD to be ready
until kubectl get crd clusters.ceph.rook.io 2>/dev/null; do sleep 1;done
# Create a cluster, and storagepool+storageclass, downloading from upstream
# and applying .diff patches for:
# - cluster: single monitor
# - storagepool: OSDs to /rook/storage-dir, reclaim to Delete
for i in cluster.yaml storageclass.yaml toolbox.yaml; do
    (set -x; curl -sO https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/$i)
	test -f $i.diff && patch -p0 -i $i.diff
    (set -x; kubectl apply -f $i)
done
echo "Switching default storageclass to rook-ceph:"
kubectl get sc
kubectl get sc |awk '/default/{ print $1 }'|xargs -I@ kubectl patch sc @ -p '{"metadata": {"annotations": { "storageclass.kubernetes.io/is-default-class": "false"}}}'
kubectl get sc |awk '/rook/{ print $1 }'   |xargs -I@ kubectl patch sc @ -p '{"metadata": {"annotations": { "storageclass.kubernetes.io/is-default-class": "true"}}}'
kubectl get sc
echo "INFO: To log into toolbox: ->"
echo 'kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash'
