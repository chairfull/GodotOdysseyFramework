@tool
extends RTxtEffect
## Characters fall in one at a time.

## Syntax: [fallin][]
var bbcode = "fallin"

func _update() -> bool:
	var delta: float = ease_back_out(delta)
	alpha *= delta
	var cs := size * Vector2(0.5, -0.25)
	transform *= Transform2D.IDENTITY.translated(cs)
	transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * (1.0 + (1.0 - delta) * 2.0))
	transform *= Transform2D.IDENTITY.translated(-cs)
	_send_transform_back()
	return true
