extends Node

func _ready() -> void:
	var dir := "res://scrips/cheats"
	for path in DirAccess.get_files_at(dir):
		if path.get_extension() in ["gd", "gdc"]:
			var full_path := dir.path_join(path)
			var script: GDScript = load(full_path)
			
