class_name Controller extends Node

enum ControlType { NONE, PLAYER, NPC }

@export var index := 0 ## For multiplayer.
@export var pawn: Pawn: set=set_pawn

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func set_pawn(target: Pawn):
	if pawn == target: return
	if pawn:
		pawn._unposessed()
		_ended()
	pawn = target
	pawn._posessed(self)
	_started.call_deferred()

func get_control_type() -> ControlType:
	if is_player(): return ControlType.PLAYER
	if is_npc(): return ControlType.NPC
	return ControlType.NONE

func is_npc() -> bool: return self is ControllerNPC
func is_player() -> bool: return self is ControllerPlayer

func get_move_vector() -> Vector2:
	return Vector2.ZERO

func _started():
	print("Control Started ", pawn)

func _ended():
	print("Control Ended ", pawn)
