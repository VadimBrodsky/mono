# Bazel

## Essential Properties
- Incremental: only rebuild what changes
  - Requires: Applications structured as modular libraries without circular dependencies.
- Correct: trust your build results
  - Requires: Accurate build depends on the attention in setting the environment up from the beginning. 
  - Build correctness is hard to add later because it depends on having a complete and accurate dependency graph.
- Cacheable: Share build results across your team
  - Requires: Determinism, which means “given the same inputs, build tools write identical output” regardless of where they run.
  - As a side-effect, builds are isolated - each tool runs in its own temporary environment, which prevents problems like memory leaks.
- Parallel: Build faster with more CPUs
  - Requires: Hermeticity, this means that dependencies are known to the build system, including tools, environment variables, and third-party libraries.
- Reliable: Guarantee reproducible builds
  - Achieve bit-for-bit identical outputs every time you build. 
- Composable: Reuse and extend build rules
  - Bazel allows you to reuse existing build rules and create new ones by combining simpler ones.
  - Follows the Unix Philosophy of building small, focused components that work well together. 
  - The universal interface is files.
- Universal: Supports any language or framework
  - Plugins called rules, Bazel handles builds and tests for nearly every language and framework in your stack.
- Scalable: Proven in Google’s massive monorepo
  - Google’s engineers have stress-tested it across google3, a monorepo containing 2 billion source lines of code (as of 2015).


## Mental Modal
Build files next to sources --> dependency graph --> rules --> action graph --> spawn tools --> populate output tree.

### Bazel Input Requirements
1. Code descriptions
  - Provide a description of your code and its dependencies in BUILD files.
  - Can be largely automated.
  - Checked into version control.
2. Rule sets
  - Plugins called a rule set to teach it what to do with those descriptions you provided in the BUILD files.
  - These rules know how to fetch existing build tools like compilers or code generators.

### Bazel Build Output
- Bazel constructs a dependency graph.
- It uses that to create a lazy transformation from your source tree to a bazel-out/ folder containing the requested build outputs. 
- Test results are modeled as outputs too. 
- The output folder is then continually updated as the sources are changed, by doing as little work as possible.


## Bazel Repository
- A Bazel repository is a directory tree containing source files that can be used in a Bazel build. 
- The repository is identified by boundary marker files at its root, such as the REPO.bazel and MODULE.bazel.
- Bazel always puts the files it creates outside the source tree in temporary folders. Use the bazel info command to see where Bazel stores temporary files. 
- For convenience, Bazel creates symbolic links from the repository root to certain common temporary folders.
  - bazel-out → $(bazel info execution_root)/bazel-out
  - bazel-bin → bazel-out/[most recent target platform]/bin
  - bazel-testlogs → $(bazel info bazel-testlogs)
