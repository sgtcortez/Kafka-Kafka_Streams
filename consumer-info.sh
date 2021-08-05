#!/bin/bash

# Script to obtain consumer group information

BINARY=$KAFKA_PATH/bin/kafka-consumer-groups.sh

function help {
    echo "Usage: ${0} <group> [optional configs ...] "
    echo "For other configurations, run: ${BINARY} --help"
}

SERVER="--bootstrap-server localhost:9092"
GROUP="--group ${1}"
OTHERS_CONFIGS=$2

command="${BINARY} ${SERVER} ${GROUP} ${OTHERS_CONFIGS}"
eval $command