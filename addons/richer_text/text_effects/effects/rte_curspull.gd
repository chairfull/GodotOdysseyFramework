@tool
extends RTxtEffect
## Pulls or pushes characters away from the cursor.
## Use a negative number for reverse effect.

## Syntax: [curspull 1.0][]
const bbcode = "curspull"

func _update() -> bool:
	var pull := get_float("pull", 1.0)
	var dif := position - mouse
	var dis := dif.length()
	var nrm := dif.normalized() * -pull
	position += nrm * clampf(pow(dis * .1, 4.0), 0.1, 4.0)
	return true
