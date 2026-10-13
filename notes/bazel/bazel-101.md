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

## Standard Bazel files

- `MODULE.bazel`: allows this repository to participate in Bazel’s plugin dependency system (called “bzlmod”), either by publishing a module, or declaring dependencies on existing ones.
- `REPO.bazel`: is used to specify some common attributes for all build targets inside the repository.
- `.bazelversion`: indicates what version of Bazel should be used. It typically contains the exact version, to ensure identical results between developers and the CI system. However it’s also possible to use “floating” versions like latest.
- `.bazelrc`: stores persistent settings.
- `.bazeliskrc`: is a less commonly-used configuration for Bazelisk, the version-aware wrapper we installed.

## Bazel module

- A module is defined as a project that can have multiple versions, each publishing metadata about its dependencies.
- A Bazel module defines the root of a Bazel workspace and is identified by the presence of a `MODULE.bazel` file. Like `package.json` in JS.
- Some tools still rely on the older `WORKSPACE` or `WORKSPACE.bazel` file to appear in the workspace root. As a workaround, leave an empty file at this path with a comment explaining why it still exists.
- Central registry of third-party modules that extend Bazel - https://registry.bazel.build.
- Nested modules are possible but discouraged.

```starlark
# MODULE.bazel
# rules for shell scripts
bazel_dep(name = "rules_shell", version = "0.3.0")
```
```
```

## CLI flags

- Flags are passed to Bazel commands like command-line program, using double hyphens.
- To distinguish flags passed to Bazel itself and argument passed to a program Bazel runs, or to exclude a target from a target pattern, use a bare `--` to separate them.
- Some flags have a single-letter short form using a single hyphen.
- Boolean flags can be negated by adding `no` as a prefix.

```shell
bazel build --jobs=10 my_target

bazel run --stamp //my:target -- --some_argument  # argument to bazel
bazel build -- //app:all -// app::not-this-one    # exclude not-this-one

bazel build --compilation_mode opt                # long form
bazel build -c opt                                # short form

# enable the flag
bazel build --experimental_merged_skyframe_analysis_extension
# disable the flag
bazel build --noexperimental_merged_skyframe_analysis_extension
```

## Flags in bazelrc
- Flags are stored in Unix-style RC files so you don’t have to remember and type them repeatedly.
- Set system-wide defaults in /etc/bazel.bazelrc.
- Share team configurations in .bazelrc at the repository root.
- Define personal preferences in $HOME/.bazelrc, these preferences apply to all your Bazel repositories.
- Define personal, project-specific preferences in a user.bazelrc file at the repository root.
- Flags can be grouped into named configurations and enabled using the —config flag
- In a real project its recommended that the bazelrc file imports several rc files files for convenience: https://github.com/bazel-contrib/bazelrc-preset.bzl

```
# .bazelrc
build --some_build_flag=1  # applies only to bazel build
test --some_test_flag=on   # applies only to bazel test

common --other_flag=yes    # applies to any command

# create named configurations
# applies only when --config=ci is set
common:ci --this_flag=only-on-CI

import %workspace%/tools/preset.bazelrc
# ... Project Specific flags override presets
# ... finally the user can override anything above
try-import %workspace%/user.bazelrc
```
```
```

