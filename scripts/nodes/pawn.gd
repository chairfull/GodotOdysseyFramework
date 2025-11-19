@icon("res://addons/odyssey/icons/pawn.svg")
class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal controlled(con: PlayerController)
signal uncontrolled(con: PlayerController)
signal gained_rider()
signal lost_rider()
#signal mounted()
#signal unmounted()

@export var behavior: BTPlayer
@export var mount_interact: Interactive ## Interactive that initiates this Pawn being mounted by another.
@export var unmount_area: Area3D ## Area that must be clear for the rider to unmount.
var _rider: Pawn
var _controller: PlayerController
var _riding: Pawn

func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	if name == "player":
		Controllers.player.set_pawn.call_deferred(self)
	
	if mount_interact:
		mount_interact.interacted.connect(_rider_interacted)

func _process(_delta: float) -> void:
	DebugDraw3D.draw_text(global_position + Vector3.UP * 2.0, "Rider: %s\nController: %s\nRiding: %s" % [_rider, _controller, _riding])

func can_unmount() -> bool:
	if unmount_area:
		if unmount_area.get_overlapping_bodies().size() > 0:
			return false
	return true

func _rider_interacted(pawn: Pawn, form: Interactive.Form) -> void:
	match form:
		Interactive.Form.INTERACT:
			mount_rider.call_deferred(pawn)
		Interactive.Form.INTERACT_ALT:
			print("Alter Interact...")

func mount_rider(new_rider: Pawn) -> void:
	if _rider:
		dismount_rider()
	
	mount_interact.enabled = false
	
	_rider = new_rider
	new_rider._riding = self
	_gained_rider()
	
	# Transfer control.
	if new_rider._controller:
		new_rider._controller.set_pawn(self)

func dismount_rider() -> void:
	if not _rider:
		return
	
	_lost_rider()
	
	var old_rider := _rider
	old_rider._riding = null
	_rider = null
	
	# Transfer control.
	if _controller:
		_controller.set_pawn(old_rider)
	
	mount_interact.enabled = true

func _controlled() -> void:
	controlled.emit()
	if behavior:
		behavior.restart()
	
func _uncontrolled() -> void:
	uncontrolled.emit()
	if behavior:
		behavior.restart()

func _gained_rider() -> void:
	gained_rider.emit()

func _lost_rider() -> void:
	lost_rider.emit()
#
#func _mounted() -> void:
	#mounted.emit()
#
#func _unmounted() -> void:
	#unmounted.emit()

func is_controlled() -> bool: return _controller != null
func is_ridden() -> bool: return _rider != null
func is_riding() -> bool: return _riding != null

func is_action_pressed(action: StringName, exact_match := false) -> bool:
	return _controller.is_action_pressed(action, exact_match)

func is_action_released(action: StringName, exact_match := false) -> bool:
	return _controller.is_action_released(action, exact_match)

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
	_controller.get_viewport().set_input_as_handled()

## Called by BehaviorTree when this node is controlled by a Controller.
func _update_as_controlled(_delta: float) -> void:
	pass
