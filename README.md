# liboqs-go
Custom LibOQS wrapper for Go

## Installation

### GOPATH approach
1. Clone this repository into your `$GOPATH/src/github.com/Muzosh` directory
2. `cd $GOPATH/src/github.com/Muzosh/liboqs-go && ./build-for-gopath.sh`
3. in your Go code: `import "github.com/Muzosh/liboqs-go/oqsgo"`
4. use `oqsgo`
5. (MacOS) run your code with `DYLD_FALLBACK_LIBRARY_PATH=$GOPATH/src/github.com/Muzosh/liboqs-go/liboqs/build/lib GO111MODULE=off go run .`

### Go modules approach
1. `go get github.com/Muzosh/liboqs-go/oqsgo`
2. ``export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:`go env GOPATH`/pkg/mod/github.com/\!muzosh/liboqs-go@*/.config``