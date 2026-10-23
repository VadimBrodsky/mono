Its possible to use a local package instead of a publicly hosted one while developing it.

This works for local-only development

go.mod:

```go
module github.com/wagslane/hellogo

go 1.20

replace github.com/wagslane/mystrings v0.0.0 => ../mystrings

require (
	github.com/wagslane/mystrings v0.0.0
)
```