@tool
class_name EditorRebuildMods extends EditorScript

const MOD_DIR := "res://assets/mods"

func _run() -> void:
	for dir in DirAccess.get_directories_at(MOD_DIR):
		var mod := ModInfo.new()
		mod.load_dir(MOD_DIR.path_join(dir))
		var res_path := MOD_DIR.path_join(dir + ".tres")
		ResourceSaver.save(mod, res_path)
		var fs := EditorInterface.get_resource_filesystem()
		fs.scan.call_deferred()
		fs.update_file.call_deferred(res_path)
		fs.reimport_files.call_deferred([res_path])
