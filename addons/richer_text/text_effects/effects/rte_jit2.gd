@tool
extends RTxtEffect
## Makes words shake around.

## Syntax: [jit2 scale=1.0 freq=8.0][]
var bbcode = "jit2"

func _update() -> bool:
	var scale := get_float("scale", 1.0)
	var freq := get_float("freq", 16.0)
	var s := fmod((index + time) * PI * 1.25, TAU)
	var p := sin(time * freq + absolute_index) * .33
	offset.x += sin(s) * p * scale
	offset.y += cos(s) * p * scale
	return true
