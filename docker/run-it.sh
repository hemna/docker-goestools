#!/bin/bash

docker run -d --name goestools \
    --hostname goestools \
    --user $(id -u):$(id -g) \
    -v /opt/docker/goestools/data:/home/goes/data \
    hemna/goestools
