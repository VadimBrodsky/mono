# Linting

Static analysis that helps to spot unidiomatic code, overly-complex constructs and common mistakes and inefficiencies.

The Rust team maintains `clippy`, the official Rust linter.

```shell
rustup component add clippy
```

To run clippy

```shell
cargo clippy
cargo clippy -- -D warning # in CI

```

To mute a warning use the `#[allow(clippy::lint_name)]` attribute on the affected code block to disable the noisy lint.
