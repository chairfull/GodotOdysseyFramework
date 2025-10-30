extends BTAction

func _tick(_delta: float) -> Status:
	var pos: Vector3 = agent.global_position
	pos.x += randf_range(-1.0, 1.0)
	pos.z += randf_range(-1.0, 1.0)
	blackboard.set_var(&"position", pos)
	return SUCCESS
