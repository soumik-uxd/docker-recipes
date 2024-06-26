# WARNING: This Dockerfile is only for testing purpose. 
# Please use the official image from https://hub.docker.com/_/zookeeper for production builds

FROM eclipse-temurin:17-jre-jammy

LABEL version="0.1"
LABEL maintainer="Soumik Das -- soumik.uxd@gmail.com"

ARG ZOOKEEPER_VERSION=3.9.2

ENV ZOOKEEPER_WORKDIR=/opt/zookeeper
ENV ZOOKEEPER_CONF_DIR=${ZOOKEEPER_WORKDIR}/conf
ENV ZOOKEEPER_DATA_DIR=${ZOOKEEPER_WORKDIR}/data
ENV ZOOKEEPER_LOG_DIR=${ZOOKEEPER_WORKDIR}/logs

# Install dependencies 
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yqq --no-install-recommends \
           coreutils \
           gnupg \
           wget && \
    rm -rf /var/lib/apt/lists/*

# Download zookeeper files & verify download
RUN wget -q https://dlcdn.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz  && \
    wget -q https://dlcdn.apache.org/zookeeper/KEYS && \
    wget -q https://dlcdn.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc && \
    gpg --import KEYS && \
    gpg --batch --verify apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz

# Extract zookeeper, setup required directories & then cleanup
RUN tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /opt && \    
    mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin ${ZOOKEEPER_WORKDIR} && \ 
    cp ${ZOOKEEPER_WORKDIR}/conf/zoo_sample.cfg ${ZOOKEEPER_WORKDIR}/conf/zoo.cfg && \
    mkdir -p ${ZOOKEEPER_DATA_DIR} && \
    mkdir -p ${ZOOKEEPER_LOG_DIR} && \
    rm -f apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.*

EXPOSE 2181 2888 3888 8080

VOLUME ["${ZOOKEEPER_CONF_DIR}", "${ZOOKEEPER_DATA_DIR}", "${ZOOKEEPER_LOG_DIR}"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]