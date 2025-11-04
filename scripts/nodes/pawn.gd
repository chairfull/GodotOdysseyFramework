class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal posessed(con: Controller)
signal unposessed(con: Controller)
signal rider_mounted(r: Pawn)
signal rider_unmounted(r: Pawn)
signal mounted(ride: Pawn)
signal unmounted(ride: Pawn)
signal froze()
signal unfroze()

@export var player: bool: ## The main controllable of the main controller.
	get: return is_controlled() and controller == Controllers.player
	set(c):
		if c:
			take_control.call_deferred()
		elif is_controlled():
			Controllers.player.controllable = null

@export_group("Mount")
@export var rider_interact: Interactive ## Interactive that takes control.
@export var rider: Pawn: set=set_rider ## Set internally. TODO: Set from scene.
var frozen := false: set=set_frozen
var controller: Controller: set=set_controller
var player_controller: ControllerPlayer:
	get: return controller
var _mount: Pawn: set=set_mount ## What we are riding.

func _init() -> void:
	add_to_group(&"Pawn")

func _ready() -> void:
	if rider_interact:
		rider_interact.interacted.connect(_rider_interacted)
	else:
		push_warning("No rider_interact set for %s." % self)

func _rider_interacted(pawn: Pawn, _form: Interactive.Form):
	set_rider(pawn)

func set_controller(c: Controller):
	if controller == c: return
	if controller: _unposessed(controller)
	controller = c
	if controller: _posessed(controller)

func get_controller_recursive() -> Controller:
	return rider.controller if rider else controller

func take_control(c: Controller = null):
	(c if c else Controllers.player).pawn = self

func _posessed(con: Controller) -> void:
	print("[%s controls %s]" % [controller.name, name])
	posessed.emit(con)

func _unposessed(con: Controller) -> void:
	unposessed.emit(con)

func is_controlled() -> bool: return controller != null
func is_player_controlled() -> bool: return controller is ControllerPlayer
func is_ridden() -> bool: return rider != null
func is_mounted() -> bool: return _mount != null

func set_frozen(f):
	if frozen == f: return
	if frozen: unfroze.emit()
	frozen = f
	if frozen: froze.emit()

func set_mount(m: Pawn):
	if _mount == m: return
	if _mount: unmounted.emit(_mount)
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
	
