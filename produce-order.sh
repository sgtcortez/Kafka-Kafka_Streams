#!/bin/bash

# Script to produce messages in a topic.

function help {
    echo "Usage: ${0} <id> <customerId> <itemId> "
}

if [ $# -lt 3 ]; then
    2>&1 help 
    exit 1
fi 

TOPIC="ORDER"

# Creates the topic if not exists
./create-topic.sh $TOPIC 3 1 

ID=$1
CUSTOMER_ID=$2
ITEM_ID=$3
JSON="\"id\":\"${ID}\", \"customerId\":\"${CUSTOMER_ID}\", \"itemId\":\"${ITEM_ID}\""
command="./produce.sh ${TOPIC} < <(echo '${ID}:{${JSON}}')"
eval $command