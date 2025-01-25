#!/bin/bash

build() {
    docker build . --tag tinkertoy-app
}

deploy() {
    docker run -it --rm \
        --publish 81:80 \
        --name tinkertoy-app \
        tinkertoy-app
}

$*
