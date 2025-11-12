@tool
class_name EditorRebuildAssetDB extends EditorScript

func _run() -> void:
	var ass := AssetsDB.new()
	ass.reload()
	ResourceSaver.save(ass, "res://assets/assets.tres")
	EditorInterface.get_resource_filesystem().scan()
	EditorInterface.get_resource_filesystem().update_file("res://assets/assets.tres")
	EditorInterface.get_resource_filesystem().reimport_files(["res://assets/assets.tres"])
