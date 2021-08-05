#!/bin/bash

# Script to produce messages in a topic.

function help {
    echo "Usage: ${0} <id> <description> <price> "
}

if [ $# -lt 3 ]; then
    2>&1 help
    exit 1
fi

TOPIC="ITEM"

# Creates the topic if not exists
./create-topic.sh $TOPIC 1 1

ID=$1
DESCRIPTION=$2
PRICE=$3
JSON="\"id\":\"${ID}\", \"description\":\"${DESCRIPTION}\", \"price\":\"${PRICE}\""
command="./produce.sh ${TOPIC} < <(echo '${ID}:{${JSON}}')"
eval $command