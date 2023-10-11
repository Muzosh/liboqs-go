#!/bin/bash

# Remove old build files and make new build directory
rm -rf oqsgo
mkdir -p oqsgo

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -e "$LIBOQS_ROOT" ]] || [[ -e "$script_dir/liboqs" ]]; then
    echo "liboqs directory already exists, skipping cloning"; \
else \
    git clone -b main https://github.com/open-quantum-safe/liboqs.git; \
    export LIBOQS_ROOT=$(pwd)/liboqs; \
fi

if [[ -e "$LIBOQS_ROOT/build" ]]; then
    echo "liboqs library already builded, skipping compilation"; \
else \
    rm -rf $LIBOQS_ROOT/build; \
    cmake -GNinja -B $LIBOQS_ROOT/build $LIBOQS_ROOT && ninja -j $(nproc) -C $LIBOQS_ROOT/build; \
fi

# Compile the C++ wrapper
swig -go -cgo -intgosize 64 -c++ -o ./oqsgo/oqsgo_wrap.cpp -I$LIBOQS_ROOT/build/include oqsgo.i
echo "Finished"