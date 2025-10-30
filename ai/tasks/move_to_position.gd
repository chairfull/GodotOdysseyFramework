extends BTAction

func _tick(delta: float) -> Status:
	var target: Vector3 = blackboard.get_var(&"position", Vector3.ZERO)
	if agent.move(target, delta):
		return RUNNING
	return SUCCESS
