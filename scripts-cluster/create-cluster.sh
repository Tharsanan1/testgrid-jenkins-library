eksctl create cluster -f ./scripts-cluster/cluster-blueprint.yaml
aws s3 cp ~/.kube/config s3://apim-test-grid/profile-automation/kube-config
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/aws/deploy.yaml 
