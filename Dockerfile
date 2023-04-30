FROM node:20-alpine3.17

LABEL maintainer="Andrea Maccis <andrea.maccis@gmail.com>"

ARG libstemmer_version=2.2.0

ENV LIBSTEMMER_VERSION=${libstemmer_version}

COPY Makefile /usr/src/

RUN set -eux ; \
    apk add --no-cache --virtual .utils-deps \
            curl \
            tar ; \
    apk add --no-cache --virtual .build-deps \
            make \
            gcc \
            g++ \
            python3 ; \
    # build libstemmer \
    cd /usr/src ; \
    curl -fsSL -o libstemmer_c.tar.gz https://snowballstem.org/dist/libstemmer_c-$LIBSTEMMER_VERSION.tar.gz ; \
    echo "a61a06a046a6a5e9ada12310653c71afb27b5833fa9e21992ba4bdf615255de991352186a8736d0156ed754248a0ffb7b7712e8d5ea16f75174d1c8ddd37ba4a  /usr/src/libstemmer_c.tar.gz" | sha512sum -c ; \
    mkdir libstemmer_c ; \
    tar xfz /usr/src/libstemmer_c.tar.gz -C libstemmer_c --strip-components=1 ; \
    mv Makefile libstemmer_c ; \
    cd libstemmer_c ; \
    make ; \
    cp libstemmer.so /usr/lib ; \
    cd /usr/src ; \
    rm -rf libstemmer_c ; \
    rm /usr/src/libstemmer_c.tar.gz ; \
    apk del --no-network .utils-deps ; \
    # install node-gyp \
    npm install -g node-gyp
