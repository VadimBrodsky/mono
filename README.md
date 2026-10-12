# mono

Personal monorepo for learning, notes, side projects, and experiments.

## Layout

```text
learn/rust/         Rust learning exercises (Cargo workspace members)
learn/<lang>/       Other languages while learning
notes/              Markdown notes
projects/           Real side projects (empty for now)
```

## Rust

Cargo is the everyday CLI; Bazel builds the same crates.

```sh
cargo run -p hello-world         # run
cargo test --workspace           # test with Cargo
bazel run //learn/rust/hello-world
bazel test //...                 # test everything with Bazel
```

Add a new exercise with `cargo new learn/rust/<name>`, then copy
`learn/rust/hello-world/BUILD.bazel` next to its `Cargo.toml` and update the
`name` and `crate` fields. Add the new `Cargo.toml` to the `manifests` list
in `MODULE.bazel` if it has external dependencies.

If you add a dependency with `cargo add`, Bazel picks it up after `Cargo.lock`
changes.
