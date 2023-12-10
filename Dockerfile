FROM  ubuntu:22.04

WORKDIR /opt/

ENV UNBOUND_VERSION=1.19.0 

ADD https://nlnetlabs.nl/downloads/unbound/unbound-$UNBOUND_VERSION.tar.gz /opt/

RUN tar xzf /opt/unbound-$UNBOUND_VERSION.tar.gz && cd unbound-$UNBOUND_VERSION

RUN apt update && apt install -y build-essential libssl-dev libexpat1-dev flex bison make wget

WORKDIR /opt/unbound-${UNBOUND_VERSION}

RUN ./configure && make && make install && mkdir -p  /var/lib/unbound/ && rm -f /opt/unbound-$UNBOUND_VERSION.tar.gz

RUN wget https://www.internic.net/domain/named.root -qO- | tee /var/lib/unbound/root.hints 

RUN apt remove -y wget && apt autoremove -y 
