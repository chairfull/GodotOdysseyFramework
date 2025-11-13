@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(delta: float) -> Status:
	node.flee(delta)
	return SUCCESS

func _generate_name() -> String:
	return "Flee"
