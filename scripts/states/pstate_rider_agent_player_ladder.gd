class_name PStateRiderAgentPlayerLadder extends PStateRiderAgentPlayer

func _physics_process(delta: float) -> void:
	var move := get_player_controller().get_move_vector()
	pawn.rider.global_transform.origin.y -= move.y * delta * 1.0
	
	var dif := pawn.rider.global_transform.origin.y - pawn.global_transform.origin.y
	if dif > 4.5:
		kick_rider()
