#!/bin/bash

# Logger
function logger {
    echo -e "["$(date '+%Y-%m-%d %H:%M:%S,%3N')"] $1"
}

##################################################################################################################################
# Inject or set parameters
##################################################################################################################################
if [[ -z "$KAFKA_ZOOKEEPER_CONNECT" ]]; then
    logger "ERROR: missing mandatory config: KAFKA_ZOOKEEPER_CONNECT"
    exit 1
else
    logger "INFO: Updating server.properties with KAFKA_ZOOKEEPER_CONNECT"
    sed -i -e "/zookeeper.connect=/s/.*/zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT/g" ${KAFKA_WORKDIR}/config/server.properties
fi

if [[ -n "$KAFKA_ZOOKEEPER_CONNECT_TIMEOUT_MS" ]]; then
    logger "INFO: Updating server.properties with KAFKA_ZOOKEEPER_CONNECT_TIMEOUT_MS"
    sed -i -e "/zookeeper.connection.timeout.ms=/s/.*/zookeeper.connection.timeout.ms=$KAFKA_ZOOKEEPER_CONNECT_TIMEOUT_MS/g" ${KAFKA_WORKDIR}/config/server.properties
else
    export KAFKA_ZOOKEEPER_CONNECT_TIMEOUT_MS=$(grep zookeeper.connection.timeout.ms ${KAFKA_WORKDIR}/config/server.properties | cut -d'=' -f2)
fi

if [[ -z "$KAFKA_PORT" ]]; then
    export KAFKA_PORT=9092
fi

if [[ -z "$KAFKA_BROKER_ID" ]]; then
    # By default auto allocate broker ID
    export KAFKA_BROKER_ID=1    
fi
logger "INFO: Updating server.properties with KAFKA_BROKER_ID"
sed -i -e "/broker.id=/s/.*/broker.id=$KAFKA_BROKER_ID/g" ${KAFKA_WORKDIR}/config/server.properties

if [[ -n "$KAFKA_NUM_PARTITIONS" ]]; then
    logger "INFO: Updating server.properties with KAFKA_NUM_PARTITIONS"
    sed -i -e "/num.partitions=/s/.*/num.partitions=$KAFKA_NUM_PARTITIONS/g" ${KAFKA_WORKDIR}/config/server.properties
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
logger "INFO: Updating server.properties with KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR"
sed -i -e "/transaction.state.log.replication.factor=/s/.*/transaction.state.log.replication.factor=$KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR/g" ${KAFKA_WORKDIR}/config/server.properties

if [[ -z "$KAFKA_TRANSACTION_STATE_LOG_MIN_ISR" ]]; then
    export KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
fi
logger "INFO: Updating server.properties with KAFKA_TRANSACTION_STATE_LOG_MIN_ISR"
sed -i -e "/transaction.state.log.min.isr=/s/.*/transaction.state.log.min.isr=$KAFKA_TRANSACTION_STATE_LOG_MIN_ISR/g" ${KAFKA_WORKDIR}/config/server.properties

if [[ -n "$KAFKA_LOG_RETENTION_HOURS" ]]; then
    logger "INFO: Updating server.properties with KAFKA_LOG_RETENTION_HOURS"
    sed -i -e "/log.retention.hours=/s/.*/log.retention.hours=$KAFKA_LOG_RETENTION_HOURS/g" \
    ${KAFKA_WORKDIR}/config/server.properties
fi

if [[ -n "$KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS" ]]; then
    logger "INFO: Updating server.properties with KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS"
    sed -i -e "/log.retention.check.interval.ms=/s/.*/log.retention.check.interval.ms=$KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS/g" \
    ${KAFKA_WORKDIR}/config/server.properties
fi

unset K
##################################################################################################################################
# Build aliases by adding symbolic links for script names
##################################################################################################################################
SCRIPT_PATH=${KAFKA_WORKDIR}/bin
logger "INFO: Adding aliases for kafka scripts in ${SCRIPT_PATH}"
for scriptName in $(ls -1 ${SCRIPT_PATH}/*.sh); do
    aliasName=${scriptName%.sh}
    if [[ -L "$aliasName" ]]; then
        logger "WARN: $aliasName exists. Skipping.."
    else
        ln -s $scriptName $aliasName
    fi
done

##################################################################################################################################
# Wait for zookeeper timeout (in case of restart)
##################################################################################################################################
logger "INFO: Waiting ${KAFKA_ZOOKEEPER_CONNECT_TIMEOUT_MS}ms for zookeeper node expiry on restart."
sleep ${KAFKA_ZOOKEEPER_CONNECT_TIMEOUT_MS}ms

##################################################################################################################################
# Start kafka broker
##################################################################################################################################
kafka-server-start.sh ${KAFKA_WORKDIR}/config/server.properties
