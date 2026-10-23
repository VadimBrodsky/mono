---
title: "The go Command"
tags: ["golang"]
created: "20230114151141663"
modified: "20230114154539216"
---

Go ships with many development tools that are accessible via the `go` command.

## go run 
The `go run` command build the binary in a temporary directory, executes it and deletes the binary after the program finishes. It is useful for testing small programs in Go like a scripting language.

```shell
go run hello.go
```

## go build
This create an executable binary in the current directory. The name of the binary matches the name of the file or package that was passed in. To specify a different name use the `-o` flag.

```shell
go build -o hello_world hello.go
```

## go install
Tools written in Go can be built from source and installed in the Go workspace via the `go install` command. The `go install` command takes an argument of the location the source code repository of the project we want to install, followed by the `@` and the version. It downloads, compiles and installs the tool into the `$GOPATH/bin` directory.

```shell
go install github.com/rakyll/hey@latest
```

To update a version of a tool to a newer version, rerun `go install` with the newer version specified or with `@latest`.

## go fmt
The `go fmt` tool automatically reformats your code to match the standard format. It fixes up the whitespace for indentation, lining up the fields in a struct and making sure there is proper spacing around operators.

```shell
go fmt .
```

## goimports
The `goimports` tool is an enhanced version of `go fmt` which also cleans up the import statements. It puts them in alphabetical order, removes unused imports and attempts to guess any unspecified imports.

```shell
go install golang.org/x/tools/cmd/goimports@latest
goimports -l -w .
```

## golint
The `golint` tool is a linter that ensures the code follows style guidelines.

```shell
go install golang.org/x/lint/golint@latest
golint ./...
```

## go vet
Another tool that checks function arity, assigning variables that are never used etc can be checked with `go vet`.

```shell
go vet ./...
```

## golangcli-lint
This tool combines multiple linters together: `golint, go vet` and others. It can be configured by including `.golangcli.yml` at the root of the project.

```shell
# using homebew
brew install golangci-lint

# using docker
docker run --rm -v $(pwd):/app -w /app golangci/golangci-lint:v1.50.1 golangci-lint run -v

golangcli-lint run
```
