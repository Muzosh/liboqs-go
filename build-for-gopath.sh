#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Remove old build files and make new build directory
rm -rf oqsgo
mkdir -p oqsgo


if [ -v LIBOQS_ROOT ] && [ -e $LIBOQS_ROOT ]; then
    echo "liboqs directory already exists, skipping cloning"; \
else \
    git clone -b main https://github.com/open-quantum-safe/liboqs.git; \
    export LIBOQS_ROOT=$(pwd)/liboqs; \
fi

cmake -GNinja -B $LIBOQS_ROOT/build liboqs && ninja -j $(nproc) -C $LIBOQS_ROOT/build

# Compile the C++ wrapper
swig -go -cgo -intgosize 64 -c++ -o ./oqsgo/oqsgo_wrap.cpp -I$LIBOQS_ROOT_DIR/build/include oqsgo.i
