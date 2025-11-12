@tool
extends RTxtEffect

## Syntax: [redact freq wave][]
var bbcode = "redact"

const SPACE := " "
const BLOCK := "█"
const MID_BLOCK := "▓"

func _update() -> bool:
	var a := delta
	if a == 0 and (chr != SPACE or index % 2 == 0):
		#var freq := get_float("freq", 1.0)
		#var scale := get_float("scale", 1.0)
		chr = "X"
		color = Color.BLACK
	_send_transform_back()
	return true
