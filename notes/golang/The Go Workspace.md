---
title: "The Go Workspace"
tags: ["golang"]
created: "20230114145811992"
modified: "20230114150450940"
---

Go expects a single workspace for third-party Go tools installed via `go install`.

- By default this workspace is located in `$HOME/go`
- Source code for these tools is in `$HOME/go/src`
- The compiled binaries are in `$Home/go/bin`

A different workspace path can be set by setting the `$GOPATH` environment variable.

```shell
# in $HOME/.profile or similar
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin
```

To see the full list of environment variables that are recognized by the `go` tool, run `go env`.

There is no need to set the `GOROOT` manually, the `go` tool figures it out automatically.
