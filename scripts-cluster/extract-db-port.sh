aws cloudformation describe-stacks --stack-name "${APIM_RDS_STACK_NAME}" --region "${APIM_CLUSTER_REGION}" --query 'Stacks[?StackName==`'$APIM_RDS_STACK_NAME'`][].Outputs[?OutputKey==`ApimDBJDBCPort`].OutputValue' --output text