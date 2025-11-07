@tool
class_name FlowScriptParser extends RefCounted

const TYPES := [FlowToken.CMND, FlowToken.FLOW, FlowToken.FUNC, FlowToken.KEYV, FlowToken.NUMB, FlowToken.PROP, FlowToken.TEXT]

static var REGEX_FUNCTION: RegEx

static func pprint(d: Dictionary):
	print(JSON.stringify(d, "\t", false))

static func parse(str: String, dbg_file := "") -> Dictionary:
	REGEX_FUNCTION = RegEx.create_from_string(r"^[@%^]?[A-Za-z_][A-Za-z0-9_]*\(.*\)$")
	
	var out: Dictionary
	var root := {}
	var stack := [root]
	stack.resize(20)
	var lines := str.split("\n")
	var i := 0
	while i < lines.size():
		var deep := 0
		var line := lines[i]
		while deep < line.length() and line[deep] == "\t":
			deep += 1
		var comment := line.rfind("# ")
		var stripped := line.substr(deep, comment).strip_edges()
		if stripped:
			var info := _str_to_step(stripped, dbg_file, i)
			if "_greedy" in info:
				var j := i+1
				var subkey: String = "val" if info.type == FlowToken.KEYV else "rest"
				while j < lines.size():
					var deep2 := 0
					var line2 := lines[j]
					while deep2 < line2.length() and line2[deep2] == "\t":
						deep2 += 1
					if deep2 <= deep: break
					var comment2 := line2.rfind("# ")
					var stripped2 := line2.substr(deep+1, comment2).strip_edges(false)
					info[subkey] += stripped2 + "\n"
					j += 1
				info[subkey] = info[subkey].trim_suffix("\n")
				info.erase("_greedy")
				i = j
			if not "tabbed" in stack[deep]:
				var tabbed: Array[Dictionary]
				stack[deep].tabbed = tabbed
			stack[deep].tabbed.append(info)
			stack[deep+1] = info
		i += 1
	return root

# TODO: Error handling which outputs dbg_file and dbg_line.
static func _str_to_step(str: String, dbg_file: String, dbg_line: int) -> Dictionary:
	var step: Dictionary
	var parts := str.split(" ", true, 1)
	if parts.size() == 1: parts.append("")
	
	# Functions: func_name(true, "false)
	# Can start with @ for nodes, % for unique named, and ^ for when dealing with children, in loops.
	if REGEX_FUNCTION.search(str):
		step.type = FlowToken.FUNC
		step.func = str
	# Numbers: "1.0"
	elif str.is_valid_float():
		step.type = FlowToken.NUMB
		step.numb = str
	# Flow: "=== flow_id"
	elif parts[0] == "===":
		step.type = FlowToken.FLOW
		step.flow = parts[1].strip_edges()
	# Command: "COMMAND rest"
	elif parts[0] == parts[0].to_upper():
		step.type = FlowToken.CMND
		step.cmnd = parts[0]
		step.rest = parts[1]
		if step.cmnd.ends_with(":"):
			step.cmnd = step.cmnd.trim_suffix(":")
			step._greedy = true
	# Key val: "key: val"
	elif parts[0].ends_with(":"):
		step.type = FlowToken.KEYV
		step.key = parts[0].trim_suffix(":")
		step.val = parts[1]
		if not step.val:
			step._greedy = true
	# New line: ""
	elif parts[0] == "/":
		step.type = FlowToken.TEXT
		step.text = ""
	# Speakerless text: ":Text without a speaker."
	elif parts[0].begins_with(":"):
		step.type = FlowToken.TEXT
		step.text = str.trim_prefix(":")
	# Properties: "position (1, 2)"
	elif parts[0] == parts[0].to_lower():
		step.type = FlowToken.PROP
		step.prop = {}
		var tokens := get_space_seperated_tokens(str)
		var i := 0
		while i < tokens.size():
			step.prop[tokens[i]] = tokens[i+1]
			i += 2
	# Text: "speaker with or without speach."
	else:
		step.type = FlowToken.TEXT
		step.text = str
	step.dbg = "%s:%s" % [dbg_file, dbg_line]
	return step

static func get_kwargs_from_space_seperated_tokens(line: String, args: Array[String], kwargs: Dictionary[StringName, String]):
	for token in get_space_seperated_tokens(line):
		if ":" in token:
			var key_val := token.split(":", true, 1)
			kwargs[StringName(key_val[0])] = key_val[1]
		else:
			args.append(token)

static func get_space_seperated_tokens(line: String) -> PackedStringArray:
	var tokens: PackedStringArray
	var buf := ""
	var brackets := []
	var i := 0
	while i < line.length():
		var c := line[i]
		if c in "({[\"":
			brackets.append(c)
			buf += c
		elif c in ")}]":
			buf += c
			if brackets: brackets.pop_back()
		elif c == "\"" and (not brackets or brackets[-1] != "\""):
			brackets.append(c)
			buf += c
		elif c == "\"" and brackets and brackets[-1] == "\"":
			brackets.pop_back()
			buf += c
		elif c == " " and not brackets:
			if buf:
				tokens.append(buf)
				buf = ""
		else:
			buf += c
		i += 1
	if buf:
		tokens.append(buf)
	return tokens

const TEST_FLOW_SCRIPT := """
# Comment
speaker: Caption for speaker. # Right side comment.
Speakerless text. Begins with a capital.
:SPEAKERLESS TEXT BEGINNING WITH A COLON. # For when there is yelling.

SHOW paul left
MOVE paul right

CODE:
	if score > 20:
		reset()
		if archer.has_item():
			print("Has item.")
	
	else:
		print("Score too low.")

SCREEN shout
	TEXT
		Once upon a time there was a king
		Text on second line.
		/
		Text after a break.

IF score > 20
	We have a high score.
ELSE
	Low score.

MENU talk
	Menu text.
	Go westward
		JUMP west
	Go east
		JUMP east

ON signal ENABLED true KEY one two three
	modulate Color.RED position (100, 200)

EASE 1.0 position (0, 1) modulate Color.BLUE
1.0
function_call(true, "false")

# Quest Stuff
name "The Final Quest"
desc: Return to the final quest
ON entered_zone WHO player ZONE main_base
	Player entered the main base
	player: Here I am, in the base!
	
=== subflow
	This is a subflow.

"""
