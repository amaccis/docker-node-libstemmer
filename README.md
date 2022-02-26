# amaccis/node-libstemmer

The purpouse of this image is to provide an Alpine Linux 3.15 environment with Node.js 17 onboard, [node-gyp](https://github.com/nodejs/node-gyp) globally installed and the [libstemmer](https://snowballstem.org/dist/libstemmer_c.tgz) compiled as a shared library.

# Snowball and libstemmer

[Snowball](https://snowballstem.org/) is a small string processing language designed for creating stemming algorithms for use in Information Retrieval.
[Libstemmer](https://snowballstem.org/dist/libstemmer_c.tgz) instead, contains a complete set of Snowball stemming algorithms that you can include into a C project of your own. With libstemmer you don't need to use the Snowball compiler.

# How to use this image

## Using docker
```bash
$ docker run --name node-libstemmer -v $PWD/:/home/node/app -d amaccis/node-libstemmer
```

## Using docker-compose
```yaml
version: '3.8'

services:
  node:
    image: amaccis/node-libstemmer
    working_dir: /home/node/app
    volumes:
      - ./:/home/node/app
```
