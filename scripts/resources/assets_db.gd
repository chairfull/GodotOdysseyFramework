@tool
class_name AssetsDB extends Resource

@warning_ignore("unused_private_class_variable")
@export_tool_button("Reload") var _tb_update := reload

@export var audio: Dictionary[StringName, String]
@export var music: Dictionary[StringName, String]
@export var scenes: Dictionary[StringName, String]
@export var materials: Dictionary[StringName, String]

func reload() -> void:
	for d in [audio, music, scenes, materials]:
		d.clear()
	var old_audio := len(audio)
	var old_music := len(music)
	var old_scenes := len(scenes)
	var old_materials := len(materials)
	_scan_dir(audio, "res://assets/audio/", "res://assets/audio", [ "mp3", "wav", "ogg" ])
	_scan_dir(music, "res://assets/music/", "res://assets/music")
	_scan_dir(scenes, "res://scenes/", "res://scenes", [ "tscn", "scn" ])
	_scan_dir(materials, "res://assets/materials/", "res://assets/materials", [ "tres" ])
	
	var new_audio := len(audio)
	var new_music := len(music)
	var new_scenes := len(scenes)
	var new_materials := len(materials)
	var dif_audio := new_audio - old_audio
	var dif_music := new_music - old_music
	var dif_scenes := new_scenes - old_scenes
	var dif_materials := new_materials - old_materials
	var str_audio := "" if dif_audio == 0 else ((" [color=red]-%s[/color]" if dif_audio < 0 else " [color=green]+%s[/color]") % dif_audio)
	var str_music := "" if dif_music == 0 else ((" [color=red]-%s[/color]" if dif_music < 0 else " [color=green]+%s[/color]") % dif_audio)
	var str_scenes := "" if dif_scenes == 0 else ((" [color=red]-%s[/color]" if dif_scenes < 0 else " [color=green]+%s[/color]") % dif_audio)
	var str_materials := "" if dif_materials == 0 else ((" [color=red]-%s[/color]" if dif_materials < 0 else " [color=green]+%s[/color]") % dif_audio)
	print_rich("Prefabs: [i]%s[/i]%s, Audio: [i]%s[/i]%s, Music: [i]%s[/i]%s, Materials: [i]%s[/i]%s" % [
		new_scenes, str_scenes,
		new_audio, str_audio,
		new_music, str_music,
		new_materials, str_materials])

func _scan_dir(paths: Dictionary[StringName, String], head: String, dir: String, ext: Array[String] = []):
	for subdir in DirAccess.get_directories_at(dir):
		_scan_dir(paths, head, dir.path_join(subdir), ext)
	
	for file in DirAccess.get_files_at(dir):
		if file.get_extension() in ext:
			var id := file.get_basename()
			paths[id] = dir.path_join(file).trim_prefix(head)
