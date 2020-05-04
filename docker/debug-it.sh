#!/bin/bash

docker run -it --rm --name goestools --user $(id -u):$(id -g) -v /home/waboring/docker/goestools/data:/home/goes/data hemna/goestools bash
