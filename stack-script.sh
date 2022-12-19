#!/bin/bash

export STACK_NAME=my-EKS-VPC-stack
output=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} 2>&1)

if [ $? -ne 0 ]; then
  if echo ${output} | grep -q ValidationError; then
        echo 'creating stack....' ${STACK_NAME}
        aws cloudformation deploy --template-file aws-vpc-for-eks.yaml --stack-name ${STACK_NAME}
  else
    >&2 echo "Error is -->" ${output}
  fi
fi
