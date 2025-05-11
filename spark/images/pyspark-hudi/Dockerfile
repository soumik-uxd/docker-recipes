FROM pyspark AS pyspark-base

ARG SPARK_VERSION=3.5
ARG SCALA_VERSION=2.12
ARG ICEBERG_VERSION=1.9.0

# Download iceberg spark runtime
RUN curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${SPARK_VERSION}_${SCALA_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}}.jar -Lo /opt/spark/jars/iceberg-spark-runtime-${SPARK_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar
