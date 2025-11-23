extends PanelContainer

signal finished()

@export var mono := false ## Only one can show at a time.
@export var v_align := VERTICAL_ALIGNMENT_TOP
@export var h_align := HORIZONTAL_ALIGNMENT_RIGHT
@export var data: Dictionary: set=set_data
var _tween: Tween

func _enter_tree() -> void:
	modulate.a = 0.0
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.tween_property(self, "modulate:a", 1.0, 0.5)
	_tween.tween_interval(2.0)
	_tween.tween_property(self, "modulate:a", 0.0, 0.2)
	_tween.tween_callback(finished.emit)

func set_data(d: Dictionary):
	data = d
	%label.text = data.get(&"text", "NO TEXT")
	%icon.texture = load(data.get(&"icon", "res://icon.svg"))
