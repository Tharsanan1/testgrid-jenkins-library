HOST_NAME=$(kubectl -n ingress-nginx get svc ingress-nginx-controller -o json | jq .status.loadBalancer.ingress[0].hostname)
export HOST_NAME="$HOST_NAME"
echo "${HOST_NAME}"