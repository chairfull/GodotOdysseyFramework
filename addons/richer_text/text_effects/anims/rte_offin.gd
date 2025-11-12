@tool
extends RTxtEffect
## Characters are offset into place.

## Syntax: [offin][]
var bbcode = "offin"

func _update() -> bool:
	alpha *= delta
	offset.x = -size.x * (1.0 - delta)
	_send_transform_back()
	return true
