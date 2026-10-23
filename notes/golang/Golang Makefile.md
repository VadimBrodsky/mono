## Example
Implementation
```go
package main

func calculateValues(x int, y int) int {
	return x + y
}

func main() {}
```

Test
```go
// main_test.go
package main

import "testing"

func TestCalculateValues(t *testing.T) {
	var (
		expected = 10	
		a        = 5
		b        = 5
	)
	have := calculateValues(a, b)
	if have != expected {
		t.Errorf("expected %d, got %d", expectd, have)
	}
}
```

## Assertions

```go
t.Fail()    // fails the current test
t.Errorf()  // formatted error
```

## CLI
```bash
go test ./... # all files in a subfolder
go test . -v #   vebrose
go test ./ -run TestEqualPlayers # specific test only
go test ./ -count=1 # makes sure the test is not cached
```