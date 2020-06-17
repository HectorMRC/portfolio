#!/bin/sh

if !(go list -m | grep github.com/HectorMRC/portfolio); then
    go mod init github.com/HectorMRC/portfolio
    go get golang.org/x/tools/cmd/goimports
fi

if (go build -o grpc-server/main.go); then
    echo "SUCCESS: go build"
fi

echo "Done."