Para browsear localmente:

    kubectl proxy &
    # Reemplazar YOUR_NAMESPACE debajo ->
    curl http://localhost:8001/api/v1/namespaces/YOUR_NAMESPACE/services/web/proxy/
