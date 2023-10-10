#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LIBOQS_ROOT_DIR="$script_dir/liboqs"

# Remove old build files and make new build directory
rm -rf oqsgo
mkdir -p oqsgo

git submodule update --init --remote --recursive

cmake -GNinja -DBUILD_SHARED_LIBS=ON -B liboqs/build liboqs && ninja -j $(nproc) -C liboqs/build

# Compile the C++ wrapper
swig -go -cgo -intgosize 64 -c++ -o ./oqsgo/oqsgo_wrap.cpp -I$LIBOQS_ROOT_DIR/build/include oqsgo.i

sed -i "" "s/#undef intgo/#undef intgo\n#cgo CFLAGS: -I\${SRCDIR}\/..\/liboqs\/build\/include\n#cgo LDFLAGS: -L\${SRCDIR}\/..\/liboqs\/build\/lib -loqs/" oqsgo/oqsgo.go

export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$script_dir/liboqs/build/lib"
