# Remove old build files and make new build directory
rm -rf oqsgo
mkdir -p oqsgo

if [ -e "liboqs" ]; then
    echo "liboqs directory already exists, skipping cloning"; \
else \
    git clone -b main https://github.com/open-quantum-safe/liboqs.git; \
fi

cmake -GNinja -B liboqs/build liboqs && ninja -j $(nproc) -C liboqs/build

# Set the path to the liboqs root directory
LIBOQS_ROOT_DIR="liboqs"

# Compile the C++ wrapper
swig -go -cgo -intgosize 64 -c++ -o ./oqsgo/oqsgo_wrap.cpp -I$LIBOQS_ROOT_DIR/build/include oqsgo.i

# # Compile the C++ wrapper and link it with liboqs
# # without -std=c++11 or -std=c++20 it fails with exception definition
# gcc -std=c++20 -O2 -fPIC -I$LIBOQS_ROOT_DIR/build/include -c ./build/oqsgo_wrap.cpp -o ./build/oqsgo_wrap.o

# # Create the Go wrapper
# gcc -std=c++20 -shared ./build/oqsgo_wrap.o -L$LIBOQS_ROOT_DIR/build/lib -loqs -lssl -lcrypto -o ./build/oqsgo.so
