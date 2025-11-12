# Makes words shake around.
@tool
extends RTxtEffect

# Syntax: [jit scale=1.0 freq=8.0][]
var bbcode = "jit"

const SPLITTERS := " .!?,-"

var _word := 0.0
var _last := ""
var _offset := 0

func _update() -> bool:
	if index == 0:
		_word = 0
		_offset = absolute_index
	
	var scale := get_float("scale", 2.0)
	var freq := get_float("jit", 1.0)
	
	if text[absolute_index] in SPLITTERS or _last in SPLITTERS:
		_word += PI * .33
	
	var s := fmod((_word + time + _offset) * PI * 1.25, TAU)
	var p := sin(time * freq * 16.0) * .5
	offset.x += sin(s) * p * scale
	offset.y += cos(s) * p * scale
	_last = text[absolute_index]
	return true
