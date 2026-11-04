import sys
from pathlib import Path

from sloperator.runner import run_program, validate_program


def main(argv: list[str]) -> int:
    check_only = len(argv) == 3 and argv[1] == "--check"
    if len(argv) != (3 if check_only else 2):
        print("usage: uv run sloperator.py [--check] <file.slop>", file=sys.stderr)
        return 2

    path = Path(argv[2] if check_only else argv[1])
    try:
        source = path.read_text(encoding="utf-8")
    except OSError as error:
        print(f"could not read '{path}': {error.strerror}", file=sys.stderr)
        return 2

    error = validate_program(source) if check_only else run_program(source, sys.stdout)
    if error is not None:
        sys.stdout.flush()
        print(error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
