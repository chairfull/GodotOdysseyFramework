@tool
extends BTAction

var pawn: Pawn

func _enter() -> void:
	pawn = agent

func _tick(delta: float) -> Status:
	if pawn.is_controlled():
		pawn._update_as_controlled(delta)
		return RUNNING
	return SUCCESS

func _generate_name() -> String:
	return "Pawn As Controlled"
