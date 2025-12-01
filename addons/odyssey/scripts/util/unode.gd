class_name UNode extends RefCounted

static func remove_children(n: Node, qfree := true) -> Node:
	for child in n.get_children():
		n.remove_child(child)
		if qfree:
			child.queue_free()
	return n
