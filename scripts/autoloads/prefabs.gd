extends Node

var paths: Dictionary[StringName, String]

func _init() -> void:
	_dirscan("res://scenes/prefabs")

func create(id: StringName, parent: Node = null, props := {}) -> Node:
	if not id in paths:
		push_error("No %s in prefabs. %s." % [id, paths.values()])
		return null
	var node: Node = load(paths[id]).instantiate()
	if parent:
		parent.add_child(node)
	for prop in props:
		if prop in node:
			node[prop] = props[prop]
	return node

func _dirscan(dir: String):
	for subdir in DirAccess.get_directories_at(dir):
		_dirscan(dir.path_join(subdir))
	
	for file in DirAccess.get_files_at(dir):
		if file.ends_with(".tscn"):
			var id := file.get_basename()
			paths[id] = dir.path_join(file)
