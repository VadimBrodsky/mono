---
title: "Makefiles and Go"
tags: ["golang"]
created: "20230114154733362"
modified: "20230114160814301"
---

Makefiles are scripts that used to specify the build steps.

- Each possible operation is a target
- The `.DEFAULT_GOAL` defines which target is run when no target is specified
- The name before the `:` is the name of the target, any words after the target are the other targets that must run before the specified target runs
- The tasks that are performed by the target are on the indented lines after the target
- The `.PHONY` line keeps `make` from getting confused if you ever create a directory in your project with the same name as target

```makefile
.DEFAULT_GOAL := build

fmt:
	go fmt ./...
.PHONY:fmt

lint: fmt
	golint ./...
.PHONY:lint

vet: fmt
	go vet ./...
.PHONY:vet

build: vet
	go build hello.go
.PHONY:build
```

run it:

```shell
make
```
