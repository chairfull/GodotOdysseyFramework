@tool
extends RefCounted

const Token := preload("twee_tokens.gd")
const Util := preload("../resources/twee_util.gd")

const default_tween_duration := 1.0 ## Default seconds to tween if a duration wasn't explicitly given.
const default_pause_duration := 1.0 ## Default seconds to wait if WAIT wasn't explicitly given.
const default_event_signal_or_method := &"event" ## Will attempt to pass "string" events to this.

static var all_props: PackedStringArray

static func parse(tokens: PackedStringArray) -> Array[Dictionary]:
	all_props.clear()
	var parsed := _parse(tokens)
	var steps: Array[Dictionary] = parsed[0]
	return steps

static func _parse(tokens: PackedStringArray, i := 0, expect_dedent := false) -> Array[Variant]:
	var commands: Array[Dictionary]
	while i < tokens.size():
		var t := tokens[i]
		
		# consume top-level newlines quickly
		if t == Token.NEWLINE or t == Token.SPACE:
			i += 1
			continue
			
		# End of block
		if t == Token.DEDENT:
			i += 1
			if expect_dedent:
				break
			continue
		
		if t == Token.LOOP:
			commands.append({ type=Token.LOOP, loop=0 })
			i += 1
			var args := []
			while i < tokens.size() and tokens[i] != Token.NEWLINE:
				args.append(tokens[i])
				i += 1
			if args:
				commands[-1].loop = int(args[0])
			continue
		
		# block-like keywords with optional args (block, parallel, choice, on)
		if t in [ Token.BLOCK, Token.PARALLEL, Token.PARALLEL_SHORT, Token.CHOICE, Token.ON, Token.FOR ]:
			var keyword := t
			if t == Token.PARALLEL_SHORT:
				keyword = Token.PARALLEL
			i += 1
			var args := []
			# collect tokens until colon (or we hit end)
			while i < tokens.size() and tokens[i] != Token.COLON:
				if tokens[i] != Token.NEWLINE:
					args.append(tokens[i])
				i += 1
			# skip colon if present
			if i < tokens.size() and tokens[i] == Token.COLON:
				i += 1
			# skip NEWLINEs after colon
			while i < tokens.size() and tokens[i] == Token.NEWLINE:
				i += 1
			# only parse nested block if there's an INDENT
			if i < tokens.size() and tokens[i] == Token.INDENT:
				i += 1
				var block := { type=keyword, args=args }
				var got := _parse(tokens, i, true)
				block.children = got[0]
				commands.append(block)
				i = got[1]
				continue
			# no INDENT -> treat as empty block/attribute container
			commands.append({ type=keyword, args=args, children=[] })
			continue
		
		# Pause.
		if t == Token.WAIT:
			commands.append({ type=Token.WAIT, wait=default_pause_duration })
			i += 1
			continue
		
		# Pause (lone float)
		if t.is_valid_float():
			commands.append({ type=Token.WAIT, wait=float(t) })
			i += 1
			continue
		
		# String event.
		if _is_wrapped(t):
			commands.append({ type=Token.STRING, value=_unwrap(t) })
			i += 1
			continue
		
		# Method call.
		if t.ends_with("("):
			i += 1
			var deep := 1
			var meth := t
			while i < tokens.size():
				meth += tokens[i]
				if tokens[i] == "(": deep += 1
				if tokens[i] == ")":
					deep -= 1
					if deep == 0:
						i += 1
						break
				i += 1
			commands.append({ type=Token.METH, meth=meth })
			continue
		
		# TODO: Warp
		if t == Token.WARP:
			i += 1
			if i < tokens.size():
				commands.append({ type=Token.WARP, expr=tokens[i] })
				i += 1
			continue
		
		# Tween step (mode + optional duration + props)
		if Util.is_trans_ease(t):
			var cmd := { type=Token.PROPERTIES_TWEENED, mode=t, duration=default_tween_duration, props={} }
			i += 1
			# optional duration
			if i < tokens.size() and tokens[i].is_valid_float():
				cmd.duration = float(tokens[i])
				i += 1
			# collect inline props first
			var got := _parse_props(tokens, i)
			cmd.props = got[0]
			i = got[1]
			# skip newlines after inline props
			while i < tokens.size() and tokens[i] == Token.NEWLINE:
				i += 1
			# if indented block follows, collect those as additional props
			if i < tokens.size() and tokens[i] == Token.INDENT:
				i += 1
				while i < tokens.size() and tokens[i] != Token.DEDENT:
					# skip newlines between indented prop lines
					while i < tokens.size() and tokens[i] == Token.NEWLINE:
						i += 1
					if i >= tokens.size() or tokens[i] == Token.DEDENT:
						break
					var token := tokens[i]
					if not _is_valid_property(token):
						i += 1
						continue
					# parse single prop (name + expression)
					var name := token.replace(".", ":")
					i += 1
					# collect expression tokens (copied from _parse_props for one prop)
					var expr_tokens: Array[String] = []
					var paren_level: Array = []
					while i < tokens.size():
						var v := tokens[i]
						if v == ".":
							expr_tokens.append(v)
							i += 1
							continue
						if v.ends_with("("):
							paren_level.append([expr_tokens.size(), 0])
						elif v == ")":
							if paren_level.size() > 0:
								var count = paren_level.pop_back()
								var start_index = count[0]
								if start_index < expr_tokens.size() and expr_tokens[start_index] == "(":
									var commas = count[1]
									match commas:
										0: pass
										1: expr_tokens[start_index] = "Vector2("
										2: expr_tokens[start_index] = "Vector3("
										3: expr_tokens[start_index] = "Color("
						elif v == ",":
							if paren_level.size() > 0:
								paren_level[paren_level.size() - 1][1] += 1
						elif paren_level.size() == 0 and (v in [Token.NEWLINE, Token.DEDENT, Token.COLON] or _is_valid_property(v)):
							break
						expr_tokens.append(v)
						i += 1
					# handle % node refs
					for j in expr_tokens.size():
						if expr_tokens[j].begins_with("%"):
							var parts: PackedStringArray = expr_tokens[j].split(".", true, 1)
							if parts.size() == 2:
								expr_tokens[j] = "node.get_node(\"%s\").%s" % [parts[0], parts[1]]
					var val := "".join(expr_tokens)
					if not name in all_props:
						all_props.append(name)
					cmd.props[name] = { "val": val }
			# DEDENT will be handled by the outer loop
			commands.append(cmd)
			continue

		# Standalone property line(s)
		# ensure token is a non-keyword identifier before calling _parse_props
		if _is_valid_property(t):
			var got := _parse_props(tokens, i)
			var cmd := { type=Token.PROPERTIES, props=got[0] }
			i = got[1]
			commands.append(cmd)
			continue
		# fallback: consume one token to avoid infinite loops
		i += 1
	return [commands, i]

