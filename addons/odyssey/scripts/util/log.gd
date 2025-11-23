class_name Log extends RefCounted

static func msg(head: String, ...args):
	_msg("[color=cyan][%s][/color]" % head, args)

static func warn(head: String, ...args):
	_msg("[color=yellow][b][%s][/b][/color]" % head, args)

static func err(head: String, ...args):
	_msg("[color=red][b][%s][/b][/color]" % head, args)

static func _msg(head: String, args: Array):
	var lines := [head]
	for item in args:
		if item is Array:
			var arg_lines := []
			var clrs := [Color.YELLOW.to_html(), Color.GOLD.to_html()]
			for i in item.size():
				arg_lines.append("[color=#%s]%s[/color]" % [clrs[0 if i % 2 == 0 else 1], item[i]])
			lines.append(", ".join(arg_lines))
		elif item is Dictionary:
			var keys := []
			for key in item:
				keys.append("%s:[color=yellow][i]%s[/i][/color]" % [key, item[key]])
			lines.append(" ".join(keys))
		else:
			lines.append("[color=%s]%s[/color]" % [Color.POWDER_BLUE.to_html(), item])
	print_rich(" ".join(lines))

static func grad(text: String, c1 := Color.DEEP_SKY_BLUE, c2 := Color.DEEP_PINK) -> void:
	var out := ""
	for i in text.length():
		var mixed := UColor.lerp_ok_hsl(c1, c2, i / float(text.length()))
		out += "[color=#%s]%s[/color]" % [mixed.to_html(), text[i]]
	print_rich(out)
