#!/bin/bash

set -e

VERSION=${1:?Version is required, e.g. 4.16.11}
USER_ID=${2:?User id is required}

PROCESSORS=$(grep -c ^processor /proc/cpuinfo)

# we need to create the user
addgroup --gid $USER_ID kernel-builder
adduser --shell /bin/bash --uid $USER_ID --gid $USER_ID --no-create-home --gecos "" --disabled-password kernel-builder

cd /data/linux-$VERSION

time sudo -u kernel-builder make clean
time sudo -u kernel-builder make O=/data/output-$VERSION -j $PROCESSORS bindeb-pkg
