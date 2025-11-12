@tool
extends RTxtEffect
## Fades words in one at a time.

## Syntax: [fader][/fader]
var bbcode := "fader"

func _update() -> bool:
	alpha *= delta
	_send_transform_back()
	return true
