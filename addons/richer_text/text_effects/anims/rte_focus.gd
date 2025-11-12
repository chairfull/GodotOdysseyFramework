@tool
extends RTxtEffect

## Syntax: [focus color][]
var bbcode = "focus"

func _update() -> bool:
	var a := 1.0 - delta
	var scale := get_float(&"scale", 1.0)
	color.s = lerp(color.s, 0.0, a)
	color.a = lerp(color.a, 0.0, a)
	var r = hash(text[absolute_index]) * 33.33 + absolute_index * 4545.5454 * TAU
	offset += Vector2(cos(r), sin(r)) * label.size * scale * (a * a)
	_send_transform_back()
	return true
