#!/bin/bash

BUCKET="ml-model-ket"
MODELFILE="ml-model.txt"
PREFIX="model-output"

FILE="$(aws s3 ls $BUCKET/$PREFIX/ --recursive | grep $MODELFILE | sort | tail -n 1 | awk '{print $4}')"

END="ml-model.txt"

n=${#FILE} 

if [ $n -eq 0 ]; then
    echo "fetched result empty" 
    exit 1
    

elif [ $n -gt 0 ]; then
    if grep -q "$END" <<< "$FILE"; then
        echo "fl -->" $FILE;
        #aws s3 cp s3://$BUCKET/$FILE .
        echo "the file copied is correct";
    
    else
        echo "fetched wrong file --> " $FILE
        exit 1
    fi
fi
