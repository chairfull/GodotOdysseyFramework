@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(_delta: float) -> Status:
	var targ: Node3D = blackboard.get_var(&"target_node")
	
	if targ and targ is Pawn:
		var mount: Pawn = targ
		if not node.is_riding():
			mount.mount_rider(node)
		return RUNNING
	
	return SUCCESS

func _generate_name() -> String:
	return "Mounted"
