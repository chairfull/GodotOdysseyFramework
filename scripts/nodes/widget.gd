@abstract class_name Widget extends Control

signal closed(returned: Variant)

var player_index := 0
var _tween: Tween

## Is only one allowed.
func is_exclusive() -> bool: return true
## Will autohide when non-hud widgets are displayed.
func is_hud() -> bool: return false
## Will pause the game when displayed.
func is_pauser() -> bool: return false
## Will stay visible when a cinematic is playing. (Captions, Choice Menu...)
func is_visible_in_cinematic() -> bool: return false

func close(returned: Variant = null) -> void:
	get_controller().hide_widget(name, returned)

## Called by Controller.
func _closed(returned: Variant) -> void:
	closed.emit(returned)

func show_widget(id: StringName) -> Widget:
	return get_controller().show_widget(id)

func hide_widget(id: StringName) -> bool:
	return get_controller().hide_widget(id)

func show_transitioned() -> void:
	modulate.a = 0.0
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.tween_property(self, "modulate:a", 1.0, 0.25)
	_tween.tween_callback(func():
		_tween = null)

func close_transitioned() -> void:
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.tween_property(self, "modulate:a", 0.0, 0.125)
	_tween.tween_callback(close)

func get_pawn() -> Pawn:
	return get_controller()._pawn

func get_controller() -> PlayerController:
	return Controllers.get_controller(player_index)

## Used by FlowPlayerGenerator to create keyframes.
func _cinematic_step(_gen: FlowPlayerGenerator, _step: Dictionary) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass

func handle_input() -> void:
	get_controller().viewport.set_input_as_handled()
