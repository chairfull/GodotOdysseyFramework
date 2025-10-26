extends Node3D

@export var screen: StringName
@onready var interactive: Interactive = %interactive
@onready var mount: Mount = %mount
@onready var origin: Vector3 = global_position
@onready var target: Vector3 = get_node("target").global_position

var _anim := 0.0

func _ready() -> void:
	interactive.interacted.connect(_interacted)
	interactive.can_interact = _can_interact
	mount.mounted.connect(_mounted)
	mount.unmounted.connect(_unmounted)
	#_enable(false)
#
#func _enable(en := true):
	#set_process(en)
	#set_physics_process(en)
	#set_physics_process_internal(en)

func _mounted():
	#_enable(true)
	pass
	
func _unmounted():
	#_enable(false)
	pass

func _physics_process(delta: float) -> void:
	_anim += delta
	if mount.is_mounted():
		global_position = global_position.slerp(lerp(origin, target, absf(sin(_anim))), 10.0 * delta)
	else:
		global_position = global_position.move_toward(origin, 5.0 * delta)

func _can_interact(_con: Controllable) -> bool:
	return not mount.is_mounted()

func _interacted(con: Controllable):
	if mount.is_mounted():
		pass
	else:
		mount.controllable = con
