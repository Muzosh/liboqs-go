# liboqs-go

Custom LibOQS wrapper for Go

## Installation

### GOPATH approach

1. Make sure your $GOPATH is set: `echo $GOPATH`
2. Clone this repository into your go path: `git clone https://github.com/Muzosh/liboqs-go $GOPATH/Muzosh/liboqs-go`
3. Install wrapper: `cd $GOPATH/src/github.com/Muzosh/liboqs-go && ./build-for-gopath.sh`
4. In your Go code use: `import "github.com/Muzosh/liboqs-go/oqsgo"` and then `oqsgo.XY()`
5. Before building or running the code, export there environment variables:

    ```bash
    export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:$GOPATH/Muzosh/liboqs-go/liboqs/build/lib" # only for macOS
    export CGO_CFLAGS="-I$GOPATH/Muzosh/liboqs-go/liboqs/build/include"
    export CGO_LDFLAGS="-L$GOPATH/Muzosh/liboqs-go/liboqs/build/lib -loqs"
    ```

### Go modules approach

1. Get the module: `go get github.com/Muzosh/liboqs-go/oqsgo`
2. In your Go code use: `import "github.com/Muzosh/liboqs-go/oqsgo"` and then `oqsgo.XY()`
3. Before building or running the code, export there environment variables:

    ```bash
    export DYLD_FALLBACK_LIBRARY_PATH="$DYLD_FALLBACK_LIBRARY_PATH:`go env GOPATH`/\!muzosh/liboqs-go/liboqs/build/lib" # only for macOS
    export CGO_CFLAGS="-I`go env GOPATH`/\!muzosh/liboqs-go/liboqs/build/include"
    export CGO_LDFLAGS="-L`go env GOPATH`/\!muzosh/liboqs-go/liboqs/build/lib -loqs"
    ```
