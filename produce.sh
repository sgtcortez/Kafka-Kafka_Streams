#!/bin/bash

# Script to produce messages in a topic.

BINARY=$KAFKA_PATH/bin/kafka-console-producer.sh

function help {
    echo "Usage: ${0} <topic> [optional configs ...] "
    echo "For other configurations, run: ${BINARY} --help"
}

if [ $# -lt 1 ]; then
    2>&1 help 
    exit 1
fi 

SERVER="--bootstrap-server localhost:9092"
TOPIC="--topic ${1}"
PROPERTIES="--property parse.key=true --property key.separator=: --compression-codec gzip --property cleanup.policy=compact "
OTHERS_CONFIGS=$2

command="${BINARY} ${SERVER} ${TOPIC} ${PROPERTIES} ${OTHERS_CONFIGS}"
eval $command