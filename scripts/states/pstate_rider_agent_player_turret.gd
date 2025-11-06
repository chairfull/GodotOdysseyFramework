class_name PStateRiderAgentPlayerTurret extends PStateRiderAgentPlayer

var _angle := 0.0

func _process(delta: float) -> void:
	var vec := get_controller().get_move_vector()
	_angle -= vec.x * 2.0 * delta
	pawn.rotation.y = lerp_angle(pawn.rotation.y, _angle, delta * 10.0)
