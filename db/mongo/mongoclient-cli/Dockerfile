ARG VERSION=3.9
FROM alpine:${VERSION}
ARG VERSION
RUN cat /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v$VERSION/main" >> /etc/apk/repositories \ 
    && echo "https://dl-cdn.alpinelinux.org/alpine/v$VERSION/community" >> /etc/apk/repositories \ 
    && apk update \
    && apk add mongodb
CMD ["/bin/sleep","1d"]