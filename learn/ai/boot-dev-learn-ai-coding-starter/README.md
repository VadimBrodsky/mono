# Sloperator

A tree-walking interpreter for [SlopLang](docs/spec.md), written in Python.

## Run

```bash
uv run sloperator.py examples/fib.slop
```

## Validation

```bash
uv run pytest              # tests
uv run ruff format --check # formatting
uv run ruff check          # linting
uv run ty check            # type checking
```

## Playground

```bash
uv run playground/server.py
```

Then open <http://localhost:8080>.

## Layout

- `sloperator.py` — command-line entrypoint
- `sloperator/` — lexer, parser, and evaluator
- `docs/spec.md` — SlopLang language specification
- `examples/` — example programs
- `tests/` — pytest suite
- `playground/` — web server and editor
