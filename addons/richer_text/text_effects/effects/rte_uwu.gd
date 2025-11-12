@tool
extends RTxtEffect
## Makes text cuter.
## "R" & "L" become "W" -> Royal Rumble = Woyaw Wumbwe.
## Ideally a monospaced font should be used.

## Syntax: [uwu][]
var bbcode = "uwu"

func _update() -> bool:
	match chr:
		"r", "l": chr = "w"
		"R", "L": chr = "W"
	return true
