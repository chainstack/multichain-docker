FROM ubuntu:bionic

LABEL maintainer="alex.khaerov@chainstack.com"
LABEL vendor="Chainstack"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8

ENV MULTICHAIN_VERSION 2.0-release

WORKDIR /tmp

RUN apt-get update \
    && apt-get upgrade -q -y \
    && apt-get dist-upgrade -q -y \
    && apt-get install -q -y wget curl python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget -nv https://www.multichain.com/download/multichain-${MULTICHAIN_VERSION}.tar.gz \
    && tar -xvzf multichain-${MULTICHAIN_VERSION}.tar.gz \
    && cd multichain-${MULTICHAIN_VERSION} \
    && mv multichaind multichain-cli multichain-util /usr/local/bin \
    && curl https://bootstrap.pypa.io/get-pip.py | python \
    && pip install dump-env -q \
    && mkdir /root/.multichain \
    && rm -rf /tmp/multichain-${MULTICHAIN_VERSION}

COPY *.template /root/.multichain/

WORKDIR /root/.multichain

CMD ["/bin/bash"]
