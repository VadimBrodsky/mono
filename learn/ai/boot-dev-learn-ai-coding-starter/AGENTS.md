# Agent notes

## Project layout

- `sloperator.py`: CLI entry point.
- `sloperator/`: interpreter implementation; execution flows through the runner, lexer, parser/AST, and evaluator.
- `tests/`: automated tests.
- `docs/spec.md`: SlopLang language behavior.

## Validation

Run all four checks from the repository root with `uv`:

- `uv run pytest`
- `uv run ruff format --check`
- `uv run ruff check`
- `uv run ty check`

The project requires Python 3.13+; `uv run` uses the locked environment in `uv.lock`.

## Regression tests

Add a regression test when fixing a bug or changing behavior, so the affected behavior remains covered. Put tests under `tests/`.

Run comparison regression tests with `uv run pytest tests/test_comparisons.py`.

## Language behavior

Use [`docs/spec.md`](docs/spec.md) as the source of truth for SlopLang behavior.
