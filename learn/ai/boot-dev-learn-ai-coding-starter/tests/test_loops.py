from sloperator.runner import run_source


def test_false_condition_loop_does_not_run():
    result = run_source("ralph ❌ {\n    hallucinate(“never”)✨\n}\n")

    assert result.stdout == ""
    assert result.stderr == ""
    assert result.exit_code == 0
