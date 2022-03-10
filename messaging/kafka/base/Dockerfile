FROM openjdk:11.0.10-jre-buster

ENV KAFKA_VERSION 3.1.0
ENV SCALA_VERSION 2.13 
ENV KAFKA_URL https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

RUN mkdir /tmp/kafka && \
    apt-get update && \
    apt-get install -y curl
         
RUN curl "${KAFKA_URL}" -o /tmp/kafka/kafka.tgz \
    && mkdir /kafka && cd /kafka \
    && tar -xzf /tmp/kafka/kafka.tgz --strip 1 \
    && rm -f /tmp/kafka/kafka.tgz

ENV KAFKA_HOME=/kafka
ENV PATH $KAFKA_HOME/bin/:$PATH

ADD entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]