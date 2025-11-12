@tool
extends RTxtEffect
## Pulses it's scale and color every second.

## [beat][]
var bbcode := "beat"

func _update() -> bool:
	var cs := size * Vector2(0.5, -0.3)
	var speed := 2.0
	var pulse := pow(maxf(sin(time * speed), 0.0) * maxf(sin(time * 2.0 * speed), 0.0), 4.0)
	_char_fx.transform *= Transform2D.IDENTITY.translated(cs)
	_char_fx.transform *= Transform2D.IDENTITY.scaled(Vector2.ONE + Vector2(1.4, 0.8) * pulse)
	_char_fx.transform *= Transform2D.IDENTITY.translated(-cs)
	color = lerp(Color.WHITE, color, pulse * 2.)
	return true
