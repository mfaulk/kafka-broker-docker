#!/bin/bash

# Fail hard and fast
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:4001

echo "[kafka-broker] booting container..."
echo "[kafka-broker] ETCD: $ETCD"
echo "[kafka-broker] KAFKA_HOME: $KAFKA_HOME"
echo "[kafka-broker] BROKER_ID: $BROKER_ID"
echo "[kafka-broker] KAFKA_ADVERTISED_HOST_NAME: $KAFKA_ADVERTISED_HOST_NAME"
echo "[kafka-broker] PORT: $PORT"


# Loop until confd has updated the kafka conifg/server.properties config file
until confd -onetime -node $ETCD -config-file /etc/confd/conf.d/kafka.toml; do
  echo "[kafka-broker] waiting for confd to refresh server.properties"
  sleep 5
done

# Start kafka-manager
echo "[kafka-broker] starting the kafka-broker"
exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties
