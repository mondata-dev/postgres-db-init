FROM alpine:3.12.1

RUN apk add postgresql-client

COPY init.sh /init.sh
COPY scripts /scripts

RUN chmod +x /init.sh

ENTRYPOINT ["/init.sh"]
