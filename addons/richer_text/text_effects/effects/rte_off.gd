@tool
extends RTxtEffect
## Offsets characters by an amount.

## Syntax: [off][]
var bbcode = "off"

func to_float(s: String):
	if s.begins_with("."):
		return ("0" + s).to_float()
	return s.to_float()

func _update() -> bool:
	var off := get_var(&"off", Vector2.ZERO)
	match typeof(off):
		TYPE_FLOAT, TYPE_INT: offset.y += off
		TYPE_VECTOR2: offset += off
		TYPE_ARRAY: offset += Vector2(off[0], off[1])
	return true
