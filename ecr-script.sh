#!/bin/sh
output=$(aws ecr describe-repositories --repository-names ${REPO_NAME} 2>&1)

if [ $? -ne 0 ]; then
  if echo ${output} | grep -q RepositoryNotFoundException; then
        aws ecr create-repository \
        --repository-name ${REPO_NAME} \
        --image-scanning-configuration scanOnPush=true \
        --region us-east-1
  else
    >&2 echo ${output}
  fi
fi
