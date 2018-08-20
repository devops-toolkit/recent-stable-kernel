#!/bin/bash

set -e

VERSION=${1:?Version is required, e.g. 4.16.11}
LOCALVERSION=${2:-dtk}

SD=$(dirname $0)
DT=$(date +%Y%m%d-%H%M%S)

$SD/download-and-extract.sh $VERSION

cd $SD

mkdir -p output-$VERSION

cp .config output-$VERSION
echo "-$LOCALVERSION" >output-$VERSION/localversion

docker run --rm -it \
        --name kernel-build-$DT \
		-v `pwd`:/data \
		quay.io/devops-toolkit/kernel-builder:1.1.0 \
		/data/build-kernel-inside-docker.sh $VERSION $(id -u)

RESULTS_DIR=results-$VERSION-$LOCALVERSION-$DT

mkdir -p $RESULTS_DIR
mv linux-*$VERSION-$LOCALVERSION*.* $RESULTS_DIR
