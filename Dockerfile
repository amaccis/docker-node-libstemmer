FROM node:17.3-alpine3.15

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
    curl -fsSL -o libstemmer_c-$LIBSTEMMER_VERSION.tar.gz https://snowballstem.org/dist/libstemmer_c-$LIBSTEMMER_VERSION.tar.gz ; \
    tar xfz /usr/src/libstemmer_c-$LIBSTEMMER_VERSION.tar.gz ; \
    mv Makefile libstemmer_c-$LIBSTEMMER_VERSION ; \
    cd libstemmer_c-$LIBSTEMMER_VERSION ; \
    make ; \
    cp libstemmer.so /usr/lib ; \
    cd /usr/src ; \
    rm -rf libstemmer_c-$LIBSTEMMER_VERSION ; \
    rm /usr/src/libstemmer_c-$LIBSTEMMER_VERSION.tar.gz ; \
    apk del --no-network .utils-deps ; \
    # install node-gyp \
    npm install -g node-gyp
