from sloperator.lexer import TokenType, tokenize


def test_string_escapes_preserve_escaped_closing_quote_and_backslash():
    tokens = tokenize(r"“before\”after\\end”")

    assert [token.type for token in tokens] == [TokenType.STRING, TokenType.EOF]
    assert tokens[0].literal == "before”after\\end"
