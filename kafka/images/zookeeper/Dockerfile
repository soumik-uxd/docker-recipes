FROM openjdk:11-jre-slim

# TODO add labels

ARG ZOOKEEPER_VERSION=3.6.3

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

# Install zookeeper & then cleanup
RUN tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /opt && \    
    mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /opt/zookeeper && \ 
    cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
    rm -f apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.*

EXPOSE 2181 2888 3888

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]