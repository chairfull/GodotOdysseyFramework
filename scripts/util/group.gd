class_name Group extends RefCounted

static func all(group: StringName) -> Array[Node]:
	return Global.get_tree().get_nodes_in_group(group)

static func first(group: StringName) -> Node:
	return Global.get_tree().get_first_node_in_group(group)

static func named(group: StringName, name: String) -> Node:
	for node in Global.get_tree().get_nodes_in_group(group):
		if node.name == name:
			return node
	return null

static func do(group: StringName, fnc: Callable):
	for node in Global.get_tree().get_nodes_in_group(group):
		fnc.call(node)

static func queue_free(group: StringName):
	for node in Global.get_tree().get_nodes_in_group(group):
		node.queue_free()

## Returns a dict of nodes where keys are their names.
static func dict(group: StringName) -> Dictionary[StringName, Node]:
	var out: Dictionary[StringName, Node]
	for node in Global.get_tree().get_nodes_in_group(group):
		out[node.name] = node
	return out
