# From: helm status prometheus
POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
echo "# 1) Run: "
echo "kubectl --namespace monitoring port-forward $POD_NAME 9090"
echo "# 2) Visit: http://localhost:9090/"

echo "# 3) Try some PromQL examples:"
echo '
   container_memory_usage_bytes
   container_memory_usage_bytes{namespace!=""}
   sum(container_memory_usage_bytes{namespace!=""}) by (namespace)
   sum(container_memory_usage_bytes{namespace!=""}) by (namespace, pod_name)
   sum(container_memory_usage_bytes{namespace!=""}) by (namespace, container_name)
 
 
   container_cpu_usage_seconds_total
   rate(container_cpu_usage_seconds_total{namespace!=""}[5m])
   sum(rate(container_cpu_usage_seconds_total{namespace!=""}[5m])) by (namespace)
   sum(rate(container_cpu_usage_seconds_total{namespace!=""}[5m])) by (namespace, container_name)
'
