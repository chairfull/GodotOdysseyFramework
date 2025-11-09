extends BTAction

func _tick(delta: float) -> Status:
	agent.flee(delta)
	return SUCCESS
