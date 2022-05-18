cat ./scripts-cluster/cluster-blueprint-template.yaml | envsubst '${APIM_EKS_CLUSTER_NAME}' | envsubst '${APIM_CLUSTER_REGION}' > ./scripts-cluster/cluster-blueprint.yaml
eksctl get cluster --region ${APIM_CLUSTER_REGION} -n ${APIM_EKS_CLUSTER_NAME} || echo 'Cluster does not exists.' && exit 1
eksctl delete cluster -f ./scripts-cluster/cluster-blueprint.yaml --wait