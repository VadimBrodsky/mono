from sloperator.runner import run_source


def test_adding_empty_string_to_left_returns_original_string():
    result = run_source("hallucinate(“” + “slop”)✨")

    assert result.exit_code == 0
    assert result.stdout == "slop\n"
    assert result.stderr == ""


def test_adding_empty_string_to_right_returns_original_string():
    result = run_source("hallucinate(“slop” + “”)✨")

    assert result.exit_code == 0
    assert result.stdout == "slop\n"
    assert result.stderr == ""


def test_string_addition_supports_unicode_and_emoji():
    result = run_source("hallucinate(“café” + “✨”)✨")

    assert result.exit_code == 0
    assert result.stdout == "café✨\n"
    assert result.stderr == ""
