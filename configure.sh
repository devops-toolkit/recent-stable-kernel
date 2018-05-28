#!/bin/bash

# requirements:
#   flex
#   libcurses5-dev

set -e

VERSION=${1:?Version is required, e.g. 4.16.11}
COMMAND=${2:-menuconfig}

SD=$(dirname $0)

$SD/download-and-extract.sh $VERSION

cd $SD

cp .config linux-$VERSION
make -C linux-$VERSION $COMMAND
cp linux-$VERSION/.config .config
