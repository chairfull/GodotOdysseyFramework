class_name URichText extends RefCounted
## Various RichText helpers.

## For use with print_rich.
static func to_rich_string(value: Variant, indent := "\t") -> String:
	return _pretty(value, indent)

static func _pretty(value: Variant, indent_str: String, indent := 0) -> String:
	var out := ""
	var prefix := indent_str.repeat(indent)
	match typeof(value):
		TYPE_OBJECT:
			out += "Object(%s)\n" % [wrap_color((value as Object).get_instance_id(), Color.PURPLE)]
		TYPE_DICTIONARY:
			out += prefix + "\n"
			for key in value.keys():
				out += prefix + wrap_color("[i]%s[/i]" % key, Color.WHITE) + ": " + _pretty(value[key], indent_str, indent + 1)
		TYPE_ARRAY:
			out += prefix + "\n"
			for item in value:
				out += prefix + "- " + _pretty(item, indent_str, indent + 1)
		TYPE_BOOL, TYPE_NIL, TYPE_INT, TYPE_FLOAT:
			out += wrap_color(value) + "\n"
		TYPE_STRING:
			out += wrap_color('"' + value + '"') + "\n"
		TYPE_VECTOR2, TYPE_VECTOR2I:
			out += "Vector(%s, %s)\n" % [wrap_color(value.x), wrap_color(value.y)]
		TYPE_VECTOR3, TYPE_VECTOR3I:
			out += "Vector(%s, %s)\n" % [wrap_color(value.x), wrap_color(value.y), wrap_color(value.z)]
		TYPE_COLOR:
			out += "Color(%s)\n" % [wrap_color("#" + (value as Color).to_html(), value)]
		_:
			out += str(value) + "\n"
	return out

static func wrap_color(text: Variant, color: Variant = null) -> String:
	if color == null:
		match typeof(text):
			TYPE_STRING: color = Color.ORANGE
			TYPE_BOOL, TYPE_NIL: color = Color.TOMATO#EditorInterface.get_editor_settings().get_setting("color")
			TYPE_FLOAT, TYPE_INT: color = Color.CYAN#EditorInterface.get_editor_settings().get_setting("text_editor/theme/highlighting/number_color")
			_: color = Color.WHITE
	return "[color=#%s]%s[/color]" % [color.to_html(), text]
