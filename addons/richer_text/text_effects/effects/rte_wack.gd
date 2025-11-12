@tool
extends RTxtEffect
## Wacky random animations.
## Randomly scales and rotates characters.

var bbcode := "wack"

func _update() -> bool:
	var cs := size * Vector2(0.5, -0.3)
	var r := rnd()
	transform *= Transform2D.IDENTITY.translated(cs)
	transform *= Transform2D.IDENTITY.rotated((cos(index + time) + sin(r + time * 3.0)) * .125)
	transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * (1.0 + cos(r * .5 + index * 3.0 + time * 1.3) * .125))
	transform *= Transform2D.IDENTITY.translated(-cs)
	return true
