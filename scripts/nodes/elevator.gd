extends Pawn

@onready var origin: Vector3 = global_position
@onready var target: Vector3 = get_node("target").global_position

#var _anim := 0.0
#
#func _physics_process(delta: float) -> void:
	#_anim += delta
	#if mount.is_mounted():
		#global_position = global_position.slerp(lerp(origin, target, absf(sin(_anim))), 10.0 * delta)
	#else:
		#global_position = global_position.move_toward(origin, 5.0 * delta)
#
#func _can_interact(_con: Controllable) -> bool:
	#return not mount.is_mounted()
#
#func _interacted(con: Controllable):
	#if mount.is_mounted():
		#pass
	#else:
		#mount.controllable = con
