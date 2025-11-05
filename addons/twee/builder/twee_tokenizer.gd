extends RefCounted

const Token := preload("twee_tokens.gd")

static func tokenize(src: String) -> PackedStringArray:
	src = src.replace("!", "signal_args.")
	
	var tokens := PackedStringArray()
	var lines := src.split("\n", false)
	var indent_stack := [0]
	for line in lines:
		if line.strip_edges().is_empty():
			continue
		var stripped := line.lstrip("\t")
		var indent := line.length() - stripped.length()
		if indent > indent_stack[-1]:
			indent_stack.append(indent)
			tokens.append(Token.INDENT)
		elif indent < indent_stack[-1]:
			while indent < indent_stack[-1]:
				indent_stack.pop_back()
				tokens.append(Token.DEDENT)
		var REGEX := RegEx.create_from_string(
	r'("[^"]*"|\d+\.\d+|\d+|![a-zA-Z_]\w*(?:\(\))?|(?:[@^~%]?[a-zA-Z_]\w*)(?:\.[a-zA-Z_]\w*)*\(?|[@^()+\-*/%:,.])'
)
		var i := 0
		while i < stripped.length():
			var m := REGEX.search(stripped, i)
			if m == null: break
			tokens.append(m.get_string())
			i = m.get_end()
		tokens.append(Token.NEWLINE)
	while indent_stack.size() > 1:
		indent_stack.pop_back()
		tokens.append(Token.DEDENT)
	return tokens
