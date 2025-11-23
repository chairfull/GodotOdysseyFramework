@tool
class_name Transition extends ColorRect

@export var fade_duration := 0.5
@export_range(0.0, 1.0, 0.01) var amount := 0.0: set=set_amount
var _tween: Tween

func set_amount(a: float):
	amount = a
	modulate.a = amount

func fade_out(duration := fade_duration) -> Signal:
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, ^"amount", 1.0, duration)\
		.set_trans(Tween.TRANS_SINE)
	return _tween.finished

func fade_in(duration := fade_duration) -> Signal:
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, ^"amount", 0.0, duration)\
		.set_trans(Tween.TRANS_SINE)
	return _tween.finished
