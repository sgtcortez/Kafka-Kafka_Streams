#!/bin/bash

# Script to create a topic

BINARY=$KAFKA_PATH/bin/kafka-topics.sh

function help {
    echo "Usage: ${0} <topic> <partitions> <replication-factor> [optional configs ...] "
    echo "For other configurations, run: ${BINARY} --help"
}

if [ $# -lt 3 ]; then
    2>&1 help
    exit 1
fi 

SERVER="--bootstrap-server localhost:9092"
TOPIC="--topic ${1}"
PARTITIONS="--partitions ${2}"
REPLICATION_FACTOR="--replication-factor ${3}"
OTHERS_CONFIGS=$4
command="${BINARY} ${SERVER} --create --if-not-exists ${TOPIC} ${PARTITIONS} ${REPLICATION_FACTOR} ${OTHERS_CONFIGS}"

eval $command 