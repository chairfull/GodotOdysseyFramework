@tool
@icon("res://addons/odyssey/icons/pawn.svg")
class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal posessed(con: Controller)
signal unposessed(con: Controller)
signal rider_mounted(r: Pawn)
signal rider_unmounted(r: Pawn)
signal mounted(ride: Pawn)
signal unmounted(ride: Pawn)

@export var node: Node:
	get: return node if node else self
@export var rider_interact: Interactive ## Interactive that takes control.
@export var rider_unmount_area: Area3D ## Area to scan if attempting to unmount.
var rider: Pawn: set=set_rider ## Set internally. TODO: Set from scene.
var controller: Controller
var player_controller: ControllerPlayer:
	get: return controller
var _mount: Pawn: set=set_mount ## What we are riding.

@export var states: Array[PawnState]
var _active_states: Array[PawnState]

func _init() -> void:
	add_to_group(&"Pawn")

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	
	if Engine.is_editor_hint(): return
	
	if node.name == "player":
		Controllers.player.set_pawn.call_deferred(self)
	elif node.name.begins_with("npc_"):
		Controllers.get_or_create_npc(node.name).set_pawn.call_deferred(self)
	
	if rider_interact:
		rider_interact.interacted.connect(_rider_interacted)
	
	for state in states:
		state.set_pawn(self)

func add_state(s: PawnState):
	states.append(s)
	s.set_pawn(self)

func enable_state(s: PawnState):
	if s in _active_states: return
	_active_states.append(s)
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)

func disable_state(s: PawnState):
	if not s in _active_states: return
	_active_states.erase(s)
	if _active_states.size() > 0: return
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)

func can_unmount() -> bool:
	if rider_unmount_area:
		if rider_unmount_area.get_overlapping_bodies().size() > 0:
			return false
	return true

func _process(delta: float) -> void:
	for s in _active_states:
		s._process(delta)

func _physics_process(delta: float) -> void:
	for s in _active_states:
		s._physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	for s in _active_states:
		s._unhandled_input(event)

func _rider_interacted(pawn: Pawn, _form: Interactive.Form):
	set_rider(pawn)

func get_controller_recursive() -> Controller:
	return rider.controller if rider else controller

func _posessed(con: Controller) -> void:
	print("[%s controls %s]" % [con.name, node.name])
	controller = con
	posessed.emit(con)

func _unposessed() -> void:
	unposessed.emit(controller)
	controller = null

func is_controlled() -> bool: return controller != null
func is_player() -> bool: return controller is ControllerPlayer
func is_npc() -> bool: return controller is ControllerNPC
func is_ridden() -> bool: return rider != null
func is_mounted() -> bool: return _mount != null

#func set_frozen(f):
	#if frozen == f: return
	#if frozen: unfroze.emit()
	#frozen = f
	#if frozen: froze.emit()

func set_mount(m: Pawn):
	if _mount == m: return
	if _mount:
		if not can_unmount():
			push_error("Can't unmount.")
			return
		unmounted.emit(_mount)
	_mount = m
	if _mount: mounted.emit(_mount)

func set_rider(r: Pawn):
	if rider == r: return
	if rider: # Unmount old.
		# Take back control.
		if is_controlled():
			controller.set_pawn.call_deferred(rider)
		rider._mount = null
		rider_unmounted.emit(rider)
	rider = r
	if rider: # Remound new.
		# Give control to rider.
		if rider.is_controlled():
			rider.controller.set_pawn.call_deferred(self)
		rider._mount = self
		rider_mounted.emit(rider)
	
