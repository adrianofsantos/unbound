FROM  ubuntu:22.04

WORKDIR /opt/

ENV UNBOUND_VERSION=1.19.0 

ADD https://nlnetlabs.nl/downloads/unbound/unbound-$UNBOUND_VERSION.tar.gz .

RUN tar xzf unbound-$UNBOUND_VERSION.tar.gz && cd unbound-$UNBOUND_VERSION

RUN apt update && apt install -y build-essential libssl-dev libexpat1-dev flex bison

WORKDIR /opt/unbound-${UNBOUND_VERSION}`

RUN ./configure -h

RUN make

RUN make install