FROM  ubuntu:22.04

ENV UNBOUND_VERSION=1.19.0 

WORKDIR /opt/
ADD https://nlnetlabs.nl/downloads/unbound/unbound-$UNBOUND_VERSION.tar.gz /opt/
RUN tar xzf /opt/unbound-$UNBOUND_VERSION.tar.gz
RUN apt update && apt install -y build-essential libssl-dev libexpat1-dev flex bison make

WORKDIR /opt/unbound-${UNBOUND_VERSION}
RUN ./configure && make && make install && useradd unbound
ADD --chown=unbound pi-hole.conf /usr/local/etc/unbound/unbound.conf
ADD --chown=unbound https://www.internic.net/domain/named.root  /usr/local/etc/unbound/root.hints 

WORKDIR /opt/
RUN rm -rf /opt/unbound-$UNBOUND_VERSION*

WORKDIR /usr/local/etc/unbound
CMD [ "unbound", "-d", "-vv", "-c", "unbound.conf" ]