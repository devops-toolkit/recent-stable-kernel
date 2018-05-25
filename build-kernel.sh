#!/bin/bash

set -e

SD=$(dirname $0)
DT=$(date +%Y%m%d-%H%M%S)

cd $SD

docker run -it \
        --name kernel-build-$DT \
		-u `id -u`:`id -g` \
		-v `pwd`:/data \
		quay.io/devops-toolkit/kernel-builder:1.0.1 \
		/data/build-kernel-inside-docker.sh 4.15.3 $DT
