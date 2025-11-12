@tool
extends RTxtEffect
## Invisible unless cursor is near it.

## Syntax: [secret][]
const bbcode = "secret"

func _update() -> bool:
	var dif := transform.origin - mouse
	var dis := dif.length()
	alpha = clampf(8.0 - (dis / 8.0), 0.0, 1.0)
	return true
