#!/bin/bash

set -eu

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export fly_target=${fly_target:-hemna}
echo "Concourse API target ${fly_target}"
echo "Hemna $(basename $DIR)"

if [ ! -f credentials.yml ]; then
    echo "You need to create credentials.yml"
    exit 1
fi

pushd $DIR
  fly -t ${fly_target} set-pipeline -p docker-goestools -c pipeline.yml -l credentials.yml
  fly -t ${fly_target} unpause-pipeline -p docker-goestools
  fly -t ${fly_target} trigger-job -w -j docker-goestools/build-and-publish-goestools
popd
