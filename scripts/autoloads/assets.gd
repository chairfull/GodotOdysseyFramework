extends AssetsBase

var assets: AssetsDB:
	get:
		if not assets:
			assets = load("res://assets/assets.tres")
		return assets

func _init() -> void:
	assets = load("res://assets/assets.tres")

func get_material(id: StringName) -> Material:
	if not id in assets.materials:
		push_error("No %s in materials. %s" % [id, assets.materials.keys()])
		return null
	var full_path := "res://assets/materials".path_join(assets.materials[id])
	return load(full_path)
	
func create_audio_player(id: StringName) -> Node:
	if not id in assets.audio:
		push_error("No %s in audio." % [id])
		return null
	var full_path := "res://assets/audio".path_join(assets.audio[id])
	var stream := load(full_path)
	var player := AudioStreamPlayer3D.new()
	player.stream = stream
	return player

func create_scene(scene_id: StringName, parent: Variant = null, props := {}) -> Node:
	var full_path: String
	if scene_id.begins_with("uid://"):
		full_path = scene_id
	elif scene_id in assets.scenes:
		full_path = "res://scenes".path_join(assets.scenes[scene_id])
	else:
		push_error("No %s in scenes. %s." % [scene_id, assets.scenes.values()])
		return null
	var node: Node = load(full_path).instantiate()
	var id := node.scene_file_path.get_basename().get_file()
	node.name = id
	
	if parent is Node:
		parent.add_child(node)
	elif parent == true:
		get_tree().current_scene.add_child(node)
	
	UObj.set_properties(node, props, false)
	return node
