@tool
extends RTxtEffect

## Syntax: [console][]
var bbcode = "console"

const SPACE := " "
const CURSOR := "█"
const CURSOR_COLOR := Color.GREEN_YELLOW

func _update() -> bool:
	var lbl := label
	
	if lbl.progress == 1.0:
		if lbl.visible_character-1 == absolute_index and sin(time * 16.0) > 0.0:
			chr = CURSOR
			color = CURSOR_COLOR
			offset = Vector2.ZERO
	
	else:
		if lbl.visible_character == absolute_index:
			if chr == SPACE:
				alpha = 0.0
			else:
				chr = CURSOR
				color = CURSOR_COLOR
				offset = Vector2.ZERO
		
		else:
			alpha *= delta
	
	_send_transform_back()
	return super()
