ARG node_version=24.18.0
ARG alpine_version=3.24
ARG libstemmer_version

FROM node:${node_version}-alpine${alpine_version}

LABEL org.opencontainers.image.authors="Andrea Maccis <andrea.maccis@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/amaccis/docker-node-libstemmer"
LABEL org.opencontainers.image.description="Docker Alpine Linux environment with Node.js onboard, node-gyp globally installed and the libstemmer compiled as a shared library."
LABEL org.opencontainers.image.licenses="MIT"


ARG node_version
ARG alpine_version
ARG libstemmer_version

ENV NODE_VERSION=${node_version}
ENV ALPINE_VERSION=${alpine_version}
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
