#!/bin/bash

## Script to consume messages from a topic

BINARY=$KAFKA_PATH/bin/kafka-console-consumer.sh

function help {
    echo "Usage: ${0} <group> <topic> [optional configs ...] "
    echo "For other configurations, run: ${BINARY} --help"
}

if [ $# -lt 2 ]; then
    2>&1 help
    exit 1
fi 

SERVER="--bootstrap-server localhost:9092"
GROUP="--group ${1}"
TOPIC="--topic ${2}"
PROPERTIES="--property print.key=true --property print.offset=true --property print.partition=true"
OTHERS_CONFIGS=$3

command="${BINARY} ${SERVER} ${GROUP} ${TOPIC} --from-beginning ${PROPERTIES} ${OTHERS_CONFIGS}"
eval $command