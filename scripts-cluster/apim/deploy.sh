workingdir=$(pwd)
reldir=`dirname $0`
cd $reldir

eksctl scale nodegroup --region ${APIM_CLUSTER_REGION} --cluster ${APIM_EKS_CLUSTER_NAME} --name ng-1 --nodes=1
dbPassword=$(echo $RANDOM | md5sum | head -c 8)
echo "DB password : $dbPassword"
aws cloudformation create-stack --region ${APIM_CLUSTER_REGION} --stack-name ${APIM_RDS_STACK_NAME}   --template-body file://apim-rds-cf.yaml --parameters ParameterKey=pDbUser,ParameterValue=root ParameterKey=pDbPass,ParameterValue="$dbPassword"; aws cloudformation wait stack-create-complete --region ${APIM_CLUSTER_REGION} --stack-name ${APIM_RDS_STACK_NAME} 
dbPort=$(aws cloudformation describe-stacks --stack-name "${APIM_RDS_STACK_NAME}" --region "${APIM_CLUSTER_REGION}" --query 'Stacks[?StackName==`'$APIM_RDS_STACK_NAME'`][].Outputs[?OutputKey==`ApimDBJDBCPort`].OutputValue' --output text | xargs)
dbHost=$(aws cloudformation describe-stacks --stack-name "${APIM_RDS_STACK_NAME}" --region "${APIM_CLUSTER_REGION}" --query 'Stacks[?StackName==`'$APIM_RDS_STACK_NAME'`][].Outputs[?OutputKey==`ApimDBJDBCConnectionString`].OutputValue' --output text | xargs)
echo "db details $dbPort $dbHost"
mysql -h "$dbHost" -P "$dbPort" -u root -p"$dbPassword" < wso2-am-db-cripts.sql

aws s3 cp s3://apim-test-grid/profile-automation/kube-config ~/.kube/config

eksctl get cluster --region ${APIM_CLUSTER_REGION} -n ${APIM_EKS_CLUSTER_NAME} || (echo 'Cluster does not exists. Please create the cluster before deploying the applications.'; exit 1)
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=240s

helm repo add wso2 https://helm.wso2.com && helm repo update
helm dependency build "kubernetes-apim/${path_to_helm_folder}"
helm install apim "kubernetes-apim/${path_to_helm_folder}" --set wso2.deployment.am.mysql.hostname="$dbHost" --set wso2.deployment.am.mysql.port="$dbPort" 


cd "$workingdir"