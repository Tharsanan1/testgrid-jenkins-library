cat ./scripts-cluster/cluster-blueprint-template.yaml | envsubst '${EKS_CLUSTER_NAME}' | envsubst '${EKS_CLUSTER_REGION}' > ./scripts-cluster/cluster-blueprint.yaml
eksctl get cluster --region ${EKS_CLUSTER_REGION} -n ${EKS_CLUSTER_NAME} ||  { echo 'Cluster does not exists.'; exit 1; }
eksctl delete cluster -f ./scripts-cluster/cluster-blueprint.yaml --wait