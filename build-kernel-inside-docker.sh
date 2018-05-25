#!/bin/bash

set -e

VERSION=${1:?Version is required, e.g. 4.16.11}
BUILD_TAG=${2:?Build tag is not defined}

PROCESSORS=$(grep -c ^processor /proc/cpuinfo)

cd /data/linux-$VERSION

sed -i s/CONFIG_LOCALVERSION=\".*\"/CONFIG_LOCALVERSION=\"-$BUILD_TAG\"/g .config

time make clean
time make -j $PROCESSORS bindeb-pkg

cd ..

ls -lh

mkdir -p results-$VERSION-$BUILD_TAG
mv linux-*$VERSION-$BUILD_TAG*.* results-$VERSION-$BUILD_TAG

cd results-$VERSION-$BUILD_TAG

# rename deb files like this:
# linux-image-4.15.2_4.15.2-1_amd64.deb -> linux-image-4.15.2_amd64.deb
for f in *.deb; do
    mv -v $f $(echo $f | sed "s/-$BUILD_TAG-[[:digit:]]//g")
done
