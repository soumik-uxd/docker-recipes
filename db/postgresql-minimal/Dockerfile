FROM alpine:3.14
RUN echo https://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache postgresql bash 
    #&& \
    #adduser -G wheel postgresql && \
    #addgroup -S postgres && adduser -S postgres -G postgres && \
    #mkdir -p /var/lib/postgresql/data && mkdir -p /run/postgresql/ && \
    #chown -R postgres:postgres /run/postgresql/ && \
    #chmod -R 777 /var/lib/postgresql/data && \
    #chown -R postgres:postgres /var/lib/postgresql/data 

#USER postgresql

#RUN su - postgres -c "initdb /var/lib/postgresql/data" && \
#    echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf && \
#    su - postgres -c "pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/log.log

