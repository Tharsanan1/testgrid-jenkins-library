#!/bin/bash
productName=$1;
sh ./scripts-cluster/"$productName"/cleanup.sh || true
echo "Deleting RDS database." || true
aws cloudformation delete-stack --region ${EKS_CLUSTER_REGION} --stack-name ${RDS_STACK_NAME} ; aws cloudformation wait stack-delete-complete --region ${EKS_CLUSTER_REGION} --stack-name ${RDS_STACK_NAME} || true

echo "Scaling node group instances to zero."
eksctl scale nodegroup --region ${EKS_CLUSTER_REGION} --cluster ${EKS_CLUSTER_NAME} --name ng-1 --nodes=0 || true
