# WARNING: This Dockefile is only for testing purpose.
# Parameters:
# - name: JAVA_VERSION
#   default: 17
#   reference: https://hub.docker.com/_/eclipse-temurin/
# - name: SPARK_VERSION
#   default: 3.5.5
# - name: HADOOP_VERSION
#   default: 3
FROM python:3.10-slim-bookworm

LABEL maintainer="Soumik Das <soumik.uxd@gmail.com>"

# Build args
ARG JAVA_VERSION=17
ARG SPARK_VERSION=3.5.5
ARG HADOOP_VERSION=3

# Env vars
ENV ENABLE_INIT_DAEMON=false
ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"}
ENV HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"
ENV PYSPARK_PYTHON=python3
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
ENV PYTHONHASHSEED=1
ENV SPARK_VERSION=${SPARK_VERSION}
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64


# Install dependencies & then download & install spark, followed by a cleanup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo curl unzip rsync software-properties-common ssh \
    openjdk-${JAVA_VERSION}-jdk-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ${HADOOP_HOME} && mkdir -p ${SPARK_HOME} 

WORKDIR ${SPARK_HOME}

# Download and install Spark
RUN curl -fSL https://dlcdn.apache.org/spark//spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz --directory ${SPARK_HOME} --strip-components 1 && \
    rm -rf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Install python deps
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Configure Spark
COPY conf/spark-defaults.conf "${SPARK_HOME}/conf"
RUN chmod u+x ${SPARK_HOME}/sbin/* && \
    chmod u+x ${SPARK_HOME}/bin/*

# Start cluster
COPY *.sh .
RUN chmod +x ./*.sh

ENTRYPOINT ["./entrypoint.sh"]