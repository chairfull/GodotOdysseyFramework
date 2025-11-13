@icon("res://addons/odyssey/icons/pawn.svg")
class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal controlled(con: Controller)
signal uncontrolled(con: Controller)
signal gained_rider(rider_pawn: Pawn)
signal lost_rider(rider_pawn: Pawn)
#signal started_riding(riding_pawn: Pawn)
#signal finished_riding(riding_pawn: Pawn)

@export var behavior: BTPlayer
@export var mount_interact: Interactive ## Interactive that initiates this Pawn being mounted by another.
@export var unmount_area: Area3D ## Area that must be clear for the rider to unmount.
var rider: Pawn: set=set_rider ## Set internally. TODO: Set from scene.
var controller: Controller
var riding: Pawn#: set=set_mount ## What we are riding.

func _init() -> void:
	add_to_group(&"Pawn")

func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	if name == "player":
		Controllers.player.set_pawn.call_deferred(self)
	#elif node.name.begins_with("npc_"):
		#Controllers.get_or_create_npc(node.name).set_pawn.call_deferred(self)
	
	if mount_interact:
		mount_interact.interacted.connect(_rider_interacted)

func can_unmount() -> bool:
	if unmount_area:
		if unmount_area.get_overlapping_bodies().size() > 0:
			return false
	return true

func kick_rider():
	set_rider(null)

func _rider_interacted(pawn: Pawn, _form: Interactive.Form):
	set_rider(pawn)

func get_controller_recursive() -> Controller:
	return rider.controller if rider else controller

func _controlled(con: Controller) -> void:
	print("[%s controls %s]" % [con.name, name])
	if behavior:
		behavior.restart()
	controller = con
	controlled.emit(con)

func _uncontrolled(con: Controller) -> void:
	if behavior:
		behavior.restart()
	uncontrolled.emit(con)
	controller = null

func _gained_rider(_rider_pawn: Pawn) -> void: pass
func _lost_rider(_rider_pawn: Pawn) -> void: pass

func is_controlled() -> bool: return controller != null
func is_ridden() -> bool: return rider != null
func is_riding() -> bool: return riding != null

#func set_frozen(f):
	#if frozen == f: return
	#if frozen: unfroze.emit()
	#frozen = f
	#if frozen: froze.emit()

#func set_mount(m: Pawn):
	#if _mount == m: return
	#if _mount:
		#if not can_unmount():
			#push_error("Can't unmount.")
			#return
		#unmounted.emit(_mount)
	#_mount = m
	#if _mount: mounted.emit(_mount)

func set_rider(r: Pawn):
	if rider == r: return
	if rider: # Unmount old.
		# Take back control.
		if is_controlled():
			controller.set_pawn.call_deferred(rider)
		rider.riding = null
		_lost_rider(rider)
		lost_rider.emit(rider)
	rider = r
	if rider: # Remound new.
		# Give control to rider.
		if rider.is_controlled():
			rider.controller.set_pawn.call_deferred(self)
		rider.riding = self
		_gained_rider(rider)
		gained_rider.emit(rider)
	
func is_action_pressed(action: StringName, exact_match := false) -> bool:
	return controller.is_action_pressed(action, exact_match)

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

## Called by BehaviorTree when this node is controlled by a Controller.
func _update_as_controlled(_delta: float) -> void:
	pass
