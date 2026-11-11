# Agent notes

- Requires Python 3.13+; use `uv run` so commands run in the locked project environment (`uv.lock`).
- CLI entrypoint is `sloperator.py`; interpreter flow is `sloperator/runner.py` → lexer → parser/AST → evaluator. Language behavior is specified in `docs/spec.md`.
- Run checks from the repo root: `uv run pytest`, `uv run ruff format --check`, `uv run ruff check`, `uv run ty check`. For a focused test: `uv run pytest tests/test_parser.py` (replace with the relevant test file).
- Run a SlopLang example with `uv run sloperator.py examples/fib.slop`; `--check <file.slop>` validates syntax without evaluating. Playground: `uv run playground/server.py` (serves on port 8080).
- Pytest discovers tests only under `tests/` and adds the repo root to its import path; CLI tests invoke the interpreter as a subprocess.
