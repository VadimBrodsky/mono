---
name: create-test-program
description: Create a SlopLang example for a language feature and verify its exact output
---

# Create a Test Program

Given a SlopLang language feature, create an example program and an exact-output regression test for it.

## Workflow

1. Read `docs/spec.md` before writing code. Treat it as the source of truth for syntax and behavior. If the requested feature is not specified there, do not invent semantics; explain the gap and ask what to do.
2. Inspect `examples/` and `tests/test_example_outputs.py` (if it exists) to follow the repository's naming and testing conventions. Choose a concise, descriptive `.slop` filename under `examples/`.
3. Write a small, self-contained program that demonstrates the requested feature. Keep it focused, valid SlopLang, and ensure it prints meaningful output using `hallucinate`.
4. Run the program with `uv run sloperator.py examples/<filename>.slop` and use its observed stdout to confirm the expected output. Resolve any errors before writing the test.
5. Add a test in `tests/test_example_outputs.py` that executes the example through the project's runner and asserts exact stdout, including newlines, plus a successful exit code and empty stderr. Follow existing test conventions; do not weaken or alter unrelated tests. If the test file does not exist, create it using the project's test patterns.
6. Run `uv run pytest tests/test_example_outputs.py` and report the created paths and validation result.

## Exact-output test expectations

- Compare the complete stdout string, not a substring or normalized output.
- Assert `exit_code == 0` and `stderr == ""` as well as the exact stdout.
- Read the example as UTF-8 and use a path relative to the repository/test file, consistent with nearby tests.
