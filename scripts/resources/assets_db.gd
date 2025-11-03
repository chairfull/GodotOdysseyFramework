@tool
class_name AssetsDB extends Resource

@export_tool_button("Update") var _tb_update := _update

@export var audio: Dictionary[StringName, String]
@export var music: Dictionary[StringName, String]
@export var prefabs: Dictionary[StringName, String]

func _update() -> void:
	_scan_dir(prefabs, "res://scenes/prefabs/", "res://scenes/prefabs", [ "tscn", "scn" ])
	_scan_dir(audio, "res://assets/audio/", "res://assets/audio", [ "mp3", "wav", "ogg" ])
	_scan_dir(music, "res://assets/music/", "res://assets/music")
	print("Prefabs: %s, Audio: %s, Music: %s" % [len(prefabs), len(audio), len(music)])


func _scan_dir(paths: Dictionary[StringName, String], head: String, dir: String, ext: Array[String] = []):
	for subdir in DirAccess.get_directories_at(dir):
		_scan_dir(paths, head, dir.path_join(subdir), ext)
	
	for file in DirAccess.get_files_at(dir):
		if file.get_extension() in ext:
			var id := file.get_basename()
			paths[id] = dir.path_join(file).trim_prefix(head)
