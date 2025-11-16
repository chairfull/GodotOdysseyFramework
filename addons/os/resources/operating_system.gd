@abstract class_name OperatingSystem extends Resource

@export var dir_real := "res://assets/dummy_os"
@export var active_user_id := ""
@export var active_disk_id := ""
var active_disk: OSDisk
var active_user: OSUser

"""
user://
	ROOT
		DISK
			apps
			users
				user1
					docs
						pics
						dlds
					appdata
		DISK (2)
"""

func get_real_path(path: String) -> String:
	return dir_real.path_join(path)

func move_file(path: String) -> void:
	pass

func get_file(path: String) -> OSFile:
	return null

func get_disk_dir() -> String: return dir_real.path_join(active_disk_id)
func get_user_dir() -> String: return get_disk_dir().path_join(active_user_id)
func get_apps_dir() -> String: return get_disk_dir().path_join("apps")

func get_disks() -> Dictionary[StringName, OSDisk]:
	var out: Dictionary[StringName, OSDisk]
	out.assign(get_dirs_at(get_disk_dir(), OSDisk))
	return out

func get_users() -> Dictionary[StringName, OSUser]:
	var out: Dictionary[StringName, OSUser]
	out.assign(get_dirs_at(get_user_dir(), OSUser))
	return out
	
func get_apps() -> Dictionary[StringName, OSApp]:
	var out: Dictionary[StringName, OSApp]
	out.assign(get_dirs_at(get_apps_dir(), OSApp))
	return out

static func get_files_at(dir: String, script_class := OSFile) -> Dictionary[StringName, OSFile]:
	var out: Dictionary[StringName, OSFile]
	for id in DirAccess.get_files_at(dir):
		var path := dir.path_join(id)
		if is_path_an_allowed_item(path):
			continue
		var info := get_info_at(path)
		var item := script_class.new(info)
		out[id] = item
	return out

static func get_dirs_at(dir: String, script_class := OSDir) -> Dictionary[StringName, OSDir]:
	var out: Dictionary[StringName, OSDir]
	for id in DirAccess.get_directories_at(dir):
		var path := dir.path_join(id)
		var info := get_info_at(path)
		var item := script_class.new(info)
		out[id] = item
	return out

static func is_path_an_allowed_item(path: String) -> bool:
	if path.ends_with(".info.yaml"): return false
	if path.ends_with(".info.json"): return false
	return true

static func get_info_at(at: String) -> Dictionary:
	var yaml_path := at + ".info.yaml"
	if FileAccess.file_exists(yaml_path):
		var yaml_result := YAML.load_file(yaml_path)
		var yaml_data: Variant = yaml_result.get_data()
		return yaml_data if yaml_data is Dictionary else {}
	var json_path := at + ".info.json"
	if FileAccess.file_exists(json_path):
		var json_str := FileAccess.get_file_as_string(json_path)
		var json_data: Variant = JSON.parse_string(json_str)
		return json_data if json_data is Dictionary else {}
	return {}
	
