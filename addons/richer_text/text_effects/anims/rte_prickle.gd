@tool
extends RTxtEffect
## Fades characters in more randomly.
## You should set 'fade_speed' to a low value for this to look right. 

## Syntax: [prickle pow=2][]
var bbcode = "prickle"

func _update() -> bool:
	var power := get_float(&"pow", 2.0)
	var a := delta
	a = clamp(a * 2.0 - rnd(), 0.0, 1.0)
	a = pow(a, power)
	alpha = a
	_send_transform_back()
	return true
