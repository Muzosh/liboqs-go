#!/bin/bash

# Remove old build files and make new build directory
rm -rf oqsgo
mkdir -p oqsgo

# Compile the C++ wrapper
swig -go -cgo -intgosize 64 -c++ -o ./oqsgo/oqsgo_wrap.cpp -I$LIBOQS_ROOT/build/include oqsgo.i
echo "Finished"