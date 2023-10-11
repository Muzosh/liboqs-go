
# liboqs-go

Custom LibOQS wrapper for Go

## Installation

### GOPATH approach

1. Make sure your $GOPATH is set: `echo $GOPATH`
2. Clone this repository into your go path: `git clone https://github.com/Muzosh/liboqs-go $GOPATH/src/github.com/muzosh/liboqs-go`
3. If you already have libOQS repository on the system, specify its location by `export LIBOQS_ROOT=/path/to/liboqs`
4. Install wrapper: `cd $GOPATH/src/github.com/muzosh/liboqs-go && ./build-for-gopath.sh`
5. In your Go code use: `import "github.com/Muzosh/liboqs-go/oqsgo"` and then `oqsgo.XY()`
6. Before building or running the code, export there environment variables:

    ```bash
    export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$LIBOQS_ROOT/build/lib" # only for macOS
    export CGO_CPPFLAGS="-I$LIBOQS_ROOT/build/include"
    export CGO_LDFLAGS="-L$LIBOQS_ROOT/build/lib -loqs"
    ```

### Go modules approach

1. Get the module: `go get github.com/Muzosh/liboqs-go/oqsgo`
2. In your Go code use: `import "github.com/Muzosh/liboqs-go/oqsgo"` and then `oqsgo.XY()`
3. If you don't have libOQS on the system, clone and build it wherever you like:
    - `git clone -b main https://github.com/open-quantum-safe/liboqs.git && cd liboqs && cmake -GNinja -DBUILD_SHARED_LIBS=ON -B ./build . && ninja -j $(nproc) -C ./build`
4. Before building or running the code, export there environment variables:

    ```bash
    export LIBOQS_ROOT="CHANGE_ME: <path-to-liboqs-repo>"
    export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$LIBOQS_ROOT/build/lib" # only for macOS
    export CGO_CPPFLAGS="-I$LIBOQS_ROOT/build/include"
    export CGO_LDFLAGS="-L$LIBOQS_ROOT/build/lib -loqs"
    ```
