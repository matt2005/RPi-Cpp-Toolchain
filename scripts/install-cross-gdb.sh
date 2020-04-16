#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 arm|aarch64"
    exit 0
fi

case "$1" in
    arm)     target=arm-linux-gnueabihf ;;
    aarch64) target=aarch64-linux-gnu ;;
    *) echo "Unknown architecture. Choose either 'arm' or 'aarch64'"; exit 1 ;;
esac

cd /tmp
if [ ! -e gdb-8.3.tar.xz ]; then
    wget https://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.xz
fi
rm -rf gdb-8.3
tar xf gdb-8.3.tar.xz
mkdir -p gdb-8.3/build
cd gdb-8.3/build
../configure --prefix=$HOME/.local --target=$target
make -j$(nproc)
make -C gdb install
