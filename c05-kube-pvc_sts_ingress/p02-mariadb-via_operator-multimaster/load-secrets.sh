# load me with:
# source ./load-secrets.sh
SECRET=$(kubectl get secret mariadb -ojson | jq -r '.data["root-password"]'|base64 -d)
