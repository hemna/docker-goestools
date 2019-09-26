#!/usr/bin/env bash

# HOME=/home/weewx is set by the Dockerfile but can be overridden in run command
echo "using $CONF"

cd $HOME
#CMD="$HOME/bin/weewxd --log-label weewx-hemna $CONF_FILE"
echo "Running '$CMD'"
#$HOME/bin/weewxd --log-label weewx-hemna $CONF_FILE
cd data
goesproc -c /home/goes/goesproc.conf --mode packet --subscribe tcp://192.168.1.7:5004
