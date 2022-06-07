#!/bin/bash
productName=$1;
sh ./scripts-cluster/"$productName"/cleanup.sh && \ 
    echo "Deleting RDS database." && \ 
    aws cloudformation delete-stack --region ${EKS_CLUSTER_REGION} --stack-name ${RDS_STACK_NAME} ; aws cloudformation wait stack-delete-complete --region ${EKS_CLUSTER_REGION} --stack-name ${RDS_STACK_NAME} || true

