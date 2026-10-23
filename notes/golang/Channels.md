Channels are a typed, thread-safe queue. Channels allow different goroutines to communicate with each other.

A channel in Go would always block if its full 

There are 2 types of channels:
1. Unbuffered channels
2. Buffered channels - can only fit a defined number of messages

```go
unbufferedChannel := make(chan string)
bufferedChannel := make(chan string, 10)
```

## Create a Channel

Like maps and slices, channels must be created _before_ use. They use the `make` keyword:

```go
ch := make(chan int)
```

## Send Data to a Channel

- The `<-` operator is called the _channel operator_.
- Data flows in the direction of the arrow.
- This operation will _block_ until another goroutine is ready to receive the value.

```go
ch <- 69
```

Empty structs are often used as `tokens` in Go programs. In this context, a token is a [unary](https://en.wikipedia.org/wiki/Unary_operation) value. In other words, we don't care _what_ is passed through the channel. We care _when_ and _if_ it is passed.

We can block and wait until _something_ is sent on a channel using the following syntax

This will block until it pops a single item off the channel, then continue, discarding the item.

```go
<-ch
```
## Receive Data from a Channel

- This reads and removes a value from the channel and saves it into the variable `v`.
- This operation will _block_ until there is a value in the channel to be read.

```go
v := <-ch
```
