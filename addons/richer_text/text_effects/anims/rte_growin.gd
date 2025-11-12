@tool
extends RTxtEffect
## Grows characters in one at a time.

## Syntax: [growin][]
var bbcode = "growin"

func _update() -> bool:
	var d := ease_back_out(delta, 2.0)
	alpha *= d
	var cs := size * Vector2(0.5, -0.25)
	transform *= Transform2D.IDENTITY.translated(cs)
	transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * d)
	transform *= Transform2D.IDENTITY.translated(-cs)
	_send_transform_back()
	return true
