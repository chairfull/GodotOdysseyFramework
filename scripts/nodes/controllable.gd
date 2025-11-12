class_name Controllable extends Node3D

@export var pawn: Pawn
var controller: Controller

func _ready() -> void:
	if pawn:
		pawn.controlled.connect(_controlled)
		pawn.uncontrolled.connect(_uncontrolled)
		print("Pawn connected...")
	else:
		push_warning("No pawn for %s." % self)

func is_controlled() -> bool:
	return controller != null

func _controlled(con: Controller) -> void:
	controller = con
	con.on_input.connect(_on_controller_input)
	con.on_update.connect(_on_controller_update)

func _uncontrolled(con: Controller) -> void:
	controller = null
	con.on_input.disconnect(_on_controller_input)
	con.on_update.disconnect(_on_controller_update)

func _on_controller_input(_event: InputEvent) -> void: pass
func _on_controller_update(_delta: float) -> void: pass

func is_action_pressed(action: StringName, allow_echo := false, exact_match := false) -> bool:
	return controller.is_action_pressed(action, allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false) -> bool:
	return controller.is_action_released(action, exact_match)

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

func handle_input() -> void:
	controller.get_viewport().set_input_as_handled()
