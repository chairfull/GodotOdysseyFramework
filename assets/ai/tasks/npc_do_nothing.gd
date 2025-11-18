@tool
extends BTAction

var node: CharNode

func _enter() -> void:
	node = agent

func _tick(_delta: float) -> Status:
	var movetotarg: Variant = blackboard.get_var(&"move_to_target", false)
	print("move to targ ", movetotarg)
	if movetotarg:
		return FAILURE
	return RUNNING

func _generate_name() -> String:
	return "Do Nothing"
