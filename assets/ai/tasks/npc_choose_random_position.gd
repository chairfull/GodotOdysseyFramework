@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(_delta: float) -> Status:
	var pos: Vector3 = agent.global_position
	if node.target:
		pos.x = node.target.global_position.x
		pos.z = node.target.global_position.z
	pos.x += randf_range(-1.0, 1.0)
	pos.z += randf_range(-1.0, 1.0)
	node.get_node("%cursor").global_position = pos
	blackboard.set_var(&"position", pos)
	return SUCCESS

func _generate_name() -> String:
	return "Choose Random Position"
