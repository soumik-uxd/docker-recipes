ARG TAG=11-alpine

FROM postgres:${TAG}

LABEL version="1.0"
LABEL description="A postgres image with the Chinook database preloaded"
LABEL maintainer="Soumik Das -- soumik.uxd@gmail.com"
LABEL source_url=""

# Create dirs and log files
RUN mkdir -p /home/data
RUN mkdir -p /home/conf
RUN touch /var/log/chinook-load.log

# Load env and sql files
COPY *.env /home/conf/
COPY *.sql /home/data/

# Load init script
COPY load-db.sh /docker-entrypoint-initdb.d/load-db.sh

# Provide necessary permissions
RUN chmod a+x /docker-entrypoint-initdb.d/load-db.sh
RUN chmod a+rwx /home/data
RUN chmod a+rwx /home/conf
RUN chmod a+w /home/data/*.sql
RUN chmod a+w /home/conf/*.env
RUN chmod a+w /var/log/chinook-load.log

# Superuser password for the postgresql. Uncomment only for local use
#ENV POSTGRES_PASSWORD=adm1n

# Set schema name for the data to be bound to
ENV DB_SCHEMA=main