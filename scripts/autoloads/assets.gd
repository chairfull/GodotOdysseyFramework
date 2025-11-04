extends Node

var assets: AssetsDB

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

func create_prefab(id: StringName, parent: Variant = null, props := {}) -> Node:
	if not id in assets.prefabs:
		push_error("No %s in prefabs. %s." % [id, assets.prefabs.values()])
		return null
	var full_path := "res://scenes/prefabs".path_join(assets.prefabs[id])
	var node: Node = load(full_path).instantiate()
	node.name = id
	
	if parent is Node:
		parent.add_child(node)
	elif parent == true:
		parent.add_child(get_tree().current_scene)
	
	for prop in props:
		if prop in node:
			node[prop] = props[prop]
	return node
