FROM debian:bookworm-slim

LABEL author.name="Soumik Das"
LABEL author.email="soumik.das@outlook.de" 
LABEL description="Base image to build hadoop nodes"
LABEL version="0.1"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    libsnappy-dev \
    netcat-traditional \
    net-tools \
    openjdk-17-jre \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

ENV HADOOP_VERSION 3.3.1
ENV HADOOP_URL https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}
RUN set -x \
    && curl -fSL ${HADOOP_URL}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz \
    && curl -fSL ${HADOOP_URL}/hadoop-${HADOOP_VERSION}.tar.gz.asc -o /tmp/hadoop.tar.gz.asc \
    && curl -O https://downloads.apache.org/hadoop/common/KEYS \
    && gpg --import KEYS \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xf /tmp/hadoop.tar.gz -C /opt/ \
    && rm -f /tmp/hadoop.tar.gz

RUN ln -s /opt/hadoop-${HADOOP_VERSION}/etc/hadoop /etc/hadoop \
    && mkdir /opt/hadoop-${HADOOP_VERSION}/logs

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]    