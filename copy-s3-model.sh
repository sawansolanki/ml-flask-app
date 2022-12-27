#!/bin/bash

BUCKET="first-bucket-sa2"
MODELFILE="titanic_model_lr_Sa1"

PREFIX="modle-folder"
END="titanic_model_lr_Sa1"

FILE="$(aws s3 ls $BUCKET/$PREFIX/ --recursive | grep $MODELFILE | sort | tail -n 1 | awk '{print $4}')"

#####
bucketstatus=$(aws s3api head-bucket --bucket "${BUCKET}" 2>&1)

if echo "${bucketstatus}" | grep 'Not Found';
then
  echo "bucket doesn't exist";
  >&2 echo ${bucketstatus}
  
elif echo "${bucketstatus}" | grep 'Forbidden';
then
  echo "Bucket exists but not owned"
  >&2 echo ${bucketstatus}
  
elif echo "${bucketstatus}" | grep 'Bad Request';
then
  echo "Bucket name specified is less than 3 or greater than 63 characters"
  >&2 echo ${bucketstatus}
  
else
  echo "Bucket owned and exists";
fi
#####

n=${#FILE} 

if [ $n -eq 0 ]; then
    echo "fetched result empty" 
    exit 1
    

elif [ $n -gt 0 ]; then
    if grep -q "$END" <<< "$FILE"; then
        echo "fl -->" $FILE;
        aws s3 cp s3://$BUCKET/$FILE .
        echo "the file copied is correct";
    
    else
        echo "fetched wrong file --> " $FILE
        exit 100
    fi
fi
