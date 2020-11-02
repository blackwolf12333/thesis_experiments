#!/usr/bin/env bash
# This script is used to automate building the docker image, it's only a
# convenience script

set -eu
DIR=$(cd $(dirname $0); pwd)

docker build -t thesis_experiments_env -f $DIR/Dockerfile $DIR
