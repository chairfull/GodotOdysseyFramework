class_name Controllable extends Node3D

signal control_started()
signal control_ended()
signal mount_started()
signal mount_ended()

var controller: Controller: set=set_controller

var controller_player: ControllerPlayer:
	get: return controller

@export var player: bool: ## The main controllable of the main controller.
	get: return is_controlled() and controller == Controllers.player
	set(c):
		if c:
			take_control.call_deferred()
		elif is_controlled():
			Controllers.player.controllable = null

func _init() -> void:
	add_to_group(&"Controllable")

## In multiplayer there may be multiple ControllerPlayers.
func is_player_controlled() -> bool:
	return controller is ControllerPlayer

func set_controller(c: Controller):
	if controller:
		_control_ended(controller)
		control_ended.emit()
	controller = c
	if controller:
		_control_started(controller)
		control_started.emit()

func take_control(c: Controller = null):
	(c if c else Controllers.player).controllable = self

func _control_started(_con: Controller):
	print("[%s controls %s]" % [controller.name, name])
	pass

func _control_ended(_con: Controller):
	pass

func _mount_started():
	mount_started.emit()

func _mount_ended():
	mount_ended.emit()

func is_controlled() -> bool:
	return controller != null
