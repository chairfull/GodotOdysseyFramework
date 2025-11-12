@icon("res://addons/odyssey/icons/control.svg")
class_name PawnState extends Resource
## Optional states that are enabled/disabled when Pawn is:
## - Mounted/unmounted.
## - Posessed/unpossesed.
## - Rider mounted/rider unmounted.

var pawn: Pawn: set=set_pawn
var _enabled := false
var _controller: Controller

func set_pawn(p: Pawn) -> void:
	if pawn == p: return
	pawn = p

func _process(_delta: float) -> void: pass
func _physics_process(_delta: float) -> void: pass
func _unhandled_input(_event: InputEvent) -> void: pass

func is_action_pressed(action: StringName, allow_echo := false, exact_match := false) -> bool:
	return get_controller().is_action_pressed(action, allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false):
	return get_controller().is_action_released(action, exact_match)

func is_action_both(action: StringName, start: Callable, stop: Callable) -> bool:
	if is_action_pressed(action):
		if start.call():
			handle_input()
			return true
	elif is_action_released(action):
		if stop.call():
			handle_input()
			return true
	return false

func handle_input():
	pawn.get_viewport().set_input_as_handled()

func _accept_controller(_con: Controller) -> bool:
	return false

func _enable() -> void:
	pawn.enable_state(self)
	_enabled = true

func _disable() -> void:
	pawn.disable_state(self)
	_enabled = false

func get_controller() -> Controller: return _controller

func is_first_person() -> bool:
	return get_controller().view_state == Controller.ViewState.FirstPerson

func is_third_person() -> bool:
	return get_controller().view_state == Controller.ViewState.ThirdPerson
