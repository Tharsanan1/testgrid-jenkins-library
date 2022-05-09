pwd
ls
eksctl create cluster -f ./cluster-blueprint.yaml --dry-run
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/aws/deploy.yaml --dry-run
