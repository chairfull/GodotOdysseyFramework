@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(delta: float) -> Status:
	if node.is_stuck():
		node.movement = Vector2.ZERO
		return FAILURE
	
	var target: Vector3 = blackboard.get_var(&"position", Vector3.ZERO)
	var dif := target - node.global_position
	dif.y = 0.0
	var dist := dif.length()
	if dist > 0.1:
		node.movement = Vector2(dif.x, dif.z).normalized() * minf(dist, 1.0)
		node.lerp_direction(delta)
		return RUNNING
	node.movement = Vector2.ZERO
	return SUCCESS

func _generate_name() -> String:
	return "Move To Position"
