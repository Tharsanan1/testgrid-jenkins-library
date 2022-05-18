eksctl scale nodegroup --region ${APIM_CLUSTER_REGION} --cluster ${APIM_EKS_CLUSTER_NAME} --name ng-1 --nodes=0 || true
helm uninstall "${product_name}" || true
aws cloudformation delete-stack --region ${APIM_CLUSTER_REGION} --stack-name ${APIM_RDS_STACK_NAME} ; aws cloudformation wait stack-delete-complete --region ${APIM_CLUSTER_REGION} --stack-name apim-rds-stack) || true