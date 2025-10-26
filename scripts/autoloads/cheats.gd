extends Node

var infinite_jumping := true ## Enable infinite jumping.

func _ready() -> void:
	var dir := "res://scripts/cheats"
	for path in DirAccess.get_files_at(dir):
		if path.get_extension() in ["gd", "gdc"]:
			var full_path := dir.path_join(path)
			var _script: GDScript = load(full_path)
			
