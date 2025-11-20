@tool
extends BTAction

var pawn: Pawn

func _enter() -> void:
	pawn = agent

func _tick(delta: float) -> Status:
	if not pawn.is_controlled():
		pawn._update_as_npc(delta)
		return RUNNING
	return SUCCESS

func _generate_name() -> String:
	return "Pawn As NPC"
