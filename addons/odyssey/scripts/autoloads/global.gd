extends Node

signal added_to_group(node: Node, id: StringName)
signal removed_from_group(node: Node, id: StringName)

var view_size: Vector2:
	get: return Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))

func group_add(node: Node, id: StringName) -> void:
	node.add_to_group(id)
	added_to_group.emit(node, id)

func group_remove(node: Node, id: StringName) -> void:
	node.remove_from_group(id)
	removed_from_group.emit(node, id)

func group_assign(list: Array, id: StringName) -> void:
	list.assign(get_tree().get_nodes_in_group(id))

func wait(time: float, method: Callable) -> Signal:
	var sig := get_tree().create_timer(time).timeout
	sig.connect(method)
	return sig

func change_scene(next_scene: Variant):
	var trans := Assets.create_scene(&"transition", self)
	await trans.fade_out()
	if next_scene is PackedScene:
		get_tree().change_scene_to_packed(next_scene)
	elif next_scene is String:
		get_tree().change_scene_to_file(next_scene)
	await trans.fade_in()
	remove_child(trans)
	trans.queue_free()
