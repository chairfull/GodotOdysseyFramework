@tool
extends RTxtEffect
## Fades words in one at a time.

## Syntax: [cfac][]
var bbcode = "fromcursor"

func _update() -> bool:
	# Send position back early so ctc isn't weird.
	_send_transform_back()
	alpha *= delta
	position = mouse.lerp(position, pow(delta, 0.25))
	return true
