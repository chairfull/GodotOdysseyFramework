class_name Controllable extends Node3D

signal control_started()
signal control_ended()
signal mount_started()
signal mount_ended()

var controller: Controller: get=get_controller
var controller_player: ControllerPlayer:
	get: return get_controller()

@export var player: bool: ## The main controllable of the main controller.
	get: return is_controlled() and get_controller() == Controllers.player
	set(c):
		if c:
			take_control.call_deferred()
		elif is_controlled():
			Controllers.player.controllable = null

func _init() -> void:
	add_to_group(&"Controllable")

func is_player_controlled() -> bool:
	return controller is ControllerPlayer

func take_control(c: Controller = null):
	(c if c else Controllers.player).controllable = self

func _control_started():
	print("[%s controls %s]" % [controller.name, name])
	control_started.emit()

func _control_ended():
	control_ended.emit()

func _mount_started():
	mount_started.emit()

func _mount_ended():
	mount_ended.emit()

func is_controlled() -> bool:
	return get_controller() != null

func get_controller() -> Controller:
	for con in Controllers.controllers:
		if con.controllable == self:
			return con
	return null
