#!/bin/bash

sg_id=sg-09d56c064f5936e41
Protocol=tcp
port=31479
cidr=0.0.0.0/0

output=$(aws ec2 authorize-security-group-ingress     --group-id $sg_id     --protocol $Protocol     --port $port     --cidr 0.0.0.0/0 2>&1)

if [ $? -ne 0 ]; then
  if echo ${output} | grep -q InvalidPermission.Duplicate; then
        echo 'sg inbound rule for port '$port 'already exist'

  else
    >&2 echo "Error is -->" ${output}
  fi
fi
