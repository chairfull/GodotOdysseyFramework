@tool
extends RTxtEffect
## Bounces text in.

## Syntax: [back scale=8.0][]
var bbcode = "back"

func _process_custom_fx(c: CharFXTransform):
	var a := 1.0 - delta
	var scale := get_float(&"scale", 1.0)
	offset.y += ease_back(a) * font_size * scale
	alpha *= (1.0 - a)
	_send_transform_back()
	return true
