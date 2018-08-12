#!/bin/bash

set -e

VERSION=${1:?Version is required, e.g. 4.16.11}

PROCESSORS=$(grep -c ^processor /proc/cpuinfo)

cd /data/linux-$VERSION

time make clean
time make O=/data/output-$VERSION -j $PROCESSORS bindeb-pkg
