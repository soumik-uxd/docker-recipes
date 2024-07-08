ARG JAVA_VERSION=21
ARG TAG=${JAVA_VERSION}-jre-jammy 

FROM eclipse-temurin:${TAG}

LABEL version="0.1"
LABEL maintainer="Soumik Das -- soumik.uxd@gmail.com"

# Build args
ARG SCALA_VERSION=2.13
ARG KAFKA_VERSION=3.7.1

# Env vars
ENV KAFKA_BASE_URL=https://downloads.apache.org/kafka
ENV KAFKA_URL=${KAFKA_BASE_URL}/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ENV KAFKA_WORKDIR=/opt/kafka
ENV KAFKA_CONF_DIR=${KAFKA_WORKDIR}/config
ENV KAFKA_DATA_DIR=${KAFKA_WORKDIR}/data
ENV KAFKA_LOG_DIR=${KAFKA_WORKDIR}/logs
ENV KAFKA_TEMP_DIR=/tmp/kafka
ENV PATH="${KAFKA_WORKDIR}/bin:${PATH}"
ENV KAFKA_JMX_PORT=9999
ENV KAFKA_PORT=9092

# Install dependencies 
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yqq --no-install-recommends gnupg && \
    rm -rf /var/lib/apt/lists/*

# Download kafka files
RUN mkdir -p ${KAFKA_TEMP_DIR} ${KAFKA_WORKDIR} && \
    curl ${KAFKA_URL}.tgz -o ${KAFKA_TEMP_DIR}/kafka.tgz && \
    curl ${KAFKA_BASE_URL}/KEYS -o ${KAFKA_TEMP_DIR}/KEYS && \
    curl ${KAFKA_URL}.tgz.asc -o ${KAFKA_TEMP_DIR}/kafka.tgz.asc && \
    gpg --import ${KAFKA_TEMP_DIR}/KEYS && \
    gpg --batch --verify ${KAFKA_TEMP_DIR}/kafka.tgz.asc ${KAFKA_TEMP_DIR}/kafka.tgz

# Install kafka
RUN tar -xzf ${KAFKA_TEMP_DIR}/kafka.tgz --strip 1 -C ${KAFKA_WORKDIR} && \    
    mkdir -p ${KAFKA_DATA_DIR} ${KAFKA_LOG_DIR} && \
    rm -rf ${KAFKA_TEMP_DIR}

# Expose ports
EXPOSE ${KAFKA_JMX_PORT} ${KAFKA_PORT} 2${KAFKA_PORT}

VOLUME ["${KAFKA_CONF_DIR}", "${KAFKA_DATA_DIR}", "${KAFKA_LOG_DIR}"]