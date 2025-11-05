class_name TweeLexer extends RefCounted

const Token := preload("twee_tokens.gd")

var tokens: PackedStringArray
var i := 0

func _init(_tokens):
	tokens = _tokens

func peek(offset := 0) -> String:
	return tokens[i + offset] if (i + offset < tokens.size()) else ""

func eof() -> bool:
	return i >= tokens.size()

func advance() -> void:
	i += 1

func skip(what: Array) -> void:
	while not eof() and peek() in what:
		advance()

func expect(tok: String) -> void:
	if eof() or peek() != tok:
		_error("Expected '%s', got '%s'" % [tok, peek()])
	advance()

func accept(tok: String) -> bool:
	if not eof() and peek() == tok:
		advance()
		return true
	return false

func expect_end() -> void:
	if not eof() and peek() not in [Token.NEWLINE, Token.DEDENT, Token.COLON]:
		_error("Expected end of statement, got %s" % peek())

func _error(msg: String) -> void:
	push_error("[ParseError @ %d] %s" % [i, msg])
