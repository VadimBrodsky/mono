# Cargo Watch

Mitigate the impact on productivity by reducing the perceived compilation time.

```shell
cargo install cargo-watch
```

Cargo watch monitors the source code to trigger commands every time a file is changed.

```shell
cargo watch -x check                  # will run a cargo check after every code change
cargo watch -x check -x test -x run   # run check then test then run if successfull
```
