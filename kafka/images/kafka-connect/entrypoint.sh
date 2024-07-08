#!/bin/bash

# Logger
function logger {
    echo -e "["$(date '+%Y-%m-%d %H:%M:%S,%3N')"] $1"
}

##################################################################################################################################
# Inject or set parameters
##################################################################################################################################
if [[ -z "$CONNECT_BOOTSTRAP_SERVERS" ]]; then
    logger "ERROR: missing mandatory config: CONNECT_BOOTSTRAP_SERVERS"
    exit 1
else
    logger "INFO: Updating connect-distributed.properties with CONNECT_BOOTSTRAP_SERVERS"
    sed -i -e "/bootstrap.servers=/s/.*/bootstrap.servers=$KAFKA_ZOOKEEPER_CONNECT/g" ${KAFKA_WORKDIR}/config/connect-distributed.properties
fi

if [[ -z "$CONNECT_GROUP_ID" ]]; then
    logger "WARN: Empty ENV CONNECT_GROUP_ID. Using default value."
else
    logger "INFO: Updating connect-distributed.properties with CONNECT_GROUP_ID"
    sed -i -e "/group.id=/s/.*/group.id=$CONNECT_GROUP_ID/g" ${KAFKA_WORKDIR}/config/connect-distributed.properties
fi

if [[ -n "$KAFKA_HEAP_OPTS" ]]; then
    sed -r -i 's/(export KAFKA_HEAP_OPTS)="(.*)"/\1="'"$KAFKA_HEAP_OPTS"'"/g' "$KAFKA_WORKDIR/bin/kafka-server-start.sh"
    unset KAFKA_HEAP_OPTS
fi

if [[ -z "$KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR" ]]; then
    export KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=-1
fi

if [[ -z "$KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR" ]]; then
    export KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
fi

if [[ -z "$KAFKA_TRANSACTION_STATE_LOG_MIN_ISR" ]]; then
    export KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
fi

if [[ -n "$KAFKA_LOG_RETENTION_HOURS" ]]; then
    logger "INFO: Updating log.retention.hours with KAFKA_LOG_RETENTION_HOURS"
    sed -i -e "/log.retention.hours=/s/.*/log.retention.hours=$KAFKA_LOG_RETENTION_HOURS/g" \
    ${KAFKA_WORKDIR}/config/connect-distributed.properties
fi

if [[ -n "$KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS" ]]; then
    logger "INFO: Updating log.retention.check.interval.ms with KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS"
    sed -i -e "/log.retention.check.interval.ms=/s/.*/log.retention.check.interval.ms=$KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS/g" \
    ${KAFKA_WORKDIR}/config/connect-distributed.properties
fi

##################################################################################################################################
# Build aliases by adding symbolic links for script names
##################################################################################################################################
SCRIPT_PATH=${KAFKA_WORKDIR}/bin
logger "Adding aliases for kafka scripts in ${SCRIPT_PATH}"
for scriptName in $(ls -1 ${SCRIPT_PATH}/*.sh); do
    aliasName=${scriptName%.sh}
    ln -s $scriptName $aliasName
done

##################################################################################################################################
# Start kafka broker
##################################################################################################################################
kafka-server-start.sh ${KAFKA_WORKDIR}/config/connect-distributed.properties

