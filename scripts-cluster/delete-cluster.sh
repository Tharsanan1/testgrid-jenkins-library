cat ./scripts-cluster/cluster-blueprint-template.yaml | envsubst '${APIM_EKS_CLUSTER_NAME}' | envsubst '${APIM_CLUSTER_REGION}' > ./scripts-cluster/cluster-blueprint.yaml
cat ./scripts-cluster/cluster-blueprint.yaml
eksctl delete cluster -f ./scripts-cluster/cluster-blueprint.yaml --wait