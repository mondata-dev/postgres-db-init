FROM phusion/baseimage

RUN apt update && apt install -y postgresql-client dnsutils

COPY init.sh ./init.sh

RUN chmod +x ./init.sh

CMD ["/sbin/my_init"]

