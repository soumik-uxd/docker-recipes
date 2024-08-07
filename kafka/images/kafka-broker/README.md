# Kafka Base 

This is a Dockerfile for building a broker image for [Apache Kafka](https://kafka.apache.org/) from the [base image](../kafka-base). 

## Details

### Arguments

| Argument      | Description                                         | Default        |
|---------------|-----------------------------------------------------|----------------|
| `JAVA_VERSION`| Java version to be used               | `21`           |
| `TAG`         | Tag for the Eclipse Temurin base image| `${JAVA_VERSION}-jre-jammy` |
| `SCALA_VERSION`| Scala version to be used with Kafka  | `2.13`         |
| `KAFKA_VERSION`| Kafka version to be installed        | `3.7.1`        |

### Environment Variables

| Variable          | Description                                      | Default        |
|-------------------|--------------------------------------------------|----------------|
| `KAFKA_WORKDIR`   | Directory where Kafka will be installed  | `/opt/kafka` |
| `KAFKA_CONF_DIR`  | Directory for Kafka configuration files          | `/opt/kafka/config`|
| `KAFKA_DATA_DIR`  | Directory for Kafka data                         | `/opt/kafka/data`|
| `KAFKA_LOG_DIR`   | Directory for Kafka logs                         | `/opt/kafka/logs`|
| `KAFKA_TEMP_DIR`  | Temporary directory for Kafka installation files | `/tmp/kafka` |
| `KAFKA_JMX_PORT`  | Port for Kafka JMX | `9999` |
| `KAFKA_PORT`      | Port for Kafka | `9092` |


### Ports

| Port             | Description          | Default        |
|------------------|----------------------|----------------|
| `KAFKA_JMX_PORT`  | Port for Kafka JMX | `9999` |
| `KAFKA_PORT`      | Port for Kafka | `9092` |

### Volumes
The directories specified by env params `KAFKA_CONF_DIR`, `KAFKA_DATA_DIR` and `KAFKA_LOG_DIR`

## Build

To build the Docker image, we can run the following command in the directory containing the Dockerfile:

```bash
docker build -t kafka-broker .
```

## Run
Examples of usages have been provided [here](../../stacks/custom/).

## Disclaimer
This Dockerfile is intended for testing purposes only. For production builds, use the official Apache Kafka image from [Docker Hub](https://hub.docker.com/r/apache/kafka).