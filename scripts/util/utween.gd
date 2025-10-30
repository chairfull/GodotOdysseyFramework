class_name UTween extends RefCounted

static func _create(node: Node, tween_id: StringName) -> Tween:
	var tween: Tween = node.get_meta(tween_id) if node.has_meta(tween_id) else null
	if tween: tween.kill()
	tween = node.create_tween()
	node.set_meta(tween_id, tween)
	tween.finished.connect(func(): node.set_meta(tween_id, null))
	return tween
	
static func interp(node: Node, meth: Callable, duration := 1.0, tween_id := &"_tween", trans := Tween.TRANS_SINE) -> Tween:
	var tween := _create(node, tween_id)
	tween.set_trans(trans)
	tween.tween_method(meth, 0.0, 1.0, duration)
	return tween
	
static func parallel(node: Node, props: Dictionary, duration := 1.0, tween_id := &"_tween", trans := Tween.TRANS_SINE) -> Tween:
	var tween := _create(node, tween_id)
	tween.set_parallel(true)
	tween.set_trans(trans)
	for prop: String in props:
		if "/" in prop:
			var parts := prop.rsplit("/", true, 1)
			var child := node.get_node(parts[0])
			tween.tween_property(child, parts[1], props[prop], duration)
		elif prop.begins_with("%"):
			var parts := prop.split(":", true, 1)
			var child := node.get_node(parts[0])
			tween.tween_property(child, parts[1], props[prop], duration)
		else:
			tween.tween_property(node, prop, props[prop], duration)
	return tween
