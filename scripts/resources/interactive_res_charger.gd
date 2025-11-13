class_name InteractiveResCharger extends InteractiveRes

@export var charge_duration := 1.0
@export var discharge_duration := 1.0
var _charging := false
var _progress := 0.0
var _tween: Tween

func _interaction_pressed(inter: Interactive) -> void:
	if _charging: return
	_charging = true
	if _tween: _tween.kill()
	_tween = inter.create_tween()
	_tween.tween_property(self, "_progress", 1.0, remap(_progress, 0.0, 1.0, 0.0, charge_duration))
	_tween.tween_callback(func():
		_progress = 0.0
		_tween = null)

func _interaction_released(inter: Interactive) -> void:
	if _tween: _tween.kill()
	_tween = inter.create_tween()
	_tween.tween_property(self, "_progress", 0.0, remap(1.0 - _progress, 0.0, 1.0, 0.0, discharge_duration))
	_charging = false

func _process(_inter: Interactive, _delta: float) -> bool:
	return _progress >= 1.0
