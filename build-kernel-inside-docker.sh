#!/bin/bash

set -e

VERSION=${1:?Error: version is not specified}
BUILD_TAG=${2:?Build tag is not defined}

cd /data

wget --continue https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-$VERSION.tar.xz

TMP_DIR=$(mktemp -d)
PROCESSORS=$(grep -c ^processor /proc/cpuinfo)

tar -xaf linux-$VERSION.tar.xz -C $TMP_DIR

cd $TMP_DIR/linux-$VERSION
cp /data/.config .

sed -i s/CONFIG_LOCALVERSION=\"\"/CONFIG_LOCALVERSION=\"-$BUILD_TAG\"/g .config

time make -j $PROCESSORS deb-pkg

cd ..

ls -lh

# remove package with debug kernel (it is huge)
rm *-dbg_*

# rename deb files like this:
# linux-image-4.15.2_4.15.2-1_amd64.deb -> linux-image-4.15.2_amd64.deb
for f in *.deb; do
    mv -v $f $(echo $f | sed 's/\(.*\)_\(.*\)_\(.*\)/\1_\3/g')
done

# copy results back to host
cp *.deb /data
cp linux-$VERSION/.config /data/.config-$VERSION-$BUILD_TAG
