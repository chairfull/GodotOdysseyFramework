@icon("res://addons/odyssey/icons/pawn.svg")
class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal controlled()
signal uncontrolled()
signal gained_rider()
signal lost_rider()
signal started_riding()
signal stopped_riding()

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


func can_unmount() -> bool:
	if unmount_area:
		if unmount_area.get_overlapping_bodies().size() > 0:
			return false
	return true

func _rider_interacted(pawn: Pawn, form: Interactive.Form) -> void:
	if form == Interactive.Form.INTERACT:
		mount_rider.call_deferred(pawn)

func mount_rider(new_rider: Pawn) -> void:
	if _rider:
		dismount_rider()
	
	mount_interact.enabled = false
	
	_rider = new_rider
	new_rider._riding = self
	_rider._started_riding()
	_gained_rider()
	
	# Transfer control.
	if new_rider._controller:
		new_rider._controller.set_pawn(self)

func dismount_rider() -> void:
	if not _rider:
		return
	
	_lost_rider()
	_rider._stopped_riding()
	
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

func _started_riding() -> void:
	started_riding.emit()

func _stopped_riding() -> void:
	stopped_riding.emit()

func is_controlled() -> bool: return _controller != null
func is_ridden() -> bool: return _rider != null
func is_riding() -> bool: return _riding != null

func stop_riding() -> bool:
	if is_riding():
		_riding.dismount_rider()
		return true
	return false

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
func _update_as_player(_delta: float) -> void:
	pass

## Called by BehaviorTree when node is NOT controlled by PlayerController.
func _update_as_npc(_delta: float) -> void:
	pass
