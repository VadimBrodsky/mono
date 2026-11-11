from sloperator.runner import run_source


def test_unary_minus_rejects_boolean_values():
    result = run_source("hallucinate(-✅)✨")

    assert result.exit_code == 1
    assert result.stdout == ""
    assert result.stderr == (
        "SlopLang runtime error at line 1: operand of unary '-' must be a number, got boolean\n"
    )


def test_unary_minus_accepts_numbers():
    result = run_source("hallucinate(-1)✨")

    assert result.exit_code == 0
    assert result.stdout == "-1\n"
    assert result.stderr == ""


def test_unary_not_flips_boolean_values_and_can_be_repeated():
    result = run_source("hallucinate(!✅, !❌, !!✅)✨")

    assert result.exit_code == 0
    assert result.stdout == "❌ ✅ ✅\n"
    assert result.stderr == ""


def test_unary_not_rejects_numbers_and_strings():
    for operand, type_name in (("42", "number"), ("“text”", "string")):
        result = run_source(f"hallucinate(!{operand})✨")

        assert result.exit_code == 1
        assert result.stdout == ""
        assert result.stderr == (
            "SlopLang runtime error at line 1: operand of unary '!' must be a boolean, "
            f"got {type_name}\n"
        )
