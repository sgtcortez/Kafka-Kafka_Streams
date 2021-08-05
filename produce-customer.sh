#!/bin/bash

function help {
    echo "Usage: ${0} <id> <name> <email>"
}

if [ $# -lt 3 ]; then
    2>&1 help 
    exit 1
fi 

TOPIC="CUSTOMER"

# Creates the topic if not exists
./create-topic.sh $TOPIC 3 1 

ID=$1
NAME=$2
EMAIL=$3
JSON="\"id\":\"${ID}\", \"name\":\"${NAME}\", \"email\":\"${EMAIL}\""
command="./produce.sh ${TOPIC} < <(echo '${ID}:{${JSON}}')"
eval $command