@icon("res://addons/odyssey/icons/control.svg")
class_name PawnState extends Node3D
## Child of Pawn.

@export var pawn: Pawn:
	get: return pawn if pawn else get_parent()
@export var hud: StringName ## If player, scene added to hud.
@export var cinematic: StringName ## Cinematic to play.
var _enabled := false
var _controller: Controller

@export_group("Process", "process_")
@export var process_on_posessed := true
@export var process_on_rider := false ## Other riding me.
@export var process_on_mounted := false ## I'm riding other.
@export var process_if_player := true
@export var process_if_npc := false

@export_group("Rider")
@export var freeze_rider := true
@export var reparent_rider := true
@export var animate_rider := true
@export var animation_enter := &"Sitting_Idle"
@export var animation_exit := &"Standing"
@export var tween_position := true ## Animation controllable position.
@export var tween_rotation := true ## A
@export var tween_time := 0.5
var _rider: Pawn
var _rider_last_parent: Node
var _froze_rider: bool

func _ready() -> void:
	if Engine.is_editor_hint(): return
	process_mode = Node.PROCESS_MODE_DISABLED
	if not pawn: return
	pawn.froze.connect(_frozen)
	pawn.unfroze.connect(_unfrozen)
	if process_on_rider:
		pawn.rider_mounted.connect(_rider_mounted)
		pawn.rider_unmounted.connect(_rider_unmounted)
	if process_on_mounted:
		pawn.mounted.connect(_mounted)
		pawn.unmounted.connect(_unmounted)
	if process_on_posessed:
		pawn.posessed.connect(_posessed)
		pawn.unposessed.connect(_unposessed)

func _frozen():
	process_mode = Node.PROCESS_MODE_DISABLED
	_froze_rider = true

func _unfrozen():
	if _enabled:
		process_mode = Node.PROCESS_MODE_INHERIT
		_froze_rider = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"exit"):
		pawn.rider = null
		get_viewport().set_input_as_handled()

# For when something mounts us
func _can_enable_as_vehicle(rider: Pawn) -> bool:
	if process_if_player and not rider.is_player_controlled(): return false
	if process_if_npc and rider.is_player_controlled(): return false
	return true

# For when we mount something
func _can_enable_as_rider() -> bool:
	var con := pawn.get_controller_recursive()
	if process_if_player and not con.is_player(): return false
	if process_if_npc and con.is_player(): return false
	return true

func _rider_mounted(rider: Pawn) -> void:
	if not _can_enable_as_vehicle(rider): return
	
	_rider = rider
	_controller = rider.controller
	
	if reparent_rider:
		_rider_last_parent = _rider.get_parent()
		_rider.reparent(self)
	
	_enable()

func _rider_unmounted(rider: Pawn) -> void:
	if _rider != rider: return
	
	if _rider_last_parent:
		_rider.reparent(_rider_last_parent)
		_rider_last_parent = null
	
	_disable()
	
	_rider = null
	_controller = null

func _mounted(_mount: Pawn) -> void:
	if _can_enable_as_rider():
		_enable()

func _unmounted(_mount: Pawn) -> void:
	if _enabled and _can_enable_as_rider():
		_disable()

func _posessed(con: Controller):
	if not _enabled:
		_controller = con
		_enable()

func _unposessed(con: Controller):
	if _enabled and _controller == con:
		_disable()
		_controller = null

func _enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	_enabled = true
	
	if pawn.is_player_controlled():
		if hud:
			pawn.player_controller.show_hud(hud)
	
	if freeze_rider and _rider:
		_rider.frozen = true
		_froze_rider = true
	
	if _rider is Humanoid:
		var human: Humanoid = _rider as Humanoid
		if animate_rider and animation_enter:
			human.trigger_animation.emit(animation_enter)
		if tween_position or tween_rotation:
			human.fix_direction()
			var dir_from := human.rotation.y
			var dir_to := 0.0
			var pos_from := human.position
			var pos_to := Vector3.ZERO
			UTween.interp(human, 
				func(x: float):
					if tween_rotation:
						human.direction = lerp_angle(dir_from, dir_to, x)
					if tween_position:
						human.position = lerp(pos_from, pos_to, x),
				tween_time)
			print("Rotate out...")

func _disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	_enabled = false
	
	if is_player():
		if hud:
			get_player_controller().hide_hud(hud)
	
	if _rider is Humanoid:
		var human: Humanoid = _rider as Humanoid
		human.fix_direction()
		if animate_rider and animation_exit:
			human.trigger_animation.emit(animation_exit)
			if _froze_rider:
				Global.wait(0.8, func():
					human.frozen = false
					_froze_rider = false
					) ## Wait a smidge for animation to play.
		elif _froze_rider:
			human.frozen = false
			_froze_rider = false
	
	elif _froze_rider and _rider:
		_rider.frozen = false
		_froze_rider = false

func get_controller() -> Controller:
	return _controller#pawn.get_controller_recursive()

func get_player_controller() -> ControllerPlayer:
	return get_controller() as ControllerPlayer

func is_player() -> bool:
	var con := get_controller()
	return con and con.is_player()

func is_first_person() -> bool:
	return get_player_controller().view_state == ControllerPlayer.ViewState.FirstPerson

func is_third_person() -> bool:
	return get_player_controller().view_state == ControllerPlayer.ViewState.ThirdPerson

func _get_configuration_warnings() -> PackedStringArray:
	if pawn == null and not get_parent() is Pawn:
		return ["No pawn reference or Pawn parent."]
	return []