static func _parse_props(tokens: PackedStringArray, i: int) -> Array:
	var props := {}

	while i < tokens.size():
		var token := tokens[i]

		# stop on structural tokens
		if token in [Token.PARALLEL, Token.PARALLEL_SHORT, Token.CHOICE, Token.BLOCK, Token.ON, Token.WARP, Token.INDENT, Token.DEDENT, Token.NEWLINE, Token.COLON, Token.LOOP]:
			break

		# property must be a valid identifier like "modulate" or "position.x"
		if not _is_valid_property(token):
			i += 1
			continue

		var prop := { val="" }
		var name := token.replace(".", ":")
		i += 1

		# collect expression tokens
		var expr_tokens := []
		var paren_level := []
		while i < tokens.size():
			var v := tokens[i]
			
			if v == ".":
				expr_tokens.append(v)
				i += 1
				continue
			
			if v.ends_with("("):
				paren_level.append([expr_tokens.size(), 0])
			elif v == ")":
				var count := paren_level.pop_back()
				var start_index: int = count[0]
				# Is not a function?
				if expr_tokens[start_index] == "(":
					var commas: int = count[1]
					match commas:
						0: pass
						1: expr_tokens[start_index] = "Vector2("
						2: expr_tokens[start_index] = "Vector3("
						3: expr_tokens[start_index] = "Color("
			elif v == ",":
				paren_level[-1][1] += 1
			
			# break if top-level property/structural token and no open parens
			elif paren_level.size() == 0 and (v in [Token.NEWLINE, Token.DEDENT, Token.COLON] or _is_valid_property(v)):
				break

			expr_tokens.append(v)
			i += 1

		if expr_tokens.size() > 0:
			for j in expr_tokens.size():
				if expr_tokens[j].begins_with("%"):
					var parts: PackedStringArray = expr_tokens[j].split(".", true, 1)
					expr_tokens[j] = "node.get_node(\"%s\").%s" % [parts[0], parts[1]]
			
			prop.val = "".join(expr_tokens)
		
		if not name in all_props:
			all_props.append(name)
		props[name] = prop

	return [props, i]

static func _is_wrapped(t: String, head := '"', tail := '"') -> bool:
	return t.begins_with(head) and t.ends_with(tail)

static func _is_valid_property(t: String) -> bool:
	if t.begins_with("%"): return true
	if "(" in t: return true
	if t != t.to_lower(): return false
	if "." in t: return t.replace(".", "_").is_valid_unicode_identifier()
	return t.is_valid_unicode_identifier()

static func _unwrap(s: String, head := '"', tail := '"') -> String:
	return s.trim_prefix(head).trim_suffix(tail)
