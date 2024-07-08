ARG JAVA_VERSION=21
ARG TAG=${JAVA_VERSION}-jre-jammy 

FROM eclipse-temurin:${TAG}

# Build args
ARG CMAK_VERSION=3.0.0.6

# Env vars
ENV CMAK_WORKDIR=/opt/cmak
ENV CMAK_TEMP_DIR=/tmp/cmak
ENV PATH="${CMAK_WORKDIR}/bin:${PATH}"
ENV CMAK_PORT=9092
ENV JAVA_OPTS=-XX:MaxRAMPercentage=80

# Install dependencies 
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yqq --no-install-recommends unzip && \
    rm -rf /var/lib/apt/lists/*

# Download & install
RUN mkdir -p ${CMAK_TEMP_DIR} ${CMAK_WORKDIR} && \
    curl -Ls https://github.com/yahoo/CMAK/releases/download/${CMAK_VERSION}/cmak-${CMAK_VERSION}.zip -o ${CMAK_TEMP_DIR}/cmak.zip && \
    ls -al ${CMAK_TEMP_DIR} && \
    unzip -qq ${CMAK_TEMP_DIR}/cmak.zip -d ${CMAK_TEMP_DIR} && \
    mv ${CMAK_TEMP_DIR}/cmak-${CMAK_VERSION}/* ${CMAK_WORKDIR} && \
    rm -rf ${CMAK_TEMP_DIR}

EXPOSE ${CMAK_PORT}

WORKDIR ${CMAK_WORKDIR}

# Start cmak
COPY *.sh .
RUN chmod +x ./*.sh
ENTRYPOINT ["./entrypoint.sh"]