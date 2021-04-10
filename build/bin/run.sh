#!/usr/bin/env bash

#telegraf --config /etc/telegraf/telegraf.conf --quiet &

cd $HOME/data
goesproc -c /home/goes/goesproc.conf --mode packet --subscribe tcp://192.168.1.7:5004
