#!/bin/bash

function help {
    echo "Usage: ${0} <id> <city> "
}

if [ $# -lt 2 ]; then
    2>&1 help 
    exit 1
fi 

TOPIC="CUSTOMER-ADDRESS"

# Creates the topic if not exists
./create-topic.sh $TOPIC 3 1 

ID=$1
CITY=$2
JSON="\"id\":\"${ID}\", \"city\":\"${CITY}\""
command="./produce.sh ${TOPIC} < <(echo '${ID}:{${JSON}}')"
eval $command