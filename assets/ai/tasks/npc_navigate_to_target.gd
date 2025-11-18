@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(delta: float) -> Status:
	if node.is_stuck():
		node.movement = Vector2.ZERO
		return FAILURE
	
	if blackboard.get_var(&"move_to_target"):
		var dif := node.set_movement_from_nav()
		if Vector2(dif.x, dif.z).length() > 0.01:
			node.lerp_direction(delta)
			return RUNNING
		else:
			print("Reached position!")
			blackboard.set_var(&"move_to_target", false)
			node.movement = Vector2.ZERO
	
	return SUCCESS

func _generate_name() -> String:
	return "Navigate To Target"
