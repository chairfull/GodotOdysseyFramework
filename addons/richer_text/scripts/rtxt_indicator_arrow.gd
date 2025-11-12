@tool
class_name RTxtIndicatorArrow extends Control

## Where the indicator will align itself.
enum IndicatorAlignment {
	CharTop,	## Top of last character.
	CharCenter,	## Center of last character.
	CharBottom,	## Bottom of last character.
	LineBottom,	## Bottom of last visible line.
	LineRight,	## x=Right edge of bounding box, y=last visible line.
}

@export var label: RicherTextLabel: set=set_label
@export var offset := Vector2.ZERO ## Ideally it's better to use a node child, but this is for convenience.
@export var alignment := IndicatorAlignment.CharCenter
@export var show_on_finished := true ## Show the indicator even after animation is finished.
var animator: RTxtAnimator:
	get: return label.get_animator()

func set_label(l):
	label = l
	if label:
		var anim := label.get_animator()
		anim.reseted.connect(_hide)
		anim.started.connect(_hide)
		anim.paused.connect(_show)
		anim.finished.connect(_finished)
		anim.indicator_moved.connect(_indicator_moved)
	
func _finished() -> void:
	if show_on_finished:
		_show()

func _show() -> void:
	modulate.a = 1.0

func _hide() -> void:
	modulate.a = 0.0

func _indicator_moved(trans: Transform2D) -> void:
	var pos := Vector2.ZERO
	match alignment:
		IndicatorAlignment.CharTop:
			pos = trans.origin
			pos.y -= label.font_size
		IndicatorAlignment.CharCenter:
			pos = trans.origin
			pos.y -= label.font_size * .5
		IndicatorAlignment.CharBottom:
			pos = trans.origin
		IndicatorAlignment.LineBottom:
			pos = trans.origin
			pos.x = label.size.x * .5
		IndicatorAlignment.LineRight:
			pos = trans.origin
			pos.x = label.size.x
			pos.y -= label.font_size * .5
	pos += offset
	pos += label.global_position
	global_position = pos
