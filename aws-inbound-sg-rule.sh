#!/bin/bash

sg_id=sg-0c874a2a7d963fef0
Protocol=tcp
port=30479
cidr=0.0.0.0/0

output=$(aws ec2 authorize-security-group-ingress     --group-id $sg_id     --protocol $Protocol     --port $port     --cidr 0.0.0.0/0 2>&1)

if [ $? -ne 0 ]; then
  if echo ${output} | grep -q InvalidPermission.Duplicate; then
        echo 'sg inbound rule already exist'
		
  else
	aws ec2 authorize-security-group-ingress     --group-id $sg_id     --protocol $Protocol     --port $port     --cidr $cidr 2>&1
    >&2 echo "Error is -->" ${output}
  fi
fi
