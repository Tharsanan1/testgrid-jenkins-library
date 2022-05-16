eksctl create cluster -f ./scripts-cluster/cluster-blueprint.yaml --name ${APIM_EKS_CLUSTER_NAME}
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/aws/deploy.yaml 
