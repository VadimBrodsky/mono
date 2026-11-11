from sloperator.lexer import tokenize
from sloperator.parser import parse
from sloperator.parser.ast import Call, ExprStmt, Literal, Variable


def test_call_can_be_used_as_an_argument_to_another_call():
    (statement,) = parse(tokenize("hallucinate(add(1, 2))✨"))

    assert isinstance(statement, ExprStmt)
    outer_call = statement.expression
    assert isinstance(outer_call, Call)
    assert len(outer_call.arguments) == 1

    inner_call = outer_call.arguments[0]
    assert isinstance(inner_call, Call)
    assert isinstance(inner_call.callee, Variable)
    assert inner_call.callee.name.lexeme == "add"
    assert [
        argument.value for argument in inner_call.arguments if isinstance(argument, Literal)
    ] == [1, 2]
