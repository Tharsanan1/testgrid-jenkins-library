isEmpty () {
    if [ ${#1} -ge 1 ];
        then 
            return 0;
    else
        return 1;
    fi;
}

isEmpty "${EKS_CLUSTER_NAME}";
flag=$?
if [ $flag = 1 ];
    then echo "EKS_CLUSTER_NAME environment variable is empty."; exit 1
fi;

isEmpty "${EKS_CLUSTER_REGION}";
flag=$?
if [ $flag = 1 ];
    then echo "EKS_CLUSTER_REGION environment variable is empty."; exit 1
fi;

isEmpty "${EKS_CLUSTER_NAME}";
flag=$?
if [ $flag = 1 ];
    then echo "EKS_CLUSTER_NAME environment variable is empty."; exit 1
fi;


cat ./scripts-cluster/cluster-blueprint-template.yaml | envsubst '${EKS_CLUSTER_NAME}' | envsubst '${EKS_CLUSTER_REGION}' > ./scripts-cluster/cluster-blueprint.yaml
eksctl get cluster --region ${EKS_CLUSTER_REGION} -n ${EKS_CLUSTER_NAME} && echo "Cluster already exists" && exit 1
eksctl create cluster -f ./scripts-cluster/cluster-blueprint.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/aws/deploy.yaml 


