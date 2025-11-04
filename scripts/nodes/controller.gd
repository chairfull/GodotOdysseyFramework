class_name Controller extends Node

@export var index := 0 ## For multiplayer.
@export var pawn: Pawn: set=set_pawn

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func set_pawn(target: Pawn):
	if pawn == target: return
	if pawn:
		pawn.set_controller.call_deferred(null)
		_ended()
	pawn = target
	pawn.set_controller.call_deferred(self)
	_started.call_deferred()

func is_player() -> bool:
	return self is ControllerPlayer

func get_move_vector() -> Vector2:
	return Vector2.ZERO

func _started():
	pass

func _ended():
	pass
