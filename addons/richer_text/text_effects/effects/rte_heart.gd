@tool
extends RTxtEffect
## Hear beat jumping, and turning into a heart shape.

## Syntax: [heart scale=1.0 freq=8.0][]
var bbcode = "heart"

const TO_CHANGE := "oOaA"

func _update() -> bool:
	var scale := get_float("scale", 16.0)
	var freq := get_float("freq", 2.0)
	var x = index / scale - time * freq
	var t = abs(cos(x)) * max(0.0, smoothstep(0.712, 0.99, sin(x))) * 2.5;
	color = color.lerp(Color.BLUE.lerp(Color.RED, t), t)
	offset.y -= t * 4.0
	
	if offset.y < -1.0:
		if chr in TO_CHANGE and label.parser.emoji_font:
			var efont: Font = load(label.parser.emoji_font)
			if efont:
				font = efont.get_rids()[0]
				transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * 0.6)
				offset.y -= 6.0
				chr = "❤️"
			else:
				chr = "•"
	
	return true
