#!/bin/bash

IMAGE_VERSION="22.13.1-2.2.0"
IMAGE_TAG=amaccis/node-libstemmer:$IMAGE_VERSION

docker build -t $IMAGE_TAG .
