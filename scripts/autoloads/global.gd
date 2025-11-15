@tool
extends Node

var view_size: Vector2:
	get: return Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))

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
