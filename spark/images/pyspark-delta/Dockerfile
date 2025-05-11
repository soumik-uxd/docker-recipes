FROM pyspark AS pyspark-base

ARG DELTA_CORE_VERSION=2.4.0
ARG SCALA_VERSION=2.12
ARG DELTA_VERSION=3.2.0

# Download delta jars
RUN curl https://repo1.maven.org/maven2/io/delta/delta-core_${SPARK_VERSION}/${DELTA_CORE_VERSION}/delta-core_${SPARK_VERSION}-${DELTA_CORE_VERSION}.jar -Lo /opt/spark/jars/delta-core_${SPARK_VERSION}-${DELTA_CORE_VERSION}.jar
RUN curl https://repo1.maven.org/maven2/io/delta/delta-spark_${SPARK_VERSION}/${DELTA_VERSION}/delta-spark_${SPARK_VERSION}-${DELTA_VERSION}.jar -Lo /opt/spark/jars/delta-spark_${SPARK_VERSION}-${DELTA_VERSION}.jar
RUN curl https://repo1.maven.org/maven2/io/delta/delta-storage/${DELTA_VERSION}/delta-storage-${DELTA_VERSION}.jar -Lo /opt/spark/jars/delta-storage-${DELTA_VERSION}.jar

