@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(delta: float) -> Status:
	if node.is_stuck():
		node.movement = Vector2.ZERO
		return FAILURE
	
	var target_position: Vector3 = blackboard.get_var(&"target_position", Vector3.ZERO)
	var dif := target_position - node.global_position
	dif.y = 0.0
	var dist := dif.length()
	if dist > 0.01:
		node.movement = Vector2(dif.x, dif.z).normalized() * minf(dist, 1.0)
		node.lerp_direction(delta)
		return RUNNING
	
	node.movement = Vector2.ZERO
	blackboard.set_var(&"move_to_target", false)
	return SUCCESS

func _generate_name() -> String:
	return "Move To Target"
