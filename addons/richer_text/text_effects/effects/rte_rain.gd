@tool
extends RTxtEffect

## Syntax: [rain][]
var bbcode = "rain"

func _update() -> bool:
	var r = fmod(cos(rnd_time() * .125 + sin(index * .5 + time * .6) * .25) + time * .5, 1.0)
	offset.y += (r - .25) * 8.0
	alpha = lerp(alpha, 0.0, r)
	return true
