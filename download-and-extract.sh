#!/bin/bash

set -e

VERSION=${1:?Version is required, e.g. 4.16.11}

SD=$(dirname $0)

cd $SD

if ! test -d linux-$VERSION; then
    wget --continue https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-$VERSION.tar.xz
    tar -xaf linux-$VERSION.tar.xz
fi
