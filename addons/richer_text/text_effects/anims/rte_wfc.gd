@tool
extends RTxtEffect
## Simulates a "Wave Function Collapse" for each character.

## Syntax: [wfc][]
var bbcode = "wfc"

const SPACE := " "
const SYMBOLS := "10"

func _update() -> bool:
	var a := delta
	var aa := a + rnd() * a
	if aa < 1.0 and chr != SPACE:
		chr = SYMBOLS[rnd_time(8.0) * len(SYMBOLS)]
		color.v -= .5
	alpha = a
	_send_transform_back()
	return true
